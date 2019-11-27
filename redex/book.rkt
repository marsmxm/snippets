#lang racket

(require redex)

(define-language bool-any-lang
  [B true
     false
     (V B B)]
  [C (V C B)
     (V B C)
     hole])

;; Exercise 11.2
(define-language add-lang
  [A 0
     1
     2
     (+ A A)]
  [C (+ C A)
     (+ A C)
     hole])
