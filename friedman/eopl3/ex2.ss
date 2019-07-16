;; 2.1
;;⌈n⌉ = ()        if n = 0
;;⌈n⌉ = (r . ⌈q⌉) if n = qN + r, 0 <= r < N  
(define N 20)
(define zero (lambda () '()))
(define is-zero? (lambda (n) (null? n)))
(define successor
  (lambda (n)
    (if (is-zero? n)
	'(1)
	(let ([first (add1 (car n))])
	  (if (< first N)
	      (cons first (cdr n))
	      (cons 0 (successor (cdr n))))))))
(define predecessor
  (lambda (n)
    (let ([is-one?
	   (lambda (n)
	     (and
	      (eq? (car n) 1)
	      (null? (cdr n))))])
      (if (or (is-zero? n) (is-one? n))
	  (zero)
	  (if (zero? (car n))
	      (cons (sub1 N) (predecessor (cdr n)))
	      (cons (sub1 (car n)) (cdr n)))))))
(define plus
  (lambda (x y)
    (if (is-zero? x)
        y
	(successor (plus (predecessor x) y)))))
(define times
  (lambda (x y)
    (if (is-zero? x)
	(zero)
	(plus y (times (predecessor x) y)))))
(define factorial
  (lambda (n)
    (if (is-zero? n)
	(successor (zero))
	(times n (factorial (predecessor n))))))

;; 2.3
(define diff-zero
  (lambda () '(diff (one) (one))))
(define count-ones
  (lambda (t)
    (let ([left-ones
           (if (eqv? 'one (caadr t))
               (cons 1 0)
               (count-ones (cadr t)))]
          [right-ones
           (if (eqv? 'one (caaddr t))
               (cons 0 1)
               (count-ones (caddr t)))])
      (cons
       (+ (car left-ones)
          (car right-ones))
       (+ (cdr left-ones)
          (cdr right-ones))))))
(define diff-is-zero?
  (lambda (tree)
    (if (eqv? (car tree) 'one)
        #f
        (let ([ones (count-ones tree)])
	  (eqv? (car ones) (cdr ones))))))
(define diff-successor
  (lambda (tree)
    (if (diff-is-zero? tree)
	'(one)
	`(diff ,tree
	       (diff ,(diff-zero) (one))))))
(define diff-predecessor
  (lambda (tree)
    `(diff ,tree (one))))

;; 2.5
(define empty-env
  (lambda () '()))
(define empty-env?
  (lambda (e) (null? e)))
(define extend-env
  (lambda (var val env)
    (cons
     (cons var val)
     env)))
(define extend-env*
  (lambda (vars vals env)
    (if (null? vars)
	env
	(cons
	 (cons (car vars) (car vals))
	 (extend-env* (cdr vars) (cdr vals) env)))))
(define has-binding?
  (lambda (env s)
    (if (empty-env? env)
        #f
        (or (eqv? s (caar env))
            (has-binding? (cdr env) s)))))
(define apply-env
  (lambda (env search-var)
    (cond
     ((empty-env? env) (report-no-binding-found search-var))
     ((pair? (car env))
      (let ((saved-var (caar env))
            (saved-val (cdar env))
            (saved-env (cdr env)))
        (if (eqv? search-var saved-var)
            saved-val
            (apply-env saved-env search-var))))
     (else
      (report-invalid-env env)))))

(define report-no-binding-found
  (lambda (search-var)
    (error 'apply-env "No binding for the variable" search-var)))
(define report-invalid-env
  (lambda (env)
    (error 'apply-env "Bad environment: ~s" env)))

;; 2.12
;; empty-stack, push, pop, top, and empty-stack?
(define empty-stack
  (lambda ()
    (lambda ()
      (error 'pop "Empty stack"))))
(define push
  (lambda (value)
    ))


;; 2.15
;; (define occurs-free?
;;   (lambda (var exp)
;;     (cond
;;      ((symbol? exp) (eqv? var exp))
;;      ((eqv? (car exp) 'lambda)
;;       (and
;;        (not (eqv? var (car (cadr exp)))) (occurs-free? var (caddr exp))))
;;      (else (or
;; 	    (occurs-free? var (car exp)) (occurs-free? var (cadr exp)))))))
(define var-exp
  (lambda (var) var))
(define lambda-exp
  (lambda (var exp)
    `(lambda (,var) ,exp)))
(define app-exp?
  (lambda (e1 e2)
    `(,e1 ,e2)))

(define var-exp?
  (lambda (exp)
    (symbol? exp)))
(define lambda-exp?
  (lambda (exp)
    (eqv? (car exp) 'lambda)))
(define app-exp?
  (lambda (exp)
    (not
     (or (var-exp? exp) (lambda-exp? exp)))))

(define var-exp->var
  (lambda (exp)
    exp))
(define lambda-exp->bound-var
  (lambda (exp)
    (car (cadr exp))))
(define lambda-exp->body
  (lambda (exp)
    (caddr exp)))
(define app-exp->rator
  (lambda (exp)
    (car exp)))
(define app-exp->rand
  (lambda (exp)
    (cadr exp)))
