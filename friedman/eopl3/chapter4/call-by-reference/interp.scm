(module interp (lib "eopl.ss" "eopl")
  
  ;; interpreter for the CALL-BY-REFERENCE language

  (require "drscheme-init.scm")

  (require "lang.scm")
  (require "data-structures.scm")
  (require "environments.scm")
  (require "store.scm")
  (require "pairvals.scm")
  (require "arrayvals.scm")

  (provide value-of-program value-of instrument-let instrument-newref)

;;;;;;;;;;;;;;;; switches for instrument-let ;;;;;;;;;;;;;;;;

  (define instrument-let (make-parameter #f))

  ;; say (instrument-let #t) to turn instrumentation on.
  ;;     (instrument-let #f) to turn it off again.


;;;;;;;;;;;;;;;; the interpreter ;;;;;;;;;;;;;;;;

  ;; value-of-program : Program -> ExpVal
  (define value-of-program 
    (lambda (pgm)
      (initialize-store!)             
      (cases program pgm
        (a-program (body)
          (value-of body (init-env))))))

  ;; value-of : Exp * Env -> ExpVal
  ;; Page: 132
  (define value-of
    (lambda (exp env)
      (cases expression exp

        (const-exp (num) (num-val num))

        (var-exp (var) (deref (apply-env env var)))

        (diff-exp (exp1 exp2)
          (let ((val1
		  (expval->num
		    (value-of exp1 env)))
                (val2
		  (expval->num
		    (value-of exp2 env))))
            (num-val
	      (- val1 val2))))
        
        (zero?-exp (exp1)
	  (let ((val1 (expval->num (value-of exp1 env))))
	    (if (zero? val1)
	      (bool-val #t)
	      (bool-val #f))))

        (if-exp (exp0 exp1 exp2) 
          (if (expval->bool (value-of exp0 env))
            (value-of exp1 env)
            (value-of exp2 env)))


        ;; straightforward version of LET, without instrumentation
        ;; (let-exp (id rhs body)       
        ;;   (let ((val (value-of rhs env)))
        ;;     (value-of body
        ;;       (extend-env id (newref val) env))))

        ;; LET with instrumentation
       (let-exp (var exp1 body)       
	  (when (instrument-let)
	    (eopl:printf "entering let ~s~%" var))
          (let ((val (value-of exp1 env)))
	    (let ((new-env (extend-env var (newref val) env)))
	      (when (instrument-let)
		(begin
		  (eopl:printf "entering body of let ~s with env =~%"
                               var)
		  (pretty-print (env->list new-env))
		  (eopl:printf "store =~%")
		  (pretty-print (store->readable (get-store-as-list)))
		  (eopl:printf "~%")
		  ))
	      (value-of body new-env))))

       (letref-exp
	(var exp1 body)
	(let ([new-env (extend-env
			var (value-of-operand exp1 env)	env)])
	  (value-of body new-env)))

        (proc-exp (vars body)
	  (proc-val
	   (procedure vars body env 0)))

	(proc-cbv-exp
	 (vars body)
	 (proc-val (procedure vars body env 1)))

	(proc-cbvr-exp
	 (vars body)
	 (proc-val (procedure vars body env 2)))

        (call-exp
	 (rator rands)
         (let ((proc1 (expval->proc (value-of rator env))))
	   (let ((args (cases
		       proc proc1
		       (procedure
			(vars body saved-env type)
			(map (lambda (rand)
			       (if (eq? type 1) ;; call-by-value
				   (newref (value-of rand env))
				   (value-of-operand rand env)))
			     rands)))))
             (apply-procedure proc1 args))))

        (letrec-exp (p-names b-vars p-bodies letrec-body)
          (value-of letrec-body
            (extend-env-rec* p-names b-vars p-bodies env)))

        (begin-exp (exp1 exps)
          (letrec 
            ((value-of-begins
               (lambda (e1 es)
                 (let ((v1 (value-of e1 env)))
                   (if (null? es)
                     v1
                     (value-of-begins (car es) (cdr es)))))))
            (value-of-begins exp1 exps)))

        (assign-exp (x e)
          (begin
            (setref!
              (apply-env env x)
              (value-of e env))
            (num-val 27)))

        (newpair-exp (exp1 exp2)
          (let ((v1 (value-of exp1 env))
                (v2 (value-of exp2 env)))
            (mutpair-val (make-pair v1 v2))))

        (left-exp (exp1)
          (let ((v1 (value-of exp1 env)))
            (let ((p1 (expval->mutpair v1)))
              (left p1))))

        (setleft-exp (exp1 exp2)
          (let ((v1 (value-of exp1 env))
                (v2 (value-of exp2 env)))
            (let ((p (expval->mutpair v1)))
              (begin
                (setleft p v2)
                (num-val 82)))))

        (right-exp (exp1)
          (let ((v1 (value-of exp1 env)))
            (let ((p1 (expval->mutpair v1)))
              (right p1))))

        (setright-exp (exp1 exp2)
          (let ((v1 (value-of exp1 env))
                (v2 (value-of exp2 env)))
            (let ((p (expval->mutpair v1)))
              (begin
                (setright p v2)
                (num-val 83)))))

	;; Ex 4.36
	(newarray-exp
         (exp1 exp2)
         (let ([v1 (value-of exp1 env)]
               [v2 (value-of exp2 env)])
           (let ([len (expval->num v1)])
             (array-val (make-array len v2)))))

        (arrayref-exp
         (exp1 exp2)
         (let ([v1 (value-of exp1 env)]
               [v2 (value-of exp2 env)])
           (let ([arr (expval->array v1)]
                 [index (expval->num v2)])
             (array-ref arr index))))

        (arrayset-exp
         (exp1 exp2 exp3)
         (let ([v1 (value-of exp1 env)]
               [v2 (value-of exp2 env)]
               [v3 (value-of exp3 env)])
           (let ([arr (expval->array v1)]
                 [index (expval->num v2)])
             (array-set arr index v3)
             (num-val 42))))

        (arraylength-exp
         (exp1)
         (let ([arr (expval->array
                     (value-of exp1 env))])
           (num-val (array-length arr))))

        )))

  ;; apply-procedure : Proc * Ref -> ExpVal
  ;; uninstrumented version
  ;; Page: 132
  ;;   (define apply-procedure
  ;;     (lambda (proc1 val)
  ;;       (cases proc proc1
  ;;         (procedure (var body saved-env)
  ;;           (value-of body
  ;;             (extend-env var val saved-env))))))
  

  ;; apply-procedure : Proc * Ref -> ExpVal
  ;; instrumented version
  (define apply-procedure
    (lambda (proc1 vals)
      (cases
       proc proc1
       (procedure
	(vars body saved-env type)
        (if (eq? type 2) ; call-by-value-result
            (apply-cbvr vars vals body saved-env)
	    (let loop ([vars vars] ; cbr or cbv
		       [vals vals]
		       [new-env saved-env])
	      (if (null? vars)
	          (begin
		    (when (instrument-let)
		      (begin
	                (eopl:printf
		         "entering body of proc ~s with env =~%"
		         vars)
		        (pretty-print (env->list new-env))
                        (eopl:printf "store =~%")
                        (pretty-print (store->readable
                                       (get-store-as-list)))
		        (eopl:printf "~%")))
		    (value-of body new-env))
	          (loop (cdr vars)
		        (cdr vals)
		        (extend-env (car vars)
				    (car vals)
				    new-env)))))))))

  (define apply-cbvr
    (lambda (vars old-refs body env)
      (let loop ([vars vars]
                 [nrefs '()]
                 [orefs old-refs]
                 [new-env env])
        (if (null? vars)
            (let ([val (value-of body new-env)])
              (let set-result ([orefs old-refs]
                               [nrefs nrefs])
                (when (not (null? orefs))
                  (begin
                    (setref! (car orefs)
                             (deref (car nrefs)))
                    (set-result (cdr orefs) (cdr nrefs)))))
              val) ; return the final value of body evaluation
            (let ([new-ref (newref (deref (car orefs)))])
              (loop (cdr vars)
                    (append nrefs (list new-ref))
                    (cdr orefs)
                    (extend-env (car vars)
                                new-ref
                                new-env)))))))

  ;; value-of-rand : Exp * Env -> Ref
  ;; Page: 132
  ;; if the expression is a var-exp, then pass the reference.
  ;; otherwise, evaluate the expression and pass a reference to a new
  ;; cell. 

  (define value-of-operand
    (lambda (exp env)
      (cases
       expression exp
       (var-exp (var) (apply-env env var))
       (arrayref-exp
	(exp1 exp2)
	(let ([v1 (value-of exp1 env)]
	      [v2 (value-of exp2 env)])
	  (let ([arr (expval->array v1)]
		[index (expval->num v2)])
	    (array-ref-ref arr index))))
       (else
        (newref (value-of exp env))))))
    
  ;; store->readable : Listof(List(Ref,Expval)) 
  ;;                    -> Listof(List(Ref,Something-Readable))
  (define store->readable
    (lambda (l)
      (map
        (lambda (p)
          (list
            (car p)
            (expval->printable (cadr p))))
        l)))

  )
  


  
