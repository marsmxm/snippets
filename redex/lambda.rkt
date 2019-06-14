#lang racket

;; Boolean
(define λ-true
  (λ (x y) x))
(define λ-false
  (λ (x y) y))
(define λ-if
  (λ (v t f) (v t f)))
(define λ-and
  (λ (v x) (v x v)))
(define λ-or
  (λ (v x) (v v x)))

;; Pair
(define λ-mkpair
  (λ (f s)
    (λ (v)
      (v f s))))
(define λ-fst
  (λ (p)
    (p λ-true)))
(define λ-snd
  (λ (p)
    (p λ-false)))

;; Church number
(define λ-zero
  (λ (f x) x))
;(define λ-is-zero
;  (λ (n)
;    (λ (t f)
;      (n (λ (x) f) t))))
(define λ-is-zero
  (λ (n)
    (n (λ (x) λ-false) λ-true)))
(define λ-add1
  (λ (n)
    (λ (f x)
      (f (n f x)))))
;(define λ-add
;  (λ (n m)
;    (λ (f x)
;      (n f (m f x)))))
(define λ-add
  (λ (n m)
    (n λ-add1 m)))
(define λ-mult
  (λ (n m)
    (λ (f x)
      (n (λ (x) (m f x)) x))))
(define λ-sub1
  (λ (n)
    (λ (f x)
      (n
       (λ (p)

(define λ-one (λ-add1 λ-zero))
(define λ-two (λ-add1 λ-one))
(define λ-three (λ-add1 λ-two))