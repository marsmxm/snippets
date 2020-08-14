;; ex 6.3
; (lambda (x y) (p (+ 8 x) (q y))) =>
(lambda (x y cont)
  (q y (lambda (val)
	 (p (+ 8 x) val cont))))

; (lambda (x y u v) (+ 1 (f (g x y) (+ u v))))
(lambda (x y u v cont)
  (g x y
     (lambda (v1)
       (f v1 (+ u x)
	  (lambda (v2)
	    (cont (+ 1 v2)))))))

; (+ 1 (f (g x y) (+ u (h v))))
(g x y
   (lambda (v1)
     (h v
	(lambda (v2)
	  (f v1 (+ u v2)
	     (lambda (v3)
	       (+ 1 v3)))))))

; (zero? (if a (p x) (p y)))
(if a
    (p x
       (lambda (v1)
	 (zero? v1)))
    (p y
       (lambda (v2)
	 (zero? v2))))

; (zero? (if (f a) (p x) (p y)))
(f a
   (lambda (v1)
     (if v1
	 (p x
	    (lambda (v2)
	      (zero? v2)))
	 (p y
	    (lambda (v3)
	      (zero? v3))))))

;; (let ((x (let ((y 8))
;; 	   (p y))))
;;   x)
(let ((y 8))
  (p y
     (lambda (v1)
       (let ((x v1))
	 x))))

;; (let ((x (if a
;; 	     (p x)
;; 	     (p y))))
;;   x)
;; 1
(if a
    (p x
       (lambda (v1)
	 (let ((x v1))
	   x)))
    (p y
       (lambda (v2)
	 (let ((x v2))
	   x))))
;; 2
(let ([cont (lambda (v)
	      (let ((x v))
		x))])
  (if a
      (p x cont)
      (p y cont)))




