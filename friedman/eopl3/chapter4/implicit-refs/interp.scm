(module interp (lib "eopl.ss" "eopl")
  
  ;; interpreter for the IMPLICIT-REFS language

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
  (define value-of-program 
    (lambda (pgm)
      (initialize-store!)
      (cases program pgm
        (a-program (exp1)
          (value-of exp1 (init-env))))))

  ;; value-of : Exp * Env -> ExpVal
  ;; Page: 118, 119
  (define value-of
    (lambda (exp env)
      (cases expression exp

        ;\commentbox{ (value-of (const-exp \n{}) \r) = \n{}}
        (const-exp (num) (num-val num))

        ;\commentbox{ (value-of (var-exp \x{}) \r) 
        ;              = (deref (apply-env \r \x{}))}
        (var-exp
	 (var)
	 (let ([val (apply-env env var)])
	   (if (reference? val)
	       (deref val)
	       val)))

	;; Ex 4.35
	(ref-exp
	 (var)
	 (let ([ref (apply-env env var)])
	   (if (reference? ref)
	       (ref-val ref)
	       (eopl:error 'ref "Can't ref an immutable variable: ~s" var))))

	(deref-exp
	 (exp1)
	 (let ([val1 (value-of exp1 env)])
	   (let ([ref (expval->ref val1)])
	     (deref ref))))

	(setref-exp
	 (exp1 exp2)
	 (let ([val1 (value-of exp1 env)]
	       [val2 (value-of exp2 env)])
	   (let ([ref (expval->ref val1)])
	     (setref! ref val2))))
	
        ;\commentbox{\diffspec}
        (diff-exp (exp1 exp2)
          (let ((val1 (value-of exp1 env))
                (val2 (value-of exp2 env)))
            (let ((num1 (expval->num val1))
                  (num2 (expval->num val2)))
              (num-val
                (- num1 num2)))))

        ;\commentbox{\zerotestspec}
        (zero?-exp (exp1)
          (let ((val1 (value-of exp1 env)))
            (let ((num1 (expval->num val1)))
              (if (zero? num1)
                (bool-val #t)
                (bool-val #f)))))
              
        ;\commentbox{\ma{\theifspec}}
        (if-exp (exp1 exp2 exp3)
          (let ((val1 (value-of exp1 env)))
            (if (expval->bool val1)
              (value-of exp2 env)
              (value-of exp3 env))))

        ;\commentbox{\ma{\theletspecsplit}}
	(let-exp
	 (ids exps body)
	 (let f ([ids ids]
		 [exps exps]
		 [body-env env])
	   (if (null? ids)
	       (value-of body body-env)
	       (f (cdr ids)
		  (cdr exps)
		  (extend-env (car ids)
			      (value-of (car exps) env)
			      body-env)))))

	(let-mut-exp
	 (ids exps body)
	 (let f ([ids ids]
		 [exps exps]
		 [body-env env])
	   (if (null? ids)
	       (value-of body body-env)
	       (f (cdr ids)
		  (cdr exps)
		  (extend-env (car ids)
			      (newref
			       (value-of (car exps) env))
			      body-env)))))
        
        (proc-exp (vars body)
          (proc-val (procedure vars body env)))

        (call-exp (rator rands)
          (let ((proc (expval->proc (value-of rator env)))
                (args (map
		       (lambda (rand)
			 (value-of rand env))
		       rands)))
            (apply-procedure proc args)))

        (letrec-exp
	 (p-names b-vars p-bodies letrec-body)
	 (let ([vec (make-vector (length p-names))])
	   (let ([new-env (extend-env-rec* p-names vec env)])
	     (let loop ([vars b-vars]
			[bodies p-bodies]
			[index 0])
	       (if (null? vars)
		   (value-of letrec-body new-env)
		   (begin
		     (vector-set!
		      vec index
		      (newref
		       (proc-val
			(procedure 
			 (list (car vars))
			 (car bodies)
			 new-env))))
		     (loop (cdr vars) (cdr bodies) (+ index 1))))))))

        (begin-exp (exp1 exps)
          (letrec 
            ((value-of-begins
               (lambda (e1 es)
                 (let ((v1 (value-of e1 env)))
                   (if (null? es)
                     v1
                     (value-of-begins (car es) (cdr es)))))))
            (value-of-begins exp1 exps)))

        (assign-exp
	 (var exp1)
	 (let ([val (apply-env env var)])
	   (if (reference? val)
               (begin
		 (setref!
		  val
		  (value-of exp1 env))
		 (num-val 27))
	       (eopl:error 'assignment "Setting an immutable var ~s" var))))

	(setdynamic-exp
	 (var exp1 body)
	 (let ([ref (apply-env env var)])
	   (if (reference? ref)
	       (let ([old-val (deref ref)]
		     [new-val (value-of exp1 env)])
		 (setref! ref new-val)
		 (let ([result (value-of body env)])
		   (setref! ref old-val)
		   result))
	       (eopl:error 'setdynamic "Setting an immutable var ~s" var))))

        )))


  ;; apply-procedure : Proc * ExpVal -> ExpVal
  ;; Page: 119

  ;; uninstrumented version
  ;;  (define apply-procedure
  ;;    (lambda (proc1 val)
  ;;      (cases proc proc1
  ;;        (procedure (var body saved-env)
  ;;          (value-of body
  ;;            (extend-env var (newref val) saved-env))))))
  
  ;; instrumented version
  (define apply-procedure
    (lambda (proc1 args)
      (cases
       proc proc1
       (procedure
	(vars body saved-env)
	(let loop ([vars vars]
		   [args args]
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
                    (pretty-print (store->readable (get-store-as-list)))
                    (eopl:printf "~%")))
		(value-of body new-env))
	      (loop (cdr vars)
		    (cdr args)
		    (extend-env (car vars)
				(newref (car args))
				new-env))))))))  

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
  


  
