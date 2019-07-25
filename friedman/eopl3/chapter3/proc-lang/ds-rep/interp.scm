(module interp (lib "eopl.ss" "eopl")
  
  ;; interpreter for the PROC language, using the data structure
  ;; representation of procedures.

  ;; The \commentboxes are the latex code for inserting the rules into
  ;; the code in the book. These are too complicated to put here, see
  ;; the text, sorry. 

  (require "drscheme-init.scm")

  (require "lang.scm")
  (require "data-structures.scm")
  (require "environments.scm")

  (provide value-of-program value-of)

;;;;;;;;;;;;;;;; the interpreter ;;;;;;;;;;;;;;;;

  ;; value-of-program : Program -> ExpVal
  (define value-of-program 
    (lambda (pgm)
      (cases program pgm
        (a-program (exp1)
          (value-of exp1 (init-env))))))

  ;; value-of : Exp * Env -> ExpVal
  (define value-of
    (lambda (exp env)
      (cases expression exp

        ;\commentbox{ (value-of (const-exp \n{}) \r) = \n{}}
        (const-exp (num) (num-val num))

        ;\commentbox{ (value-of (var-exp \x{}) \r) = (apply-env \r \x{})}
        (var-exp (var) (apply-env env var))

        ;\commentbox{\diffspec}
        (diff-exp (exp1 exp2)
          (let ((val1 (value-of exp1 env))
                (val2 (value-of exp2 env)))
            (let ((num1 (expval->num val1))
                  (num2 (expval->num val2)))
              (num-val
               (- num1 num2)))))

	(mult-exp (exp1 exp2)
		  (let ((val1 (value-of exp1 env))
			(val2 (value-of exp2 env)))
		    (let ((num1 (expval->num val1))
			  (num2 (expval->num val2)))
		      (num-val
                       (* num1 num2)))))

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
        (let-exp (var exp1 body)       
          (let ((val1 (value-of exp1 env)))
            (value-of body
              (extend-env var val1 env))))
        
        (proc-exp (vars body)
		  (proc-val (procedure vars body
				       (env->fv-env env exp))))

	(letproc-exp
	 (var proc-vars proc-body body)
	 (value-of body
		   (extend-env var
			       (proc-val
				(procedure proc-vars proc-body env))
			       env)))
	
        (call-exp (rator rands)
          (let ((proc (expval->proc (value-of rator env)))
                (args (map
		       (lambda (rand)
			 (value-of rand env))
		       rands)))
            (apply-procedure proc args)))

        )))

  ;; apply-procedure : Proc * ExpVal -> ExpVal
  ;; Page: 79
  (define apply-procedure
    (lambda (proc1 vals)
      (cases proc proc1
             (procedure
	      (vars body saved-env)
	      (let loop ([vars vars]
			 [vals vals]
			 [env saved-env])
		(if (null? vars)
		    (if (null? vals)
			(value-of body env)
			(eopl:error 'proc "too many args"))
		    (if (null? vals)
			(eopl:error 'proc "too few args")
			(loop (cdr vars) (cdr vals)
			      (extend-env (car vars) (car vals) env)))))))))

  (define occurs-free?
    (lambda (search-var exp)
      (cases
       expression exp
       (const-exp (num) #f)
       (var-exp (var) (eqv? search-var var))
       (diff-exp (exp1 exp2)
		 (or (occurs-free? search-var exp1)
		     (occurs-free? search-var exp2)))
       (mult-exp (exp1 exp2)
		 (or (occurs-free? search-var exp1)
		     (occurs-free? search-var exp2)))
       (zero?-exp (exp1) (occurs-free? search-var exp1))
       (if-exp (exp1 exp2 exp3)
	       (or (occurs-free? search-var exp1)
		   (occurs-free? search-var exp2)
		   (occurs-free? search-var exp3)))
       (let-exp (var exp1 body)
		(or (occurs-free? search-var exp1)
		    (occurs-free? search-var body)))
       (proc-exp (vars body)
		 (and (not (member search-var vars))
		      (occurs-free? search-var body)))
       (letproc-exp (var proc-vars proc-body body)
		    (or (occurs-free? search-var
				      (proc-exp proc-vars proc-body))
			(occurs-free? search-var body)))
       (call-exp (rator rands)
		 (or (occurs-free? search-var rator)
		     (member search-var rands occurs-free?))))))

  
  (define env->fv-env
    (lambda (env exp)
      (if (empty-env? env)
	  env
	  (let ([sym (extended-env-record->sym env)]
		[val (extended-env-record->val env)]
		[old-env (extended-env-record->old-env env)])
	    (if (occurs-free? sym exp)
		(extend-env sym val (env->fv-env old-env exp))
		(env->fv-env old-env exp))))))
  )
