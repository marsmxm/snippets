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
      (λ-fst
       (n
        (λ (p)
          (λ-if (λ-snd p)
                (λ-mkpair (λ-fst p) λ-false)
                (λ-mkpair (f (λ-fst p)) λ-false)))
        (λ-mkpair x λ-true))))))

(define λ-one (λ-add1 λ-zero))
(define λ-two (λ-add1 λ-one))
(define λ-three (λ-add1 λ-two))

;; Recursion
(define mk-mult
  (λ (t)
    (λ (n m)
      (λ-if (λ-is-zero n)
            λ-zero
            (λ-add m ((t t) (λ-sub1 n) m))))))
(define mult
  (mk-mult mk-mult))

(((λ (mksum)
    (λ (n m)
      (if (zero? n)
          m
          (add1 ((mksum mksum) (sub1 n) m)))))
  (λ (mksum)
    (λ (n m)
      (if (zero? n)
          m
          (add1 ((mksum mksum) (sub1 n) m))))))
 2 3)

(((λ (mk-sum)
    (mk-sum mk-sum))
  (λ (mk-sum)
    (λ (n m)
      (if (zero? n)
          m
          (add1 ((mk-sum mk-sum) (sub1 n) m))))))
 2 3)

;; mk = λt.t (mk t)
;; mkmk = λk.λt.t ((k k) t)
;; mk = (mkmk mkmk)

(((λ (t)
  ((λ (u) (u u))
   (λ (k)
     (t (lambda (v1 v2)
          (((k k) t) v1 v2))))))
 (λ (sum)
    (λ (n m)
      (if (zero? n)
          m
          (add1 (sum (sub1 n) m))))))
 2 3)
  

;; Y = λf.(λx.f (x x)) (λx.f (x x))

(((lambda (f)
  ((lambda (u) (u u))
   (lambda (x)
     (f (lambda (v1 v2) ((x x) v1 v2))))))
 (λ (sum)
    (λ (n m)
      (if (zero? n)
          m
          (add1 (sum (sub1 n) m))))))
 2 3)