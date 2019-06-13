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
