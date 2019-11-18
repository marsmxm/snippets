(module interp-registers "eopl-without-exp.scm"
  
  ;; imperative cps interpreter for the LETREC language, using the
  ;; data structure representation of continuations (Figure 5.3)

  (require "drscheme-init.scm")

  (require "lang.scm")
  (require "data-structures.scm")
  (require "environments.scm")

  (provide value-of-program value-of/k)

  (provide trace-apply-procedure)

  (define trace-apply-procedure (make-parameter #f))

;;;;;;;;;;;;;;;; the interpreter ;;;;;;;;;;;;;;;;

;;; have the interpreter procedures communicate via registers

  (define exp 'uninitialized)
  (define env 'uninitialized)
  (define cont 'uninitialized)
  (define val 'uninitialized)
  (define proc1 'uninitialized)         ; we've already used "proc".
  (define args 'uninitialized)          ; proc args for apply-procedure/k
  (define pc #f)

  (define op1 'uninitialized)
  (define op2 'uninitialized)

  ;; value-of-program : Program -> FinalAnswer
  ;; Page: 167
  (define value-of-program 
    (lambda (pgm)
      (cases program pgm
        (a-program (body)
          (set! cont (end-cont))
          (set! exp body)
          (set! env (init-env))
          (trampoline
	   (value-of/k))))))

  (define trampoline
    (lambda (pc)
      (if pc
	  (trampoline (pc))
	  val)))

  ;; value-of : Exp * Env * Cont -> FinalAnswer
  ;; value-of/k : () -> FinalAnswer
  ;; usage : relies on registers 
  ;;      exp  : Exp
  ;;      env  : Env
  ;;      cont : Cont
  ;; Page 167 and 168
  ;;
  ;; The code from the corresponding portions of interp.scm is shown
  ;; as comments.
  (define value-of/k
    (lambda ()                         
      (cases expression exp
        (const-exp (num)
          ;; (apply-cont cont (num-val num)))                   
          (set! val (num-val num))
          ;; cont is unchanged          
          (apply-cont))
        (var-exp (var)
          ;; (apply-cont cont (apply-env env id)))                 
          (set! val (apply-env env var))
          ;; cont is unchanged          
          (apply-cont))
        (proc-exp (vars body)
          ;; (apply-cont cont (proc-val (procedure bvar body env))
          (set! val (proc-val (procedure vars body env)))
          (apply-cont))
        (letrec-exp (p-name b-var p-body letrec-body)
          ;; (value-of/k letrec-body
          ;;   (extend-env-rec proc-name bvar proc-body env)
          ;;   cont)
          (set! exp letrec-body)
          (set! env
            (extend-env-rec p-name b-var p-body env))
          (value-of/k))
        (zero?-exp (exp1)
          ;; (value-of/k exp1 env (zero1-cont cont))
          (set! cont (zero1-cont cont))
          (set! exp exp1)
          (value-of/k))
        (let-exp (var exp1 body) 
          ;; (value-of/k rhs env (let-exp-cont id body env cont)) 
          (set! cont (let-exp-cont var body env cont))
          (set! exp exp1)
          (value-of/k))
        (if-exp (exp1 exp2 exp3)
          ;; (value-of/k exp0 env (if-test-cont exp2 exp3 env cont))
          (set! cont (if-test-cont exp2 exp3 env cont))
          (set! exp exp1)
          (value-of/k))
        (diff-exp (exp1 exp2)
          ;; (value-of/k exp1 env (diff1-cont exp2 env cont))              
          (set! cont (diff1-cont exp2 env cont))
          (set! exp exp1)
          ;; env is unchanged          
          (value-of/k))
	(multiply-exp (exp1 exp2)
          ;; (value-of/k exp1 env (diff1-cont exp2 env cont))              
          (set! cont (multiply1-cont exp2 env cont))
          (set! exp exp1)
          ;; env is unchanged          
          (value-of/k))
        (call-exp (rator rands)
          ;; (value-of/k rator env (rator-cont rand env cont))
          (set! cont (rator-cont rands env cont))
          (set! exp rator)
          (value-of/k))
        )))

  ;; apply-cont : Cont * ExpVal -> FinalAnswer
  ;; usage : reads registers
  ;;     cont : Cont
  ;;     val  : ExpVal
  ;; Page 169 and 170
  (define apply-cont
    (lambda ()
      (cases continuation cont
        (end-cont ()
          (eopl:printf "End of computation.~%")
          #f)
        ;; or (logged-print val)  ; if you use drscheme-init-cps.scm
        (zero1-cont (saved-cont)
          ;; (apply-cont cont
          ;;   (bool-val
          ;;     (zero? (expval->num val))))
          (set! cont saved-cont)
          (set! val (bool-val (zero? (expval->num val))))
          (apply-cont))
        (let-exp-cont (var body saved-env saved-cont)
          ;; (value-of/k body (extend-env id val env) cont)                     
          (set! cont saved-cont)
          (set! exp body)
          (set! env (extend-env var val saved-env))
          (value-of/k))
        (if-test-cont (exp2 exp3 saved-env saved-cont)
          (set! cont saved-cont)
          (if (expval->bool val)
            (set! exp exp2)
            (set! exp exp3))
          (set! env saved-env)
          (value-of/k))
        (diff1-cont (exp2 saved-env saved-cont)
          ;; (value-of/k exp2 env (diff2-cont val cont)))
          (set! cont (diff2-cont val saved-cont))
          (set! exp exp2)
          (set! env saved-env)
          (value-of/k))
        (diff2-cont (val1 saved-cont)
          ;; (apply-cont cont (num-val (- num1 num2)))))
          (set! op1 (expval->num val1))
          (set! op2 (expval->num val))
          (set! cont saved-cont)
          (set! val (num-val (- op1 op2)))
          (apply-cont))
	(multiply1-cont (exp2 saved-env saved-cont)
          ;; (value-of/k exp2 env (diff2-cont val cont)))
          (set! cont (multiply2-cont val saved-cont))
          (set! exp exp2)
          (set! env saved-env)
          (value-of/k))
        (multiply2-cont (val1 saved-cont)
          ;; (apply-cont cont (num-val (- num1 num2)))))
          (set! op1 (expval->num val1))
	  (set! op2 (expval->num val))
	  (set! cont saved-cont)
          (set! val (num-val (* op1 op2)))
          (apply-cont))
        (rator-cont
	 (rands saved-env saved-cont)
	 (set! proc1 (expval->proc val))
	 (if (null? rands)
	     (begin
	       (set! cont saved-cont)	       
	       (set! args '())
	       (set! pc apply-procedure/k)
	       pc)
	     (begin
	       ;; (value-of/k rand env (rand-cont val cont))
	       (set! cont (rand-cont proc1
				     (cdr rands)
				     '()
				     saved-env
				     saved-cont))
	       (set! exp (car rands))
	       (set! env saved-env)
	       (value-of/k))))
        (rand-cont
	 (rator-proc rest-rands vals saved-env saved-cont)
	 (if (null? rest-rands)
	     (begin
	       (set! cont saved-cont)
	       (set! proc1 rator-proc)
	       (set! args (append vals (list val)))
	       (set! pc apply-procedure/k)
	       pc)
	     (begin
	       (set! cont (rand-cont rator-proc
				     (cdr rest-rands)
				     (append vals (list val))
				     saved-env
				     saved-cont))
	       (set! exp (car rest-rands))
	       (set! env saved-env)
	       (value-of/k))))
        )))

  ;; apply-procedure : Proc * ExpVal -> ExpVal
  ;; apply-procedure/k : () -> FinalAnswer}
  ;; usage : relies on registers
  ;;     proc1 : Proc
  ;;       val : ExpVal
  ;;      cont : Cont
  ;; Page 170
  (define apply-procedure/k
    (lambda ()                          
      (cases
       proc proc1
       (procedure
	(vars body saved-env)
	(let loop ([vars vars]
		   [args args]
		   [new-env saved-env])
	  (if (null? vars)
	      (begin
		(set! exp body)
		(set! env new-env)
		(value-of/k))
	      (loop (cdr vars)
		    (cdr args)
		    (extend-env (car vars) (car args) new-env))))))))

  ;; instrumented version
  ;; (define apply-procedure/k
  ;;   (lambda ()                       ; (proc1 val cont)
  ;;     (if (trace-apply-procedure)
  ;;       (begin
  ;;         (eopl:printf
  ;;           "~%entering apply-procedure:~%proc1=~s~%val=~s~%cont=~s~%" 
  ;;           proc1 val cont)))
  ;;     (cases proc proc1
  ;;       (procedure (var body saved-env)
  ;;         (set! exp body)
  ;;         (set! env (extend-env var val saved-env))
  ;;         (value-of/k)))))

  )
