#lang racket
(require redex)


(define-language L
  (e (e e)
     (λ (x t) e)
     x
     (amb e ...)
     number
     (+ e ...)
     (if0 e e e)
     (fix e))
  (t (-> t t) num)
  (x variable-not-otherwise-mentioned))


;; Exercise 1
(redex-match
   L
   ((λ (x num) e)
    17)
   (term ((λ (x num) (+ x 1))
    17)))

;; Exercise 2
(redex-match
   L
   (-> num t)
   (term (-> num (-> num num))))

;; Exercise 3
(redex-match
 L
  ; your solution goes here
 (term (1 2 3 4)))