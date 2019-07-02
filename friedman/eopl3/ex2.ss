;; 2.1
;;⌈n⌉ = ()        if n = 0
;;⌈n⌉ = (r . ⌈q⌉) if n = qN + r, 0 <= r < N  
(define N 16)
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
	'(1)
	(times n (factorial (predecessor n))))))
