#lang racket

(require redex)

(define-language bool-any-lang
  [B true
     false
     (V B B)]
  [C (V C B)
     (V B C)
     hole])

(define B1 (term true))
(define B2 (term false))
(define B3 (term (V true false)))
(define B4 (term (V ,B1 ,B2)))
(define B5 (term (V false ,B4)))

;; Exercise 11.2
(define-language add-lang
  [A 0
     1
     2
     (+ A A A ...)]
  [C (+ C A A ...)
     (+ A A ... C A ...)
     hole])

(redex-match add-lang
             (in-hole C (+ 0 A))
             (term (+ 0 (+ 0 1))))