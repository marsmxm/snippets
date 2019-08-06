(module interp (lib "eopl.ss" "eopl")
  
  ;; interpreter for the LEXADDR language.

  (require "drscheme-init.scm")

  (require "lang.scm")
  (require "data-structures.scm")
  (require "environments.scm")

  (provide value-of-translation value-of)

;;;;;;;;;;;;;;;; the interpreter ;;;;;;;;;;;;;;;;

  ;; value-of-translation : Nameless-program -> ExpVal

  (define value-of-translation
    (lambda (pgm)
      (cases program pgm
        (a-program (exp1)
          (value-of exp1 (init-nameless-env))))))

  ;; value-of-translation : Nameless-program -> ExpVal
  ;; Page: 100
  (define value-of-program
    (lambda (pgm)
      (cases program pgm
        (a-program (exp1)
          (value-of exp1 (init-nameless-env))))))
  
  ;; value-of : Nameless-exp * Nameless-env -> ExpVal
  (define value-of
    (lambda (exp nameless-env)
      (cases expression exp
             (const-exp (num) (num-val num))

        (diff-exp (exp1 exp2)
          (let ((val1
		  (expval->num
		    (value-of exp1 nameless-env)))
                (val2
		  (expval->num
		    (value-of exp2 nameless-env))))
            (num-val
	      (- val1 val2))))
        
        (zero?-exp (exp1)
	  (let ((val1 (expval->num (value-of exp1 nameless-env))))
	    (if (zero? val1)
	      (bool-val #t)
	      (bool-val #f))))

        (if-exp (exp0 exp1 exp2)
		(if (expval->bool (value-of exp0 nameless-env))
		    (value-of exp1 nameless-env)
		    (value-of exp2 nameless-env)))

	(cond-exp
	 (exps1 exps2)
	 (if (null? exps1)
	     (eopl:error 'cond "Braches exhausted")
	     (let ([first-cond
		    (expval->bool
		     (value-of (car exps1) nameless-env))])
	       (if first-cond
		   (value-of (car exps2) nameless-env)
		   (value-of (cond-exp (cdr exps1) (cdr exps2))
			     nameless-env)))))

        (call-exp (rator rands)
          (let ((proc (expval->proc (value-of rator nameless-env)))
                (args (map
		       (lambda (rand)
			 (value-of rand nameless-env))
		       rands)))
	    (apply-procedure proc args)))

        (nameless-var-exp
         (index sub-index)
	 (apply-nameless-env nameless-env index sub-index))

	(unbound-var-exp
	 (var)
	 (eopl:error 'value-of
		     "Unbound variable: ~s"
		     var))

        (nameless-let-exp (exp1 body)
          (let ((val (value-of exp1 nameless-env)))
            (value-of body
		      (extend-nameless-env
		       (list val)
		       nameless-env))))

        (nameless-proc-exp (body)
          (proc-val
           (procedure body nameless-env)))

	(nameless-letrec-exp
	 (p-bodies letrec-body)
	 (value-of letrec-body
		   (extend-nameless-env-rec
		    p-bodies
		    nameless-env)))

        (nameless-letrec-var-exp
         (index sub-index)
         (apply-nameless-env-rec nameless-env index sub-index))

	(list-exp
	 (exps)
	 (if (null? exps)
	     (list-val (empty-list))
	     (list-val
	      (non-empty-list
	       (value-of (car exps) nameless-env)
	       (value-of (list-exp (cdr exps)) nameless-env)))))

	(nameless-unpack-exp
         (exp1 body)
         (let loop ([lst
                     (expval->list
                      (value-of exp1 nameless-env))]
                    [vals '()])
           (cases
            listval lst
            (empty-list () (value-of body
				     (extend-nameless-env
				      vals
				      nameless-env)))
            (non-empty-list
	     (head tail)
             (loop (expval->list tail)
		   (append vals (list head)))))))
	
        (else
         (eopl:error 'value-of 
	    "Illegal expression in translated code: ~s" exp))

        )))


  ;; apply-procedure : Proc * ExpVal -> ExpVal

  (define apply-procedure
    (lambda (proc1 args)
      (cases proc proc1
        (procedure (body saved-env)
		   (value-of body
			     (extend-nameless-env args saved-env))))))

  )
