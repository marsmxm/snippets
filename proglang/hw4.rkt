#lang racket

(provide (all-defined-out)) ;; so we can put tests in a second file

;; put your code below

(define (sequence low high stride)
  (if (> low high)
      null
      (cons low (sequence (+ low stride) high stride))))


(define (string-append-map xs suffix)
  (map (lambda (x) (string-append x suffix)) xs))


(define (list-nth-mod xs n)
  (cond [(< n 0) (error "list-nth-mod: negative number")]
	[(null? xs) (error "list-nth-mod: empty list")]
	[#t (let ([i (remainder n (length xs))])
	      (car (list-tail xs i)))]))


(define (stream-for-n-steps s n)
  (if (zero? n)
      null
      (let ([pr (s)])
	(cons (car pr)
	      (stream-for-n-steps (cdr pr) (- n 1))))))


;; helper function
(define (stream-maker fn arg)
  (letrec ([f (lambda (x) 
                (cons x (lambda () (f (fn x arg)))))])
    (lambda () (f arg))))

(define funny-number-stream
  (stream-maker (lambda (x arg)
		  (if (< x 0)
		      (+ arg (* -1 x))
		      (let ([ans (+ arg x)])
			(if (zero? (remainder ans 5))
			    (* -1 ans)
			    ans))))
		1))

(define dan-then-dog
  (stream-maker (lambda (x arg)
		  (if (equal? x "dan.jpg")
		      "dog.jpg"
		      "dan.jpg"))
		"dan.jpg"))

(define (stream-add-zero s)
  (lambda () 
    (let ([pr (s)])
      (cons (cons 0 (car pr)) (stream-add-zero (cdr pr))))))

(define (cycle-lists xs ys)
  (lambda ()
    (letrec ([loop (lambda (n)
		     (cons (cons (list-nth-mod xs n)
				 (list-nth-mod ys n))
			   (lambda () (loop (+ n 1)))))])
      (loop 0))))


(define (vector-assoc v vec)
  (define loop (lambda (n)
		 (if (equal? n (vector-length vec))
		     #f
		     (let ([e (vector-ref vec n)])
		       (if (and (pair? e) (equal? v (car e)))
			   e
			   (loop (add1 n)))))))
  (loop 0))

(define (cached-assoc xs n)
  (letrec ([memo (make-vector n #f)]
	   [memo-pt 0]
	   [f (lambda (v)
		(let ([ans (vector-assoc v memo)])
		  (if ans
		      ans
		      (let ([new-ans (assoc v xs)])
			(if new-ans
			    (begin (vector-set! memo memo-pt new-ans)
				   (if (equal? memo-pt (sub1 n))
				       (set! memo-pt 0)
				       (set! memo-pt (add1 memo-pt)))
				   new-ans)
			    new-ans)))))])
    f))
