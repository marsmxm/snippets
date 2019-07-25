(module interp (lib "eopl.ss" "eopl")
  
  ;; interpreter for the LET language.  The \commentboxes are the
  ;; latex code for inserting the rules into the code in the book.
  ;; These are too complicated to put here, see the text, sorry.

  (require "drscheme-init.scm")

  (require "lang.scm")
  (require "data-structures.scm")
  (require "environments.scm")

  (provide value-of-program value-of)

;;;;;;;;;;;;;;;; the interpreter ;;;;;;;;;;;;;;;;

  ;; value-of-program : Program -> ExpVal
  ;; Page: 71
  (define value-of-program 
    (lambda (pgm)
      (cases program pgm
        (a-program (exp1)
          (value-of exp1 (init-env))))))

  ;; value-of : Exp * Env -> ExpVal
  ;; Page: 71
  (define value-of
    (lambda (exp env)
      (cases expression exp

        ;\commentbox{ (value-of (const-exp \n{}) \r) = \n{}}
        (const-exp (num) (num-val num))

        ;\commentbox{ (value-of (var-exp \x{}) \r) = (apply-env \r \x{})}
        (var-exp (var) (apply-env env var))

        ;; Ex 3.6
        (minus-exp (exp1)
          (let ((val1 (value-of exp1 env)))
            (num-val (- (expval->num val1)))))

        ;; Ex 3.7
        (add-exp (exp1 exp2)
          (let ([val1 (value-of exp1 env)]
                [val2 (value-of exp2 env)])
            (let ([num1 (expval->num val1)]
                  [num2 (expval->num val2)])
              (num-val (+ num1 num2)))))

        (mult-exp (exp1 exp2)
          (let ([val1 (value-of exp1 env)]
                [val2 (value-of exp2 env)])
            (let ([num1 (expval->num val1)]
                  [num2 (expval->num val2)])
              (num-val (* num1 num2)))))

        (quotient-exp (exp1 exp2)
          (let ([val1 (value-of exp1 env)]
                [val2 (value-of exp2 env)])
            (let ([num1 (expval->num val1)]
                  [num2 (expval->num val2)])
              (num-val (quotient num1 num2)))))

        ;\commentbox{\diffspec}
        (diff-exp (exp1 exp2)
          (let ((val1 (value-of exp1 env))
                (val2 (value-of exp2 env)))
            (let ((num1 (expval->num val1))
                  (num2 (expval->num val2)))
              (num-val
                (- num1 num2)))))

        ;\commentbox{\zerotestspec}
        (zero?-exp (exp1)
          (let ((val1 (value-of exp1 env)))
            (let ((num1 (expval->num val1)))
              (if (zero? num1)
                (bool-val #t)
                (bool-val #f)))))

        ;; Ex 3.8
        (equal?-exp (exp1 exp2)
          (let ((val1 (value-of exp1 env))
                (val2 (value-of exp2 env)))
            (let ((num1 (expval->num val1))
                  (num2 (expval->num val2)))
              (bool-val
                (eqv? num1 num2)))))
        (greater?-exp (exp1 exp2)
          (let ((val1 (value-of exp1 env))
                (val2 (value-of exp2 env)))
            (let ((num1 (expval->num val1))
                  (num2 (expval->num val2)))
              (bool-val
                (> num1 num2)))))
        (lesser?-exp (exp1 exp2)
          (let ((val1 (value-of exp1 env))
                (val2 (value-of exp2 env)))
            (let ((num1 (expval->num val1))
                  (num2 (expval->num val2)))
              (bool-val
                (< num1 num2)))))
              
        ;\commentbox{\ma{\theifspec}}
        (if-exp (exp1 exp2 exp3)
          (let ((val1 (value-of exp1 env)))
            (if (expval->bool val1)
              (value-of exp2 env)
              (value-of exp3 env))))

        ;\commentbox{\ma{\theletspecsplit}}
        ;; (let-exp (var exp1 body)       
        ;;   (let ((val1 (value-of exp1 env)))
        ;;     (value-of body
	;; 	      (extend-env var val1 env))))
	(let-exp
	 (ids exps body)
	 (let f ([ids ids]
		 [exps exps]
		 [body-env env])
	   (if (null? ids)
	       (value-of body body-env)
	       (f (cdr ids) (cdr exps)
		  (extend-env (car ids)
			      (value-of (car exps) env)
			      body-env)))))

	(let*-exp
	 (ids exps body)
	 (if (null? ids)
	     (value-of body env)
	     (value-of
	      (let*-exp (cdr ids) (cdr exps) body)
	      (extend-env (car ids) (value-of (car exps) env) env))))

	;; Ex 3.9
	(emptylist-exp () (list-val (empty-list)))

	(cons-exp
	 (exp1 exp2)
	 (let ([val1 (value-of exp1 env)]
	       [val2 (value-of exp2 env)])
	   (let ([tail-list (expval->list val2)])
	     (list-val
	      (non-empty-list val1 val2)))))

	(car-exp
	 (exp1)
	 (let ([val1 (value-of exp1 env)])
	   (let ([list1 (expval->list val1)])
	     (cases listval list1
	       (non-empty-list (head tail) head)
	       (else (eopl:error 'car "empty list"))))))

	(cdr-exp
	 (exp1)
	 (let ([val1 (value-of exp1 env)])
	   (let ([list1 (expval->list val1)])
	     (cases listval list1
	       (non-empty-list (head tail) tail)
	       (else (eopl:error 'cdr "empty list"))))))

	(null?-exp
	 (exp1)
	 (let ([val1 (value-of exp1 env)])
	   (cases expval val1
	    (list-val (list)
		      (bool-val (empty-list? list)))
	    (else (bool-val #f)))))

	(list-exp
	 (exps)
	 (if (null? exps)
	     (list-val (empty-list))
	     (list-val
	      (non-empty-list
	       (value-of (car exps) env)
	       (value-of (list-exp (cdr exps)) env)))))

	(cond-exp
	 (exps1 exps2)
	 (if (null? exps1)
	     (eopl:error 'cond "Braches exhausted")
	     (let ([first-cond
		    (expval->bool
		     (value-of (car exps1) env))])
	       (if first-cond
		   (value-of (car exps2) env)
		   (value-of (cond-exp (cdr exps1) (cdr exps2)) env)))))

	(print-exp
	 (exp)
	 (display (value-of exp env))
	 (newline)
	 (num-val 1))

        (unpack-exp
         (ids exp1 body)
         (let loop ([ids ids]
                    [lst
                     (expval->list
                      (value-of exp1 env))]
                    [body-env env])
           (if (null? ids)
               (if (empty-list? lst)
                   (value-of body body-env)
                   (eopl:error 'unpack "not enough elements in the list"))
	       (cases
                listval lst
                (empty-list () (eopl:error 'unpack "too many elements in the list"))
                (non-empty-list (head tail)
                                (loop (cdr ids) (expval->list tail)
				      (extend-env (car ids)
                                                  head
                                                  body-env)))))))

        )))


  )

