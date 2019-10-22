(module interp (lib "eopl.ss" "eopl")
  
  ;; interpreter for the EXPLICIT-REFS language

  (require "drscheme-init.scm")

  (require "lang.scm")
  (require "data-structures.scm")
  (require "environments.scm")
  (require "store.scm")
  
  (provide value-of-program value-of instrument-let instrument-newref)

;;;;;;;;;;;;;;;; switches for instrument-let ;;;;;;;;;;;;;;;;

  (define instrument-let (make-parameter #f))

  ;; say (instrument-let #t) to turn instrumentation on.
  ;;     (instrument-let #f) to turn it off again.

;;;;;;;;;;;;;;;; the interpreter ;;;;;;;;;;;;;;;;

  ;; value-of-program : Program -> ExpVal
  ;; Page: 110
  (define value-of-program 
    (lambda (pgm)
      (initialize-store!)               ; new for explicit refs.
      (cases program pgm
        (a-program (exp1)
          (value-of exp1 (init-env) the-store)))))

  ;; value-of : Exp * Env -> ExpVal
  ;; Page: 113
  (define value-of
    (lambda (exp env store)
      (cases
       expression exp

        ;\commentbox{ (value-of (const-exp \n{}) \r) = \n{}}
       (const-exp (num) (an-answer (num-val num) store))

        ;\commentbox{ (value-of (var-exp \x{}) \r) = (apply-env \r \x{})}
       (var-exp (var) (an-answer (apply-env env var) store))

        ;\commentbox{\diffspec}
       (diff-exp
	(exp1 exp2)
	(cases answer (value-of exp1 env store)
	       (an-answer
		(val1 store1)
		(cases answer (value-of exp2 env store1)
		       (an-answer
			(val2 store2)
			(an-answer
			 (num-val
			  (- (expval->num val1)
			     (expval->num val2)))
			 store2))))))
      
        ;\commentbox{\zerotestspec}
       (zero?-exp
	(exp1)
	(cases answer (value-of exp1 env store)
	       (an-answer
		(val1 store1)
		(an-answer
		 (if (zero? (expval->num val1))
		     (bool-val #t)
		     (bool-val #f))
		 store1))))
              
        ;\commentbox{\ma{\theifspec}}
	(if-exp (exp1 exp2 exp3)
		(cases answer (value-of exp1 env store)
		       (an-answer (val new-store)
				  (if (expval->bool val)
				      (value-of exp2 env new-store)
				      (value-of exp3 env new-store)))))
	
        ;\commentbox{\ma{\theletspecsplit}}
	(let-exp
	 (var exp1 body)
	 (cases answer (value-of exp1 env store)
		(an-answer
		 (val1 store1)
		 (value-of body
			   (extend-env var val1 env)
			   store1))))
        
        (proc-exp
	 (vars body)
	 (an-answer
          (proc-val (procedure vars body env))
	  store))

	(call-exp
	 (rator rands)
	 (cases answer (value-of rator env store)
		(an-answer
		 (p-val p-store)
		 (let ((proc (expval->proc p-val)))
		   (call-with-values
		       (lambda ()
			 (let loop ([rands rands]
				    [args '()]
				    [new-store p-store])
			   (if (null? rands)
			       (values args new-store)
			       (cases
				answer (value-of (car rands) env new-store)
				(an-answer
				 (val sto)
				 (loop (cdr rands)
				       (append args (list val))
				       sto))))))
		     (lambda (args new-store)
		       (apply-procedure proc args new-store)))))))

        (letrec-exp (p-names b-vars p-bodies letrec-body)
          (value-of letrec-body
		    (extend-env-rec* p-names b-vars p-bodies env)
		    store))

        (begin-exp (exp1 exps)
          (letrec 
            ((value-of-begins
              (lambda (e1 es new-store)
		(cases answer (value-of e1 env new-store)
		       (an-answer
			(v1 store1)
			(if (null? es)
			    (an-answer v1 store1)
			    (value-of-begins (car es) (cdr es) store1)))))))
            (value-of-begins exp1 exps store)))

        (newref-exp
	 (exp1)
	 (cases answer (value-of exp1 env store)
		(an-answer (v1 store1)
			   (an-answer
			    (ref-val (newref v1))
			    store1))))

	(deref-exp
	 (exp1)
	 (cases answer (value-of exp1 env store)
		(an-answer (v1 new-store)
			   (let ((ref1 (expval->ref v1)))
			     (an-answer (deref ref1) new-store)))))

	(setref-exp
	 (exp1 exp2)
	 (cases answer (value-of exp1 env store)
		(an-answer
		 (v1 store1)
		 (let ([ref (expval->ref v1)])
		   (cases answer (value-of exp2 env store1)
			  (an-answer
			   (v2 store2)
			   (begin
			     (setref! ref v2)
			     (an-answer v2 store2))))))))
        )))

  ;; apply-procedure : Proc * ExpVal -> ExpVal
  ;; 
  ;; uninstrumented version
  ;;   (define apply-procedure
  ;;    (lambda (proc1 arg)
  ;;      (cases proc proc1
  ;;        (procedure (bvar body saved-env)
  ;;          (value-of body (extend-env bvar arg saved-env))))))

  ;; instrumented version
   (define apply-procedure
    (lambda (proc1 vals store)
      (cases proc proc1
             (procedure
	      (vars body saved-env)
	      (let loop ([vars vars]
			 [vals vals]
			 [env saved-env])
		(if (null? vars)
		    (if (null? vals)
			(begin
			  (when (instrument-let)
			    (begin
			      (eopl:printf
			       "entering body of proc ~s with env =~%"
			       vars)
			      (pretty-print (env->list saved-env))
			      (eopl:printf "store =~%")
			      (pretty-print (store->readable (get-store-as-list)))
			      (eopl:printf "~%")))
			  (value-of body env store))
			(eopl:error 'proc "too many args"))
		    (if (null? vals)
			(eopl:error 'proc "too few args")
			(loop (cdr vars) (cdr vals)
			      (extend-env (car vars) (car vals) env)))))))))

  ;; store->readable : Listof(List(Ref,Expval)) 
  ;;                    -> Listof(List(Ref,Something-Readable))
  (define store->readable
    (lambda (l)
      (map
        (lambda (p)
          (cons
            (car p)
            (expval->printable (cadr p))))
        l)))
 
  )
  


  
