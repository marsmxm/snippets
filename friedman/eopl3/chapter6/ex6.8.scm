(define value-of-program
  (lambda (pgm)
    (cases program pgm
	   (a-program
	    (body)
	    (set! handlers '())
	    (value-of/k body (init-env) (lambda (v) v))))))

(define value-of/k
  (lambda (exp env cont)
    (cases expression exp
	   (const-exp (num) (cont (num-val num)))
	   (const-list-exp (nums)
			   (cont (list-val (map num-val nums))))
	   (var-exp (var) (cont (apply-env env var)))
	   (diff-exp (exp1 exp2)
		     (value-of/k
		      exp1 env
		      (lambda (v1)
			(value-of/k
			 exp2 env
			 (lambda (v2)
			   (let ([n1 (expval->num v1)]
				 [n2 (expval->num v2)])
			     (cont (num-val (- n1 n2)))))))))
	   (unop-exp (unop exp1)
		     (value-of/k exp1 env
				 (lambda (v)
				   (cont (apply-unop unop v)))))
	   (try-exp
	    (exp1 var handler-exp)
	    (let ([cont1 (lambda (v)
			   (set! handlers (cdr handlers))
			   (cont v))])
	      (set! handlers (cons cont1 handlers))
	      (value-of/k exp1 env cont1)))
	   (raise-exp (exp1)
		      (value-of/k exp1 env
				  (lambda (v)
				    ))))))
