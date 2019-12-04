(module interp (lib "eopl.ss" "eopl")
  
  (require "drscheme-init.scm")
  (require "lang.scm")
  (require "data-structures.scm")
  (require "store.scm")
  (require "scheduler.scm")
  (require "semaphores.scm")     
  
  (provide value-of-program trace-interp)

  (define trace-interp (make-parameter #f))

;;;;;;;;;;;;;;;; the interpreter ;;;;;;;;;;;;;;;

  ;; value-of-program : Program * Int -> ExpVal
  ;; Page: 185    
  (define value-of-program
    (lambda (timeslice pgm)
      (initialize-store!)
      (initialize-scheduler! timeslice)
      (cases program pgm
             (a-program
              (exp1)
              (set! exp exp1)
              (set! env (init-env))
              (set! cont (ent-main-thread-cont))
              (value-of/k)))))
   
  ;; value-of/k : Exp * Env * Cont -> FinalAnswer
  ;; Page 182
  (define value-of/k                    
    (lambda ()

      (when (trace-interp)
        (eopl:printf "value-of/k: ~s~%" exp))

      (cases expression exp

             (const-exp (num)
                        (set! val (num-val num))
                        (apply-cont))

             (const-list-exp (nums)
                             (set! val (list-val (map num-val nums)))
                             (apply-cont))

             (var-exp (var)
                      (set! val (deref (apply-env env var)))
                      (apply-cont))
  
             (diff-exp (exp1 exp2)
                       (set! exp exp1)
                       (set! cont (diff1-cont exp2 env cont))
                       (value-of/k))

             (if-exp (exp1 exp2 exp3)
                     (set! exp exp1)
                     (set! cont (if-test-cont exp2 exp3 env cont))
                     (value-of/k))

             (proc-exp (var body)
                       (set! val (proc-val
                                  (procedure var body env)))
                       (apply-cont))

             (call-exp (rator rand)
                       (set! exp rator)
                       (set! cont (rator-cont rand env cont))
                       (value-of/k))

             (let-exp (var exp1 body)          ; implemented like a macro!
                      (set! exp (call-exp
                                 (proc-exp var body)
                                 exp1))
                      (value-of/k))
        
             (begin-exp (exp1 exps)           ; this one, too
                        (if (null? exps)
                            (begin
                              (set! exp exp1)
                              (value-of/k))
                            (begin
                              (set! exp (call-exp
                                         (proc-exp 
                                          (fresh-identifier 'dummy)
                                          (begin-exp (car exps)
                                                     (cdr exps)))
                                         exp1))
                              (value-of/k))))
        
             (letrec-exp (p-names b-vars p-bodies letrec-body)
                         (set! exp letrec-body)
                         (set! env (extend-env-rec* p-names
                                                    b-vars
                                                    p-bodies
                                                    env))
                         (value-of/k))

             (set-exp (id exp1)
                      (set! exp exp1)
                      (set! cont (set-rhs-cont
                                  (apply-env env id) cont))
                      (value-of/k))

             (spawn-exp (exp1)
                        (set! exp exp1)
                        (set! cont (spawn-cont cont))
                        (value-of/k))

             (yield-exp
	      ()
	      (place-on-ready-queue!
	       (a-thread 0
		         (lambda ()
                           (set! val (num-val 99))
                           (apply-cont))
		         the-time-remaining
                         exp env cont val proc1 unop1))
              (run-next-thread))

             (mutex-exp
              ()
              (set! val (mutex-val (new-mutex)))
              (apply-cont))  

             (wait-exp
              (exp1)
              (set! exp exp1)
              (set! cont (wait-cont cont))
              (value-of/k))

             (signal-exp
              (exp1)
              (set! exp exp1)
              (set! cont (signal-cont cont))
              (value-of/k))

             (unop-exp
              (unop1 exp1)
              (set! exp exp1)
              (set! cont (unop-arg-cont unop1 cont))
              (value-of/k))
             
             )))

  ;; apply-cont : Cont * Exp -> FinalAnswer
  ;; Page: 182 and 186
  (define apply-cont                    
    (lambda ()
      (if (time-expired?)
        (begin
          (place-on-ready-queue!
	   (a-thread 0
		     (lambda () (apply-cont))
		     0
                     exp env cont val proc1 unop1))
          (run-next-thread))
        (begin

          (decrement-timer!)

          (cases continuation cont

            (end-main-thread-cont ()
              (set-final-answer! val)
              (run-next-thread))
  
            (end-subthread-cont ()
              (run-next-thread))
               
            (diff1-cont
             (exp2 saved-env saved-cont)
             (set! exp exp2)
             (set! evn saved-env)
             (set! cont (diff2-cont val saved-cont))
             (value-of/k))
            (diff2-cont
             (val1 saved-cont)
             (let ((n1 (expval->num val1))
                   (n2 (expval->num val)))
               (set! cont saved-cont)
               (set! val (num-val (- n1 n2)))
               (apply-cont)))
            (if-test-cont
             (exp2 exp3 env saved-cont)
             (set! cont saved-cont)
             (if (expval->bool val)
                 (begin
                   (set! exp exp2)
                   (value-of/k))
                 (begin
                   (set! exp exp3)
                   (value-of/k))))
            (rator-cont
             (rand saved-env saved-cont)
             (set! exp rand)
             (set! env saved-env)
             (set! cont (rand-cont val saved-cont))
             (value-of/k))
            (rand-cont
             (val1 saved-cont)
             (let ((proc (expval->proc val1)))
               (set! proc1 proc)
               (set! cont saved-cont)
               (apply-procedure)))
            (set-rhs-cont (loc saved-cont)
              (begin
                (setref! loc val)
                (set! cont saved-cont)
                (set! val (num-val 26))
                (apply-cont)))

            (spawn-cont (saved-cont)
              (let ((proc2 (expval->proc val)))
                (place-on-ready-queue!
		 (a-thread 0
			   (lambda ()
                             (set! proc1 proc2)
                             (set! val (num-val 28))
                             (set! cont (end-subthread-cont))
			     (apply-procedure))
			   0
                           exp env cont val proc1 unop1))
                (set! cont saved-cont)
                (set! val (num-val 73))
                (apply-cont)))

            (wait-cont (saved-cont)
              (wait-for-mutex
                (expval->mutex val)
                (lambda ()
                  (set! cont saved-cont)
                  (set! val (num-val 52))
                  (apply-cont))))

            (signal-cont (saved-cont)
              (signal-mutex
               (expval->mutex val)
               (lambda ()
                 (set! cont saved-cont)
                 (set! val (num-val 53))
                 (apply-cont))))

            (unop-arg-cont
             (unop saved-cont)
             (set! unop1 unop)
             (set! cont saved-cont)
             (apply-unop))

            )))))

  (define apply-procedure
    (lambda ()
      (cases
       proc proc1
       (procedure
        (var body saved-env)
        (set! exp body)
        (set! env (extend-env var (newref val) saved-env))
        (value-of/k)))))

  (define apply-unop
    (lambda ()
      (cases
       unop unop1
       (zero?-unop
        ()
        (set! val (bool-val
                     (zero? (expval->num val))))
        (apply-cont))

       (car-unop
        ()
        (let ((lst (expval->list val)))
          (set! val (car lst))
          (apply-cont)))
       
       (cdr-unop
        ()
        (let ((lst (expval->list val)))
          (set! val (list-val (cdr lst)))
          (apply-cont)))

       (null?-unop
        ()
        (set! val (bool-val (null? (expval->list val))))
        (apply-cont))

       (print-unop
        ()
        (begin
          (eopl:printf "~a~%" (expval->num val))
          (set! val (num-val 1))
          (apply-cont)))

        )))

  )

