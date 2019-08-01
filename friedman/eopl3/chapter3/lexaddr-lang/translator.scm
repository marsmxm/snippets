(module translator (lib "eopl.ss" "eopl")
  
  (require "lang.scm")

  (provide translation-of-program)
  ;;;;;;;;;;;;;;;; lexical address calculator ;;;;;;;;;;;;;;;;

  ;; translation-of-program : Program -> Nameless-program
  ;; Page: 96
  (define translation-of-program
    (lambda (pgm)
      (cases program pgm
        (a-program (exp1)
          (a-program                    
            (translation-of exp1 (init-senv) apply-senv))))))

  ;; translation-of : Exp * Senv -> Nameless-exp
  ;; Page 97
  (define translation-of
    (lambda (exp senv senv-applier)
      (cases expression exp
        (const-exp (num) (const-exp num))
        (diff-exp (exp1 exp2)
          (diff-exp
            (translation-of exp1 senv senv-applier)
            (translation-of exp2 senv senv-applier)))
        (zero?-exp (exp1)
          (zero?-exp
            (translation-of exp1 senv senv-applier)))
        (if-exp (exp1 exp2 exp3)
          (if-exp
            (translation-of exp1 senv senv-applier)
            (translation-of exp2 senv apply-senv-with-unbound)
            (translation-of exp3 senv apply-senv-with-unbound)))
	(cond-exp
	 (exps1 exps2)
	 (cond-exp
	  (map (lambda (e) (translation-of e senv senv-applier))
	       exps1)
	  (map (lambda (e) (translation-of e senv senv-applier))
	       exps2)))
        (var-exp (var)
		 (let ([val (senv-applier senv var)])
		   (if (number? val)
		       (nameless-var-exp val)
		       val)))
        (let-exp (var exp1 body)
          (nameless-let-exp
            (translation-of exp1 senv senv-applier)     
            (translation-of body
			    (extend-senv var senv)
			    senv-applier)))
        (proc-exp (var body)
          (nameless-proc-exp
            (translation-of body
			    (extend-senv var senv)
			    senv-applier)))
        (call-exp (rator rand)
          (call-exp
            (translation-of rator senv senv-applier)
            (translation-of rand senv senv-applier)))

	(list-exp
	 (exps)
	 (list-exp
	  (map (lambda (exp) (translation-of exp senv senv-applier))
	       exps)))

	(unpack-exp
	 (ids exp1 body)
	 (let loop ([ids ids]
		    [body-env senv])
	   (if (null? ids)
	       (nameless-unpack-exp
		(translation-of exp1 senv senv-applier)
		(translation-of body body-env senv-applier))
	       (loop (cdr ids)
		     (extend-senv (car ids) body-env)))))
	
        (else (report-invalid-source-expression exp))
        )))

  (define report-invalid-source-expression
    (lambda (exp)
      (eopl:error 'value-of 
        "Illegal expression in source code: ~s" exp)))
  
   ;;;;;;;;;;;;;;;; static environments ;;;;;;;;;;;;;;;;
  
  ;;; Senv = Listof(Sym)
  ;;; Lexaddr = N

  ;; empty-senv : () -> Senv
  ;; Page: 95
  (define empty-senv
    (lambda ()
      '()))

  ;; extend-senv : Var * Senv -> Senv
  ;; Page: 95
  (define extend-senv
    (lambda (var senv)
      (cons var senv)))
  
  ;; apply-senv : Senv * Var -> Lexaddr
  ;; Page: 95
  (define apply-senv
    (lambda (senv var)
      (cond
        ((null? senv) (report-unbound-var var))
        ((eqv? var (car senv))
         0)
        (else
          (+ 1 (apply-senv (cdr senv) var))))))

  (define report-unbound-var
    (lambda (var)
      (eopl:error 'translation-of "unbound variable in code: ~s" var)))

  (define apply-senv-with-unbound
    (lambda (senv var)
      (let loop ([e senv]
		 [index 0])
	(cond
	 ((null? e) (unbound-var-exp var))
	 ((eqv? var (car e)) index)
	 (else
	  (loop (cdr e) (+ 1 index)))))))

  ;; init-senv : () -> Senv
  ;; Page: 96
  (define init-senv
    (lambda ()
      (extend-senv 'i
        (extend-senv 'v
          (extend-senv 'x
            (empty-senv))))))
  
  )
