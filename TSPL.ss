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
	  [(set!) (vector-set! ls (car args) (cadr args))]
	  [(top) (vector-ref ls (sub1 cursor))]
	  [(ref) (vector-ref ls (car args))]
	  [(pop!) (if (= cursor 0)
		      "vector empty!"
		      (begin
			(set! cursor (sub1 cursor))
			(vector-set! ls cursor #f)))]
	  [else "oops"])))))
