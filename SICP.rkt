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


;; Exercise 2.28
(define (fringe l)
  (cond [(null? l) null]
        [(pair? l) (append (fringe (car l))
                           (fringe (cdr l)))]
        [else (list l)]))

;; Exercise 2.29
(define (make-mobile left right)
  (list left right))

(define (left-branch mobile)
  (car mobile))

(define (right-branch mobile)
  (car (cdr mobile)))

(define (make-branch length structure)
  (list length structure))

(define (branch-length branch)
  (car branch))

(define (branch-structure branch)
  (car (cdr branch)))

(define (total-weight mobile)
  (letrec ([left (left-branch mobile)]
           [right (right-branch mobile)]
           [left-structure (branch-structure left)]
           [right-structure (branch-structure right)]
           [structure-weight (lambda (s)
                               (if (not (pair? s))
                                   s
                                   (total-weight s)))])
    (+ (structure-weight left-structure)
       (structure-weight right-structure))))

(define (mobile-balanced? mobile)
  (letrec ([left (left-branch mobile)]
           [right (right-branch mobile)]
           [left-structure (branch-structure left)]
           [right-structure (branch-structure right)]
           [structure-weight (lambda (s)
                               (if (not (pair? s))
                                   s
                                   (total-weight s)))]
           [structure-balanced? (lambda (s)
                                  (if (not (pair? s))
                                      #t
                                      (mobile-balanced? s)))])
    (and (eq? (* (branch-length left) (structure-weight left-structure))
              (* (branch-length right) (structure-weight right-structure)))
         (structure-balanced? left-structure))
    (structure-balanced? right-structure)))

;(define (make-mobile left right)
;  (cons left right))
;(define (right-branch mobile)
;  (cdr mobile))
;
;(define (make-branch length structure)
;  (cons length structure))
;(define (branch-structure branch)
;  (cdr branch))

;; Exercise 2.30
(define (map-mine proc items)
  (if (null? items)
      null
      (cons (proc (car items))
            (map-mine proc (cdr items)))))

(define (square-tree tree)
  (map-mine (lambda (sub-tree)
              (if (pair? sub-tree)
                  (square-tree sub-tree)
                  (* sub-tree sub-tree)))
            tree))

(define (square-tree-low tree)
  (cond [(null? tree) null]
        [(pair? tree) (cons (square-tree-low (car tree))
                            (square-tree-low (cdr tree)))]
        [else (* tree tree)]))

;; Exercise 2.32
(define (subsets s)
  (if (null? s)
      (list null)
      (let ((rest (subsets (cdr s))))
        (append rest (map-mine (lambda (elem) (cons (car s) elem)) rest)))))

;; Exercise 2.33
;; fold-right
(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (map-accu p sequence)
  (accumulate (lambda (x y) (cons (p x) y)) null sequence))

(define (append-accu seq1 seq2)
  (accumulate cons seq2 seq1))

(define (length-accu sequence)
  (accumulate (lambda (x y) (add1 y)) 0 sequence))

;; Exercise 2.34
(define (horner-eval x coefficient-sequence)
  (accumulate (lambda (this-coeff higher-terms)
                (+ this-coeff (* x higher-terms)))
              0
              coefficient-sequence))

;; Exercise 2.35
(define (count-leaves-old x)
  (cond ((null? x) 0)
        ((not (pair? x)) 1)
        (else (+ (count-leaves-old (car x))
                 (count-leaves-old (cdr x))))))

(define (count-leaves t)
  (accumulate + 0 (map-mine (lambda (sub-t)
                              (if (pair? sub-t)
                                  (count-leaves sub-t)
                                  1))
                            t)))

;; Exercise 2.36
(define (accumulate-n op init seqs)
  (if (null? (car seqs))
      null
      (cons (accumulate op init (map-mine car seqs))
            (accumulate-n op init (map-mine cdr seqs)))))

;; Exercise 2.37
(define (dot-product v w)
  (accumulate + 0 (map * v w)))

(define (matrix-*-vector m v) (map dot-product (map (lambda (mv) v) m) m))
