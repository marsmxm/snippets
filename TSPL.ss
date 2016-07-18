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
