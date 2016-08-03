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
    [(_ ((x e)) b1 b2 ...)
     (let ((x e)) b1 b2 ...)]
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



