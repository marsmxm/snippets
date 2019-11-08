(module interp (lib "eopl.ss" "eopl")
  
  ;; interpreter for the IMPLICIT-REFS language

  (require "drscheme-init.scm")

  (require "lang.scm")
  (require "data-structures.scm")
  (require "environments.scm")
  (require "store.scm")
  
  (provide result-of-program value-of-program value-of
	   instrument-let instrument-newref)

;;;;;;;;;;;;;;;; switches for instrument-let ;;;;;;;;;;;;;;;;

  (define instrument-let (make-parameter #f))

  ;; say (instrument-let #t) to turn instrumentation on.
  ;;     (instrument-let #f) to turn it off again.

;;;;;;;;;;;;;;;; the interpreter ;;;;;;;;;;;;;;;;

  (define result-of-program
    (lambda (pgm)
      (cases program pgm
	     (a-program (stmt1)
			(initialize-store!)
			(result-of stmt1 (init-env) the-store)))))


  ;; value-of-program : Program -> ExpVal
  (define value-of-program 
    (lambda (pgm)
      (initialize-store!)
      (cases program1 pgm
        (b-program (exp1)
		   (value-of exp1 (init-env))))))

  ;; result-of : Stmt * Env * Store -> Store
  (define result-of
    (lambda (stmt env store)
      (cases
       statement stmt

       (block-stmt
	(vars exps stmt1)
	(let ([vec (make-vector (length vars))])
	  (let ([new-env (extend-env-rec* vars vec env)])
	    (let loop ([exps exps]
		       [index 0])
	      (if (null? exps)
		  (result-of stmt1 new-env store)
		  (begin
		    (vector-set! vec index
				 (newref
				  (value-of (car exps) new-env)))
		    (loop (cdr exps) (+ index 1))))))))

       (assign-stmt
	(var exp1)
	(value-of (assign-exp var exp1) env)
	the-store)

       (print-stmt
	(exp1)
	(display (value-of exp1 env))
	(newline)
	the-store)

       (brace-stmt
	(stmts)
	(let loop ([stmts stmts]
		   [store store])
	  (if (null? stmts)
	      store
	      (let ([new-store (result-of (car stmts) env store)])
		(loop (cdr stmts) new-store)))))

       (while-stmt
	(exp1 stmt1)
	(let loop ([condition (expval->bool
			       (value-of exp1 env))]
		   [store store])
	  (if condition
	      (let ([new-store (result-of stmt1 env store)])
		(loop (expval->bool (value-of exp1 env))
		      new-store))
	      store)))

       (do-while-stmt
	(stmt1 exp1)
	(let loop ([new-store store])
	  (let ([store1 (result-of stmt1 env new-store)])
	    (let ([condition (expval->bool
			      (value-of exp1 env))])
	      (if condition
		  (loop store1)
		  store1)))))

       (read-stmt
	(var)
	(let ([input (read)])
	  (if (and (integer? input)
		   (not (negative? input)))
	      (begin
		(value-of (const-exp input) env)
		the-store)
	      (eopl:error 'read-stmt
			  "Expecting a non-negative integer: ~s"
			  input))))
       
       (else
	(eopl:error 'result-of "Unknown statement: ~s" stmt)))))

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
	
        ;\commentbox{\diffspec}
        (diff-exp (exp1 exp2)
          (let ((val1 (value-of exp1 env))
                (val2 (value-of exp2 env)))
            (let ((num1 (expval->num val1))
                  (num2 (expval->num val2)))
              (num-val
               (- num1 num2)))))

	(plus-exp (exp1 exp2)
          (let ((val1 (value-of exp1 env))
                (val2 (value-of exp2 env)))
            (let ((num1 (expval->num val1))
                  (num2 (expval->num val2)))
              (num-val
               (+ num1 num2)))))

        ;\commentbox{\zerotestspec}
        (zero?-exp (exp1)
          (let ((val1 (value-of exp1 env)))
            (let ((num1 (expval->num val1)))
              (if (zero? num1)
                (bool-val #t)
                (bool-val #f)))))

	(not-exp
	 (exp1)
	 (let ([val1 (value-of exp1 env)])
	   (let ([b (expval->bool val1)])
	     (bool-val (not b)))))
              
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
  


  
