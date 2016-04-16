#lang racket

;; Ex 1.11
(define (f1 n)
  (if (< n 3)
      n
      (+ (f1 (- n 1)) (* 2 (f1 (- n 2))) (* 3 (f1 (- n 3))))))

(define (f2 n)
  (define (f2-iter a b c counter)
    (if (zero? counter)
        c
        (f2-iter (+ a (* 2 b) (* 3 c)) a b (sub1 counter))))
  (f2-iter 2 1 0 n))

; Ex 1.12
;     1
;    1 1
;   1 2 1
;  1 3 3 1
; 1 4 6 4 1
(define (pt r c)
  (if (or (equal? c 1)
          (equal? r c))
      1
      (+ (pt (sub1 r) (sub1 c))
         (pt (sub1 r) c))))

;; Ex 1.16
;; fast-exp-iter
(define (expt b n)
  (if (= n 0)
      1
      (* b (expt b (- n 1)))))

(define (fast-expt1 b n)
  (cond ((= n 0) 1)
        ((even? n) (sqr (fast-expt1 b (/ n 2))))
        (else (* b (fast-expt1 b (- n 1))))))

(define (fast-expt2 b n)
  (define (fast-expt-iter b n a)
    (cond [(zero? n) a]
          [(even? n) (fast-expt-iter (sqr b) (/ n 2) a)]
          [else (fast-expt-iter b (sub1 n) (* a b))]))
  (fast-expt-iter b n 1))

;; Ex 1.17
;(define (* a b)
;  (if (= b 0)
;      0
;      (+ a (* a (- b 1)))))
(define (fast-mult a b)
  (define (double x) (* x 2))
  (define (halve x) (/ x 2))
  (cond [(zero? b) 0]
        [(even? b) (fast-mult (double a) (halve b))]
        [else (+ a (fast-mult a (sub1 b)))]))
;; Ex 1.18
(define (fast-mult2 a b)
  (define (double x) (* x 2))
  (define (halve x) (/ x 2))
  (define (fast-mult-iter a b c)
    (cond [(zero? b) c]
          [(even? b) (fast-mult-iter (double a)
                                     (halve b)
                                     c)]
          [else (fast-mult-iter a (sub1 b) (+ c a))]))
  (fast-mult-iter a b 0))

;; Ex 1.19
(define (fib n)
  (define (fib-iter a b count)
    (if (= count 0)
        b
        (fib-iter (+ a b) a (- count 1))))
  (fib-iter 1 0 n))

(define (fib2 n) ;wrong
  (define (fib-iter a b p q count)
    (cond ((= count 0) b)
          ((even? count)
           (fib-iter a
                     b
                     (+ p q) ; compute p’
                     p       ; compute q’ 
                     (/ count 2)))
          (else (fib-iter (+ (* b q) (* a q) (* a p))
                          (+ (* b p) (* a q))
                          p
                          q
                          (- count 1)))))
  (fib-iter 1 0 0 1 n))