#lang typed/racket

(struct pt ([x : Real] [y : Real]) #:transparent)
(struct color-pt pt ([c : String]) #:transparent)
(struct color-3d-pt pt ([z : Real]) #:transparent)

(struct circle ([center : pt] [r : Real]))
(struct color-circle ([center : color-pt] [r : Real]))

(: dist-to-origin (-> pt Real))
(define (dist-to-origin pt)
  (sqrt (+ (sqr (pt-x pt))
           (sqr (pt-y pt)))))

(: sum-of-dist (-> (Listof pt) Real))
(define (sum-of-dist pt-list)
  (foldl (lambda ([p : pt] [accu : Real])
           (+ (dist-to-origin p) accu))
         0
         pt-list))

(: replace-first (-> (MListof pt) Real Real Void))
(define (replace-first pts x y)
  (when (not (null? pts))
      (set-mcar! pts (pt x y))))

(: area (-> circle Real))
(define (area c)
  (* pi (sqr (circle-r c))))

(: transform-then-dist (-> (-> color-pt pt) color-pt Real))
(define (transform-then-dist f cpt)
  (dist-to-origin (f cpt)))

(: f1 (-> color-pt pt))
(define (f1 cp)
  (pt (pt-x cp) (pt-y cp)))

(: f2 (-> color-pt color-pt))
(define (f2 cpt)
  cpt)

(: f3 (-> pt color-pt))
(define (f3 p)
  (color-pt (add1 (pt-x p)) (sub1 (pt-y p)) "black"))

(: f4 (-> color-3d-pt pt))
(define (f4 c3p)
  (pt (pt-x c3p) (color-3d-pt-z c3p)))


(: tf (-> (-> color-pt pt) color-pt pt))
(define (tf f cp)
  (f cp))


(: color-pts (Listof color-pt))
(define color-pts
  (list (color-pt 1 1 "orange")
        (color-pt 2 2 "yellow")))

(: pts (Listof pt))
(define pts color-pts)

(: m-pts (MListof pt))
(define m-pts
  (mcons (pt 1 1) '()))

(: m-color-pts (MListof color-pt))
(define m-color-pts
  (mcons (color-pt 2 2 "yellow") '()))

;(: m-pts (MListof pt))
;(define m-pts m-color-pts)
