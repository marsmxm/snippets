(define A  ;; assumption
  (lambda (a b)
    ;; returns #t if a applied to b terminates,
    ;; #f otherwise
    ...))

(define B
  (letrec ([eternity
	    (lambda (x y)
	      (eternity x y))])
    (lambda (a b)
      (and (A a b)
	   (eternity a b)))))

(define C
  (lambda (a)
    (B a a)))

(C C)
;; => (B C C)
;; => (A C C) is true, eternity forever, or
;; => (A C C) is false, (B C C), thus (C C) terminates
;; a contradiction
