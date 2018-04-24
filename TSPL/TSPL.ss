;; Exercise 2.9.3
(define make-stack
  (lambda ()
    (let ([ls '()])
      (lambda (msg . args)
	(case msg
	  [(empty? mt?) (null? ls)]
	  [(push!) (set! ls (cons (car args) ls))]
	  [(set!) (set-car! (list-tail ls (car args)) 
			    (cadr args))]
	  [(top) (car ls)]
	  [(ref) (list-ref ls (car args))]
	  [(pop!) (set! ls (cdr ls))]
	  [else "oops"])))))


;; Exercise 2.9.4
(define make-stack-vector
  (lambda (size)
    (let ([ls (make-vector size #f)]
	  [cursor 0])
      (lambda (msg . args)
	(case msg
	  [(empty? mt?) (= cursor 0)]
	  [(push!) (if (= cursor size)
		       "vector full!"
		       (begin
			 (vector-set! ls cursor (car args))
			 (set! cursor (add1 cursor))))]
	  [(set!) (vector-set! ls (- cursor 1 (car args)) (cadr args))]
	  [(top) (vector-ref ls (sub1 cursor))]
	  [(ref) (vector-ref ls (- cursor 1 (car args)))]
	  [(pop!) (if (= cursor 0)
		      "vector empty!"
		      (begin
			(set! cursor (sub1 cursor))
			(vector-set! ls cursor #f)))]
	  [else "oops"])))))


;; Exercise 2.9.5
(define make-queue
  (lambda ()
    (let ([end (cons 'ignored '())])
      (cons end end)))) 

(define putq!
  (lambda (q v)
    (let ([end (cons 'ignored '())])
      (set-car! (cdr q) v)
      (set-cdr! (cdr q) end)
      (set-cdr! q end)))) 

(define getq
  (lambda (q)
    (if (emptyq? q)
	(assertion-violation
	 'getq "empty queue" q)
	(car (car q)))))

(define delq!
  (lambda (q)
    (if (emptyq? q)
	(assertion-violation 'delq! "empty queue" q)
	(set-car! q (cdr (car q))))))

(define emptyq?
  (lambda (q)
    (eq? 'ignored (car (car q)))))


;; Exercise 2.9.6
(define make-queue-alt
  (lambda ()
    (let ([end '()])
      (cons end end))))

(define emptyq?-alt
  (lambda (q)
    (null? (car q))))

(define putq!-alt
  (lambda (q v)
    (let ([end (cons v '())])
      (if (emptyq?-alt q)
	  (begin (set-car! q end)
		 (set-cdr! q end))
	  (begin (set-cdr! (cdr q) end)
		 (set-cdr! q end))))))

(define getq-alt
  (lambda (q)
    (if (emptyq? q)
	(assertion-violation
	 'getq "empty queue" q)
	(car (car q)))))

(define delq!-alt
  (lambda (q)
    (if (emptyq? q)
	(assertion-violation 'delq! "empty queue" q)
	(if (= 1 (length (car q)))
	    (let ([end '()])
	      (set-car! q end)
	      (set-cdr! q end))
	    (set-car! q (cdr (car q)))))))


;; Exercise 2.9.8
(define list-cyclic?
  (lambda (ls)
    (letrec ([race
	      (lambda (hare tortoise)
		(cond
		 [(or (not (pair? hare))
		      (not (pair? (cdr hare)))) #f]
		 [(eq? hare tortoise) #t]
		 [else (race (cddr hare) (cdr tortoise))]))])
      (cond
       [(not (pair? ls)) #f]
       [else (race (cdr ls) ls)]))))
;; TODO detect "set-car!" cyclic


(define my-list?
  (lambda (ls)
    (cond
     [(null? ls) #t]
     [(list-cyclic? ls) #f]
     [(null? (cdr ls)) #t]
     [(not (pair? (cdr ls))) #f]
     [else (my-list? (cdr ls))])))


;; Exercise 3.1.1
;; (let ([x (memv 'a ls)])
;;   (and x (memv 'b x)))
;; =>
;; ((lambda (x) (and x (memv 'b x))) (memv 'a ls))
;; =>
;; ((lambda (x) (if x (and (memv 'b x)) #f)) (memv 'a ls))
;; =>
;; ((lambda (x) (if x (memv 'b x) #f)) (memv 'a ls))


;; Exercise 3.1.2
;; (or (memv x '(a b c)) (list x))
;; =>
;; (let ([t (memv x '(a b c))])
;;   (if t t (or (list x))))
;; =>
;; (let ([t (memv x '(a b c))])
;;   (if t t (list x)))


;; Exercise 3.1.3
(define-syntax my-let*
  (syntax-rules ()
    [(_ () b1 b2 ...)
     (let () b1 b2 ...)]
    [(_ ((x1 e1) (x2 e2) ...) b1 b2 ...)
     (let ((x1 e1))
       (my-let* ((x2 e2) ...) b1 b2 ...))]))


;; Exercise 3.1.4
(define-syntax my-when
  (syntax-rules ()
    [(_ test e1 e2 ...)
     (if test (begin e1 e2 ...))]))

(define-syntax my-unless
  (syntax-rules ()
    [(_ test e1 e2 ...)
     (my-when (not test) e1 e2 ...)]))


;; Exercise 3.2.2
(define factor
  (lambda (n)
    (letrec ([f (lambda (n i)
		  (cond
		   [(>= i n) (list n)]
		   [(integer? (/ n i))
		    (cons i (f (/ n i) i))]
		   [else (f n (+ i 1))]))])
      (f n 2))))


;; Exericse 3.2.4
(define fibonacci-1
  (let ([count 0])
    (lambda (n)
      (let fib ([i n])
	(cond
	 [(= i 0) 0]
	 [(= i 1) (display "count: ") (display count) (newline) 1]
	 [else (set! count (+ 2 count)) (+ (fib (- i 1)) (fib (- i 2)))])))))

(define fibonacci-2
  (let ([count 0])
    (lambda (n)
      (if (= n 0)
	  0
	  (let fib ([i n] [a1 1] [a2 0])
	    (if (= i 1)
		(begin (display "count: ") (display count) (newline) a1)
		(begin (set! count (+ count 1)) (fib (- i 1) (+ a1 a2) a1))))))))


;; Exercise 3.2.5
(define-syntax my-let
  (syntax-rules ()
    [(_ ((x e) ...) b1 b2 ...)
     ((lambda (x ...) b1 b2 ...) e ...)]
    [(_ name ((x e) ...) b1 b2 ...)
     (letrec ((name (lambda (x ...) b1 b2 ...)))
       (name e ...))]))


;; Exercise 3.2.6
;; (define-syntax or ; incorrect!
;;   (syntax-rules ()
;;     [(_) #f]
;;     [(_ e1 e2 ...)
;;      (let ([t e1])
;;        (if t t (or e2 ...)))]))

;; (define-syntax or ; correct
;;   (syntax-rules ()
;;     [(_) #f]
;;     [(_ e) e]
;;     [(_ e1 e2 e3 ...)
;;      (let ([t e1])
;;        (if t t (or e2 e3 ...)))]))

;; (letrec ([even?
;;           (lambda (x)
;;             (or (= x 0)
;;                 (odd? (- x 1))))]
;;          [odd?
;;           (lambda (x)
;;             (and (not (= x 0))
;;                  (even? (- x 1))))])
;;   (list (even? 20) (odd? 20))) ; => (#t #f)


;; Exercise 3.2.7
(define factor-old
  (lambda (n)
    (let f ([n n] [i 2])
      (cond
       [(>= i n) (list n)]
       [(integer? (/ n i))
	(cons i (f (/ n i) i))]
       [else (f n (+ i 1))])))) 

(define factor-new
  (lambda (n)
    (let f ([n n] [i 2])
      (cond
       [(> i (sqrt n)) (list n)]
       [else 
	(let ([remain (/ n i)])
	  (if (integer? remain)
	      (cons i (f remain i))
	      (f n (if (= i 2) 3 (+ i 2)))))]))))


;; Exercise 3.3.1
;; ((lambda (foo)
;;    (display (car foo))
;;    (newline)
;;    ((cdr foo) (cons (+ 1 (car foo)) (cdr foo))))
;;  (call/cc (lambda (k) (cons 0 k))))


;; Exercise 3.3.2
(define product-old
  (lambda (ls)
    (call/cc
     (lambda (break)
       (let f ([ls ls])
	 (cond
	  [(null? ls) 1]
	  [(= (car ls) 0) (break 0)]
	  [else (* (car ls) (f (cdr ls)))]))))))

(define product-new
  (lambda (ls)
    (if (memq 0 ls)
	0
	(let f ([ls ls])
	  (if (null? ls)
	      1
	      (* (car ls) (f (cdr ls))))))))


;; Exercise 3.3.3, 3.3.4
(define lwp-list (make-queue))
(define lwp
  (lambda (thunk)
    (putq! lwp-list thunk))) 

(define start
  (lambda ()
    (let ([p (getq lwp-list)])
      (delq! lwp-list)
      (p))))

(define pause
  (lambda ()
    (call/cc
     (lambda (k)
       (lwp (lambda () (k #f)))
       (start)))))

(define quit
  (lambda ()
    (if (not (emptyq? lwp-list))
	(start))))


;; Exercise 3.4.1
(define reciprocal
  (lambda (n success failure)
    (if (= n 0)
        (failure "oops!")
        (success (/ 1 n)))))


;; Exercise 3.4.2
(define retry #f)

;; (define factorial-retry
;;   (lambda (x)
;;     (let f ([x x]
;; 	    [accu 1])
;;       (if (= x 0)
;; 	  (begin (set! retry (lambda (seed) (* seed accu)))
;; 		 accu)
;; 	  (f (sub1 x) (* accu x))))))

(define factorial-retry
  (lambda (x)
    (let f ([x x]
	    [k (lambda (x) x)])
      (if (= x 0)
	  (begin (set! retry k)
		 (k 1))
	  (f (sub1 x) (lambda (y) (* x (k y))))))))


;; Exercise 3.4.3

;; Rewrite the following expression in CPS to avoid using call/cc.
;; (define reciprocals
;;   (lambda (ls)
;;     (call/cc
;;       (lambda (k)
;;         (map (lambda (x)
;;                (if (= x 0)
;;                    (k "zero found")
;;                    (/ 1 x)))
;;              ls)))))

;; (reciprocals '(2 1/3 5 1/4)) => (1/2 3 1/5 4)
;; (reciprocals '(2 1/3 0 5 1/4)) => "zero found"

(define map-co
  (lambda (f ls k)
    (if (null? ls)
	(k '())
	(map-co f (cdr ls)
		(lambda (x)
		  (k (cons (f (car ls))
			   x)))))))

(define reciprocals-co
  (lambda (ls)
    (let f ([ls ls]
	    [k (lambda (x) x)])
      (cond
       [(null? ls) (k '())]
       [(zero? (car ls)) "zero found"]
       [else (f (cdr ls)
		(lambda (y) (k (cons (/ 1 (car ls)) y))))]))))


;; Exercise 3.5.1, 3.5.2, 3.5.3
(define calc
  (lambda (expr)
    (define do-calc
      (lambda (expr)
	(cond
	 [(number? expr) expr]
	 [(and (list? expr) (= (length expr) 3))
	  (let ([op (car expr)] [args (cdr expr)])
	    (case op
	      [(add) (apply-op + args)]
	      [(sub) (apply-op - args)]
	      [(mul) (apply-op * args)]
	      [(div) (apply-op / args)]
	      [else (complain 'do-calc "invalid operator" op)]))]
	 [else (complain 'do-calc "invalid expression" expr)])))
    (define apply-op
      (lambda (op args)
	(op (do-calc (car args)) (do-calc (cadr args)))))
    (define-syntax complain
      (syntax-rules ()
	[(_ symb msg expr) (assertion-violation symb msg expr)]))
    (do-calc expr)))


;; Exercise 3.6.1
(library (grades)
  (export gpa->grade gpa distribution histogram)
  (import (rnrs) (rnrs mutable-pairs)) 

  (define in-range?
    (lambda (x n y)
      (and (>= n x) (< n y)))) 

  (define-syntax range-case 
    (syntax-rules (- else)
      [(_ expr ((x - y) e1 e2 ...) ... [else ee1 ee2 ...])
       (let ([tmp expr])
         (cond
	  [(in-range? x tmp y) e1 e2 ...]
	  ...
	  [else ee1 ee2 ...]))]
      [(_ expr ((x - y) e1 e2 ...) ...)
       (let ([tmp expr])
         (cond
	  [(in-range? x tmp y) e1 e2 ...]
	  ...))])) 

  (define letter->number
    (lambda (x)
      (case x
        [(a)  4.0]
        [(b)  3.0]
        [(c)  2.0]
        [(d)  1.0]
        [(f)  0.0]
        [else (assertion-violation 'grade "invalid letter grade" x)]))) 

  (define gpa->grade
    (lambda (x)
      (range-case x
		  [(0.0 - 0.5) 'f]
		  [(0.5 - 1.5) 'd]
		  [(1.5 - 2.5) 'c]
		  [(2.5 - 3.5) 'b]
		  [else 'a])))
  
  (define-syntax gpa
    (syntax-rules ()
      [(_ g1 g2 ...)
       (let ([ls (map letter->number
		      (filter (lambda (letter) (not (eq? letter 'x)))
			      '(g1 g2 ...)))])
	 (let ([len (length ls)])
	   (if (eq? len 0)
	       0
	       (/ (apply + ls) (length ls)))))]))

  (define count-grades
    (lambda (grades)
      (let ([result '((0 a) (0 b) (0 c) (0 d) (0 f))])
	(let f ([gs grades])
	  (if (null? gs)
	      result
	      (let ([pair (find (lambda (p)
				  (eq? (cadr p) (car gs)))
				result)])
		(if pair
		    (set-car! pair (+ 1 (car pair)))
		    (set! result (cons (list 1 (car gs))
				       result)))
		(f (cdr gs))))))))
  
  (define-syntax distribution
    (syntax-rules ()
      [(_ g1 g2 ...) (count-grades '(g1 g2 ...))]))

  (define histogram
    (lambda (port distr)
      (for-each
       (lambda (n g)
	 (put-datum port g)
	 (put-string port ": ")
	 (let loop ([n n])
	   (unless (= n 0)
		   (put-char port #\*)
		   (loop (- n 1))))
	 (put-string port "\n"))
       (map car distr)
       (map cadr distr)))))

