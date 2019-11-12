(module interp (lib "eopl.ss" "eopl")
  
  ;; cps interpreter for the LETREC language, using the data structure
  ;; representation of continuations (Figure 5.3).

  ;; exercise: rewrite this using the procedural representation of
  ;; continuations (Figure 5.2).

  ;; exercise: rewrite this using a trampoline (page 159).

  (require "drscheme-init.scm")

  (require "lang.scm")
  (require "data-structures.scm")
  (require "environments.scm")

  (provide value-of-program value-of/k)

;;;;;;;;;;;;;;;; the interpreter ;;;;;;;;;;;;;;;;

  ;; value-of-program : Program -> FinalAnswer
  ;; Page: 143 and 154
  (define value-of-program 
    (lambda (pgm)
      (cases program pgm
        (a-program (exp1)
          (value-of/k exp1 (init-env) (end-cont))))))  

  ;; value-of/k : Exp * Env * Cont -> FinalAnswer
  ;; Page: 143--146, and 154
  (define value-of/k
    (lambda (exp env cont)
      (cases expression exp
        (const-exp (num) (apply-cont cont (num-val num)))
        (var-exp (var) (apply-cont cont (apply-env env var)))
        (proc-exp (vars body)
          (apply-cont cont 
            (proc-val (procedure vars body env))))
        (letrec-exp (p-name b-var p-body letrec-body)
          (value-of/k letrec-body
            (extend-env-rec p-name b-var p-body env)
            cont))
        (zero?-exp (exp1)
          (value-of/k exp1 env
            (zero1-cont cont)))
	(let-exp
	 (vars exps body)
	 (value-of/k (car exps) env
		     (let-exp-cont (car vars)
				   (cdr vars)
				   (cdr exps)
				   body env cont)))
        (if-exp (exp1 exp2 exp3)
          (value-of/k exp1 env
            (if-test-cont exp2 exp3 env cont)))
        (diff-exp (exp1 exp2)
          (value-of/k exp1 env
            (diff1-cont exp2 env cont)))        
        (call-exp (rator rands) 
          (value-of/k rator env
            (rator-cont rands env cont)))

	;; for list
	(emptylist-exp () (apply-cont cont (list-val (emptylist))))

	(cons-exp
	 (exp1 exp2)
	 (value-of/k exp1 env
		     (cons1-cont exp2 env cont)))

	(null?-exp
	 (exp1)
	 (value-of/k exp1 env (null1-cont cont)))
	
	(car-exp
	 (exp1)
	 (value-of/k exp1 env (car1-cont cont)))
	
	(cdr-exp
	 (exp1)
	 (value-of/k exp1 env (cdr1-cont cont)))

        (list-exp
         (exps)
         (if (null? exps)
             (apply-cont cont (list-val (emptylist)))
             (value-of/k (car exps)
                         env
                         (list-first-cont (cdr exps) env cont))))

        )))

  ;; apply-cont : Cont * ExpVal -> FinalAnswer
  ;; Page: 148
  (define apply-cont
    (lambda (cont val)
      (cases continuation cont
        (end-cont () 
          (begin
            (eopl:printf
              "End of computation.~%")
            val))
        ;; or (logged-print val)  ; if you use drscheme-init-cps.scm
        (zero1-cont (saved-cont)
          (apply-cont saved-cont
            (bool-val
              (zero? (expval->num val)))))
	(let-exp-cont
	 (var vars-left exps-left body saved-env saved-cont)
	 (let ([new-env (extend-env var val saved-env)])
	   (if (null? vars-left)
	       (value-of/k body
			   new-env
			   saved-cont)
	       (value-of/k (let-exp
			    vars-left exps-left body)
			   new-env
			   saved-cont))))
        (if-test-cont (exp2 exp3 saved-env saved-cont)
          (if (expval->bool val)
             (value-of/k exp2 saved-env saved-cont)
             (value-of/k exp3 saved-env saved-cont)))
        (diff1-cont (exp2 saved-env saved-cont)
          (value-of/k exp2
            saved-env (diff2-cont val saved-cont)))
        (diff2-cont (val1 saved-cont)
          (let ((num1 (expval->num val1))
                (num2 (expval->num val)))
            (apply-cont saved-cont
              (num-val (- num1 num2)))))
        (rator-cont
         (rands saved-env saved-cont)
         (let ([proc (expval->proc val)])
           (if (null? rands)
               (apply-procedure/k proc '() saved-cont)
               (value-of/k (car rands)
                           saved-env
                           (rand-cont proc
                                      (cdr rands)
                                      '() ; vals
                                      saved-env
                                      saved-cont)))))
        (rand-cont
         (proc rest-rands vals saved-env saved-cont)
         (if (null? rest-rands)
             (apply-procedure/k proc
                                (append vals (list val))
                                saved-cont)
             (value-of/k (car rest-rands)
                         saved-env
                         (rand-cont proc
                                    (cdr rest-rands)
                                    (append vals (list val))
                                    saved-env
                                    saved-cont))))
	;; for list
	(cons1-cont
	 (exp2 saved-env saved-cont)
	 (value-of/k exp2 saved-env
		     (cons2-cont val saved-cont)))
	(cons2-cont
	 (val1 saved-cont)
	 (let ([a-list (expval->list val)])
	   (apply-cont saved-cont
		       (list-val (conslist val1 a-list)))))

	(null1-cont
	 (saved-cont)
	 (let ([a-list (expval->list val)])
           (apply-cont saved-cont
	               (cases listval a-list
		              (emptylist () (bool-val #t))
		              (else (bool-val #f))))))
	
	(car1-cont
	 (saved-cont)
	 (let ([a-list (expval->list val)])
	   (cases
	    listval a-list
	    (conslist
	     (head tail)
	     (apply-cont saved-cont head))
	    (else
	     (eopl:error 'car "empty list")))))

	(cdr1-cont
	 (saved-cont)
	 (let ([a-list (expval->list val)])
	   (cases
	    listval a-list
	    (conslist
	     (head tail)
	     (apply-cont saved-cont (list-val tail)))
	    (else
	     (eopl:error 'cdr "empty list")))))

        (list-first-cont
         (rest-exps saved-env saved-cont)
         (value-of/k (car rest-exps)
                     saved-env
                     (list-rest-cont
                      (list val)
                      (cdr rest-exps)
                      saved-env
                      saved-cont)))

        (list-rest-cont
         (vals rest-exps saved-env saved-cont)
         (if (null? rest-exps)
             (apply-cont saved-cont
                         (list-val
                          (let loop ([vals vals])
                            (if (null? vals)
                                (conslist val (emptylist))
                                (conslist (car vals)
                                          (loop (cdr vals)))))))
             (value-of/k (car rest-exps)
                         saved-env
                         (list-rest-cont
                          (append vals (list val))
                          (cdr rest-exps)
                          saved-env
                          saved-cont))))

	
	)))

  ;; apply-procedure/k : Proc * ExpVal * Cont -> FinalAnswer
  ;; Page 152 and 155
  (define apply-procedure/k
    (lambda (proc1 args cont)
      (cases
       proc proc1
       (procedure
        (vars body saved-env)
        (value-of/k body
                    (let loop ([vars vars]
                               [args args]
                               [new-env saved-env])
                      (if (null? vars)
                          new-env
                          (loop (cdr vars)
                                (cdr args)
                                (extend-env (car vars)
                                            (car args)
                                            new-env))))
                    cont)))))
  
  )
  


  
