#lang racket
(require redex)

;; 1.1 Defining a Language
(display "1.1 Defining a Language") (newline)

;; 1.1 Defining a Language
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
 (e_0 ... e_1 e_2 e_3 ...)
 (term (1 2 3 4)))

;; Exercise 4
(redex-match
 L
 (e_1 ..._1 e_left e_2 ... e_right e_3 ..._1)
 (term (1 2 3 4 5)))

;; 1.2 Typing
(display "1.2 Typing") (newline)

(define-extended-language L+Γ L
  [Γ · (x : t Γ)])
