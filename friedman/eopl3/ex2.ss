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
    (lambda () '())))
(define push
  (lambda (value stack)
    (lambda ()
      (cons value stack))))
(define top
  (lambda (stack)
    (car (stack))))
(define pop
  (lambda (stack)
    (stack)))
(define empty-stack?
  (lambda (stack)
    (null? (stack))))

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

;; 2.18
(define number->sequence
  (lambda (n)
    (list n '() '())))
(define current-element
  (lambda (node)
    (car node)))
(define at-left-end?
  (lambda (node)
    (null? (cadr node))))
(define move-to-left
  (lambda (node)
    (if (at-left-end? node)
        (error 'move-to-left "Left end" node)
        (list (car (cadr node))
              (cdr (cadr node))
              (cons (car node) (caddr node))))))
(define at-right-end?
  (lambda (node)
    (null? (caddr node))))
(define move-to-right
  (lambda (node)
    (if (at-right-end? node)
        (error 'move-to-right "Right end" node)
        (list (car (caddr node))
              (cons (car node) (cadr node))
              (cdr (caddr node))))))
(define insert-to-left
  (lambda (n node)
    (list (car node)
          (cons n (cadr node))
          (caddr node))))
(define insert-to-right
  (lambda (n node)
    (list (car node)
          (cadr node)
          (cons n (caddr node)))))

;; 2.19
(let ()
  (define number->bintree
    (lambda (n)
      (list n '() '())))
  (define current-element
    (lambda (tree)
      (car tree)))
  (define at-leaf?
    (lambda (tree)
      (null? tree)))
  (define move-to-left-son
    (lambda (tree)
      (if (at-leaf? tree)
	  (error 'move-to-left-son "At leaf" tree)
	  (cadr tree))))
  (define move-to-right-son
    (lambda (tree)
      (if (at-leaf? tree)
	  (error 'move-to-right-son "At leaf" tree)
	  (caddr tree))))
  (define insert-to-left
    (lambda (n tree)
      (if (at-leaf? tree)
	  (error 'insert-to-left "At leaf" n tree)
	  (list (current-element tree)
		(list n (cadr tree) '())
		(caddr tree)))))
  (define insert-to-right
    (lambda (n tree)
      (if (at-leaf? tree)
	  (error 'insert-to-right "At leaf" n tree)
	  (list (current-element tree)
		(cadr tree)
		(list n '() (caddr tree))))))
  (assert #t))

;; 2.20
(let ()
  (define bintree-leaf
    (lambda (top)
      (list '() top)))
  (define bintree-node
    (lambda (n left right top)
      (list n left right top)))
  (define number->bintree
    (lambda (n)
      (bintree-node n '() '() '())))
  (define at-leaf?
    (lambda (tree)
      (null? (car tree))))
  (define current-element
    (lambda (tree) (car tree)))
  (define move-to-left-son
    (lambda (tree)
      (if (at-leaf? tree)
	  (error 'move-to-left-son "At leaf" tree)
	  (append (cadr tree)
		  (list (cons (list (car tree) (cadr tree) (caddr tree))
			      (cadddr tree)))))))
  (define move-to-right-son
    (lambda (tree)
      (if (at-leaf? tree)
	  (error 'move-to-right-son "At leaf" tree)
	  (append (caddr tree)
		  (list (cons (list (car tree) (cadr tree) (caddr tree))
			      (cadddr tree)))))))
  (define insert-to-left
    (lambda (n tree)
      (if (at-leaf? tree)
	  (error 'insert-to-left "At leaf" n tree)
	  (list (current-element tree)
		(list n (cadr tree) '())
		(caddr tree)
		(cadddr tree)))))
   (define insert-to-right
    (lambda (n tree)
      (if (at-leaf? tree)
	  (error 'insert-to-left "At leaf" n tree)
	  (list (current-element tree)
		(cadr tree)
		(list n '() (caddr tree))
		(cadddr tree)))))
   (define at-root?
     (lambda (tree)
       (null? (cadddr tree))))
   (define move-up
     (lambda (tree)
       (if (at-root? tree)
	   (error 'move-up "At root" tree)
	   (append (car (cadddr tree))
		   (list (cdr (cadddr tree)))))))
   (define t1 (insert-to-right
	       14
	       (insert-to-left
		12
		(number->bintree 13))))
   (display t1)
   (newline)
   (display (move-to-left-son t1))
   (newline)
   (display (move-up (move-to-left-son t1)))
   (newline)
   (display (move-up
	     (move-to-left-son
	      (move-to-left-son
	       (insert-to-left 15 t1))))))
   
