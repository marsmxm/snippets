#lang racket

(require redex)

(define-language bool-any-lang
  [B true
     false
     (V B B)]
  [C (V C B)
     (V B C)
     hole])

(define bool-any-red
   (reduction-relation
      bool-any-lang
      (--> (in-hole C (V true B))
           (in-hole C true)
           V-true)
      (--> (in-hole C (V false B))
           (in-hole C B)
           V-false)))
; =>
; (list
;  (match (list (bind 'B 'false) (bind 'C '(V true hole))))
;  (match (list (bind 'B '(V true false)) (bind 'C hole))))

; (define B1 (term true))
; (define B2 (term false))
; (define B3 (term (V true false)))
; (define B4 (term (V ,B1 ,B2)))
; (define B5 (term (V false ,B4)))

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
             (term (+ 0 (+ 0 1 2))))

;; Exercise 11.3
(define bool-any-red
   (reduction-relation
      add-lang
      (--> (in-hole C (+ 0 A))
           (in-hole C A)
           V-true)
      (--> (in-hole C (V false B))
           (in-hole C B)
           V-false)))
