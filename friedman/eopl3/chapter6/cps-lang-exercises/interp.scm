(module interp (lib "eopl.ss" "eopl")
  
  (require "drscheme-init.scm")

  (require "cps-out-lang.scm")
  (require "data-structures.scm")       ; this includes environments

  (provide value-of-program value-of/k)

;;;;;;;;;;;;;;;; the interpreter ;;;;;;;;;;;;;;;;

  ;; value-of-program : Program -> ExpVal

  (define value-of-program 
    (lambda (pgm)
      (cases cps-out-program pgm
        (cps-a-program (exp1)
          (value-of/k exp1 (init-env) (end-cont))))))

  (define value-of-simple-exp
    (lambda (exp env)
      (cases simple-expression exp
        (cps-const-exp (num) (num-val num))
        (cps-var-exp (var) (apply-env env var))

        (cps-number?-exp (simple1)
                         (bool-val
                          (cases expval
				 (value-of-simple-exp simple1 env)
				 (num-val (n) #t)
				 (else #f))))

	(cps-equal?-exp (simple1 simple2)
			(bool-val
			 (=
			  (expval->num (value-of-simple-exp simple1 env))
			  (expval->num (value-of-simple-exp simple2 env)))))
	
	(cps-less?-exp (simple1 simple2)
			(bool-val
			 (<
			  (expval->num (value-of-simple-exp simple1 env))
			  (expval->num (value-of-simple-exp simple2 env)))))
	
        (cps-diff-exp (exp1 exp2)
          (let ((val1
		  (expval->num
		    (value-of-simple-exp exp1 env)))
                (val2
		  (expval->num
		    (value-of-simple-exp exp2 env))))
            (num-val
	      (- val1 val2))))

        (cps-zero?-exp (exp1)
          (bool-val
            (zero?
              (expval->num
                (value-of-simple-exp exp1 env)))))

        (cps-sum-exp (exps)
          (let ((nums (map
                        (lambda (exp)
                          (expval->num
                            (value-of-simple-exp exp env)))
                        exps)))
            (num-val
              (let sum-loop ((nums nums))
                (if (null? nums) 0
                    (+ (car nums) (sum-loop (cdr nums))))))))

	(cps-multiple-exp (exps)
          (let ((nums (map
                        (lambda (exp)
                          (expval->num
                            (value-of-simple-exp exp env)))
                        exps)))
            (num-val
              (let loop ((nums nums))
                (if (null? nums) 1
                  (* (car nums) (loop (cdr nums))))))))

        (cps-proc-exp (vars body)
          (proc-val
           (procedure vars body env)))

        (emptylist-exp () (list-val (emptylist)))
        (cons-exp (simple1 simple2)
                  (list-val
                   (conslist
                    (value-of-simple-exp simple1 env)
                    (expval->list
                     (value-of-simple-exp simple2 env)))))
        (null?-exp (simple1)
                   (cases listval (expval->list
                                   (value-of-simple-exp simple1 env))
                          (emptylist () (bool-val #t))
                          (else (bool-val #f))))
        (car-exp (simple1)
                 (cases listval (expval->list
                                 (value-of-simple-exp simple1 env))
                        (conslist (head tail) head)
                        (else (eopl:error 'car "empty list"))))
        (cdr-exp (simple1)
                 (cases listval (expval->list
                                 (value-of-simple-exp simple1 env))
                        (conslist (head tail) (list-val tail))
                        (else (eopl:error 'cdr "empty list"))))

	(list-exp
         (exps)
         (if (null? exps)
             (list-val (emptylist))
	     (list-val
	      (conslist
	       (value-of-simple-exp (car exps) env)
	       (expval->list
		(value-of-simple-exp (list-exp (cdr exps)) env))))))
	
	)))
  
  ;; value-of/k : TfExp * Env * Cont -> FinalAnswer
  ;; Page: 209
  (define value-of/k
    (lambda (exp env cont)
      (cases tfexp exp
        (simple-exp->exp (simple)
          (apply-cont cont
            (value-of-simple-exp simple env)))
        (cps-let-exp (var rhs body)
         (let ((val (value-of-simple-exp rhs env)))
            (value-of/k body
              (extend-env* (list var) (list val) env)
              cont)))
        (cps-letrec-exp (p-names b-varss p-bodies letrec-body)
          (value-of/k letrec-body
            (extend-env-rec** p-names b-varss p-bodies env)
            cont))
        (cps-if-exp (simple1 body1 body2)
          (if (expval->bool (value-of-simple-exp simple1 env))
            (value-of/k body1 env cont)
            (value-of/k body2 env cont)))
        (cps-call-exp (rator rands)
          (let ((rator-proc
                  (expval->proc
                    (value-of-simple-exp rator env)))
                (rand-vals
                  (map
                    (lambda (simple)
                      (value-of-simple-exp simple env))
                    rands)))
            (apply-procedure/k rator-proc rand-vals cont))))))

  ;; apply-cont : Cont * ExpVal -> Final-ExpVal
  ;; there's only one continuation, and it only gets invoked once, at
  ;; the end of the computation.
  (define apply-cont
    (lambda (cont val)
      (cases continuation cont
        (end-cont () val))))
      
  ;; apply-procedure/k : Proc * ExpVal * Cont -> ExpVal
  ;; Page: 209 
  (define apply-procedure/k
    (lambda (proc1 args cont)
      (cases proc proc1
        (procedure (vars body saved-env)
          (value-of/k body
            (extend-env* vars args saved-env)
            cont)))))

  '(define apply-procedure/k
    (lambda (proc1 args cont)
      (cases proc proc1
        (procedure (vars body saved-env)
          (value-of/k body
            (extend-env* vars args saved-env)
            cont)))))

  ;; trace has to be in the module where the procedure is defined.
  ;; (trace value-of/k apply-cont)

  )
