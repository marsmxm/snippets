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
		 (senv-applier senv var))
	
        (let-exp (var exp1 body)
          (nameless-let-exp
            (translation-of exp1 senv senv-applier)     
            (translation-of body
			    (extend-senv (list var) senv)
			    senv-applier)))

	(letrec-exp
	 (p-names vars-list p-bodies letrec-body)
	 (nameless-letrec-exp
          (let loop ([vars-list vars-list]
                     [p-bodies p-bodies])
            (if (null? p-bodies)
		'()
		(cons (translation-of (car p-bodies)
                                      (extend-senv
                                       (car vars-list)
                                       (extend-senv-rec p-names senv))
                                      senv-applier)
                      (loop (cdr vars-list) (cdr p-bodies)))))
          (translation-of letrec-body
                          (extend-senv-rec p-names senv)
                          senv-applier)))
	
        (proc-exp (vars body)
          (nameless-proc-exp
            (translation-of body
			    (extend-senv vars senv)
			    senv-applier)))
	
        (call-exp (rator rands)
          (call-exp
           (translation-of rator senv senv-applier)
	   (map
	    (lambda (rand)
              (translation-of rand senv senv-applier))
	    rands)))

	(list-exp
	 (exps)
	 (list-exp
	  (map (lambda (exp)
		 (translation-of exp senv senv-applier))
	       exps)))

	(unpack-exp
	 (ids exp1 body)
	 (nameless-unpack-exp
	  (translation-of exp1 senv senv-applier)
	  (translation-of body (extend-senv ids senv) senv-applier)))
	
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
    (lambda (vars senv)
      (cons (cons vars #f) senv)))

  (define extend-senv-rec
    (lambda (vars senv)
      (cons (cons vars #t) senv)))
  
  ;; apply-senv : Senv * Var -> Lexaddr: (index . sub-index)
  ;; Page: 95

  ;; Page: 95
  (define apply-senv0
    (lambda (unbound-handler)
      (lambda (senv var)
	(let loop0 ([senv senv]
		    [index 0])
	  (if (null? senv)
	      (unbound-handler var)
              (let ([is-rec (cdar senv)])
	        (let loop ([vars (caar senv)]
			   [sub-index 0])
		  (if (null? vars)
		      (loop0 (cdr senv) (+ 1 index))
		      (if (eqv? var (car vars))
                          (if is-rec
                              (nameless-letrec-var-exp index sub-index)
			      (nameless-var-exp index sub-index))
			  (loop (cdr vars) (+ 1 sub-index)))))))))))

  (define apply-senv
    (apply-senv0
     (lambda (var) (report-unbound-var var))))

  (define report-unbound-var
    (lambda (var)
      (eopl:error 'translation-of "unbound variable in code: ~s" var)))

  (define apply-senv-with-unbound
    (apply-senv0
     (lambda (var) (unbound-var-exp var))))

  ;; init-senv : () -> Senv
  ;; Page: 96
  (define init-senv
    (lambda ()
      (extend-senv
       '(i)
       (extend-senv
	'(v)
	(extend-senv
	 '(x)
	 (empty-senv))))))
  
  )
