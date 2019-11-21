(module interp (lib "eopl.ss" "eopl")
  
  (require "drscheme-init.scm")

  (require "lang.scm")
  (require "data-structures.scm")
  (require "environments.scm")

  (provide value-of-program value-of/k)
  (provide trace-apply-procedure)

  (define trace-apply-procedure (make-parameter #f))

  (define handlers '()) 

;;;;;;;;;;;;;;;; the interpreter ;;;;;;;;;;;;;;;;

  ;; value-of-program : Program -> ExpVal
  (define value-of-program 
    (lambda (pgm)
      (cases program pgm
             (a-program
	      (body)
	      (set! handlers '())
              (value-of/k body (init-env) (end-cont))))))

  ;; value-of/k : Exp * Env * Cont -> FinalAnswer
  ;; Page: 173
  (define value-of/k
    (lambda (exp env cont)
      (cases expression exp

        (const-exp (num) (apply-cont cont (num-val num)))

        (const-list-exp (nums)
          (apply-cont cont
            (list-val (map num-val nums))))

        (var-exp (var) (apply-cont cont (apply-env env var)))

        (diff-exp (exp1 exp2)
          (value-of/k exp1 env
            (diff1-cont exp2 env cont)))

	(div-exp
	 (exp1 exp2)
	 (value-of/k exp1 env
		     (div1-cont exp2 env cont)))
        (unop-exp (unop exp1)
          (value-of/k exp1 env
            (unop-arg-cont unop cont)))

        (if-exp (exp1 exp2 exp3)
          (value-of/k exp1 env
            (if-test-cont exp2 exp3 env cont)))

        (proc-exp (vars body)
          (apply-cont cont
            (proc-val
              (procedure vars body env))))

        (call-exp (rator rands)
          (value-of/k rator env
            (rator-cont rands env cont)))

        ;; make let a macro, because I'm too lazy to add the extra
        ;; continuation
        (let-exp (var exp1 body)
          (value-of/k
           (call-exp (proc-exp (list var) body) (list exp1))
           env
           cont))

        (letrec-exp (p-name b-vars p-body letrec-body)
          (value-of/k
            letrec-body
            (extend-env-rec p-name b-vars p-body env)
            cont))

	(try-exp
         (exp1 var handler-exp)
         (let ([cont (try-cont var handler-exp env cont)])
           (set! handlers (cons cont handlers))
           (value-of/k exp1 env cont)))

	(try/k-exp
	 (exp1 var kvar handler-exp)
	 (let ([cont (try/k-cont var kvar handler-exp env cont)])
           (set! handlers (cons cont handlers))
           (value-of/k exp1 env cont)))
	
        (raise-exp (exp1)
          (value-of/k exp1 env
		      (raise1-cont cont)))

	;; (raise/k-exp
	;;  (exp1)
	;;  (value-of/k exp1 env
	;; 	     (raise1-cont #t cont)))
	)))

  ;; apply-cont : continuation * expval -> final-expval

  (define apply-cont
    (lambda (cont val)
      (cases continuation cont
        (end-cont () val)
        (diff1-cont (exp2 saved-env saved-cont)
          (value-of/k exp2 saved-env (diff2-cont val saved-cont)))
        (diff2-cont (val1 saved-cont)
          (let ((n1 (expval->num val1))
                (n2 (expval->num val)))
            (apply-cont saved-cont
			(num-val (- n1 n2)))))
	(div1-cont (exp2 saved-env saved-cont)
		   (value-of/k exp2 saved-env
			       (div2-cont val saved-env saved-cont)))
	(div2-cont (val1 saved-env saved-cont)
          (let ((n1 (expval->num val1))
                (n2 (expval->num val)))
	    (if (zero? n2)
		(value-of/k (raise-exp
			     (const-exp 0))
			    saved-env
			    saved-cont)
		(apply-cont saved-cont
			    (num-val (/ n1 n2))))))
        (unop-arg-cont (unop cont)
          (apply-cont cont
            (apply-unop unop val)))
        (if-test-cont (exp2 exp3 env cont)
          (if (expval->bool val)
            (value-of/k exp2 env cont)
            (value-of/k exp3 env cont)))
        
	(rator-cont
         (rands saved-env saved-cont)
         (cases
          expval val
          (cont-val ; continuation application
           (cont)
           (if (eq? 1 (length rands))
               (value-of/k (car rands)
                           saved-env
                           (cont-rand-cont
                            cont))
               (eopl:error 'call-cont
                           "continuation takes exactly one argument")))
          (proc-val ; procedure continuation
           (proc1)
           (cases
            proc proc1
	    (procedure
	     (vars body p-env)
	     (let ([vars-len (length vars)]
		   [rands-len (length rands)])
	       (if (not (eq? vars-len rands-len))
		   (value-of/k (raise-exp
				(const-exp
				 (- vars-len rands-len)))
			       saved-env
			       saved-cont)
		   (if (null? rands)
		       (apply-procedure/k proc1 '() saved-cont)
		       (value-of/k (car rands)
				   saved-env
				   (rand-cont proc1
					      (cdr rands)
					      '() ; vals
					      saved-env
					      saved-cont))))))))
          (else eopl:error "Illegle operator: ~s" val)))
        
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

        (cont-rand-cont
         (saved-cont)
         (apply-cont saved-cont val))
        ;; the body of the try finished normally-- don't evaluate the handler
        (try-cont (var handler-exp saved-env saved-cont)
                  (set! handlers (cdr handlers))
                  (apply-cont saved-cont val))
        (try/k-cont (var kvar handler-exp saved-env saved-cont)
                    (set! handlers (cdr handlers))
                    (apply-cont saved-cont val))
        ;; reaching here means normal returning in the handler-exp
        ;; we need to clean the handler from global handlers
        (try/k-handler-cont
         (saved-cont)
         (set! handlers (cdr handlers))
         (apply-cont saved-cont val))
        ;; val is the value of the argument to raise
        (raise1-cont
	 (saved-cont)
         ;; we put the short argument first to make the trace more readable.
	 (apply-handler val saved-cont))
        )))
      
  ;; apply-handler : ExpVal * Cont -> FinalAnswer
  (define apply-handler
    (lambda (val raise-cont)
      (if (null? handlers)
          (eopl:error 'apply-handler "uncaught exception!")
          (let ([handler (car handlers)])
            (cases
             continuation handler
             (try-cont (var handler-exp saved-env saved-cont)
		       (set! handlers (cdr handlers))
                       (value-of/k handler-exp
                                   (extend-env var val saved-env)
				   saved-cont))
	     (try/k-cont
	      (var kvar handler-exp saved-env saved-cont)
	      (value-of/k handler-exp
			  (extend-env kvar (cont-val raise-cont)
				      (extend-env var val saved-env))
			  (try/k-handler-cont
                           saved-cont)))
             (else (eopl:error 'apply-handler "illegle handler")))))))


  ;; apply-procedure : procedure * expval * cont -> final-expval

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


  (define apply-unop
    (lambda (unop val)
      (cases unary-op unop
        (null?-unop ()
          (bool-val
            (null? (expval->list val))))
        (car-unop ()
          (car (expval->list val)))
        (cdr-unop ()
          (list-val (cdr (expval->list val))))
        (zero?-unop ()
          (bool-val
            (zero? (expval->num val)))))))


  ;; to get the detailed trace:
  ;; (trace value-of/k apply-cont apply-handler)

  )
