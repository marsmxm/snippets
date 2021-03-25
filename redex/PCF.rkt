#lang racket
(require redex)

(define-language PCF
  (M ::=
     N O X L
     (μ (X : T) L)
     (M M ...)
     (if0 M M M))
  (X ::= variable-not-otherwise-mentioned)
  (L ::= (λ ([X : T] ...) M))
  (V ::= N O L)
  (N ::= number)
  (O ::= O1 O2)
  (O1 ::= add1 sub1)
  (O2 ::= + *)
  (T ::= num (T ... -> T)))


(define-term fact-5
  ((μ (fact : (num -> num))
      (λ ([n : num])
        (if0 n
             1
             (* n (fact (sub1 n))))))
   5))


(define-extended-language PCFT PCF
  (Γ ::= ((X T) ...)))

(define-language REDEX)

(define-judgment-form REDEX
  #:mode (lookup I I O)
  #:contract (lookup ((any any) ...) any any)
  [(lookup (_ ... (any any_0) _ ...) any any_0)])

