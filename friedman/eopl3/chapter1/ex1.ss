;; 1.15
;; duple : Nat * SchemeVal -> List(SchemeVal)
;; usage : (duple n x) returns a list containing n xs
(define duple
  (lambda (n x)
    (if (zero? n)
        '()
        (cons
         x
         (duple (sub1 n) x)))))

(assert
 (equal?
  (duple 2 3)
  (list 3 3)))

(assert
 (equal?
  (duple 4 '(ha ha))
  (list '(ha ha) '(ha ha) '(ha ha) '(ha ha))))

(assert
 (equal?
  (duple 0 '(blah))
  '()))


;; 1.16
;; invert : Listof(List(SchemeVal, SchemeVal)) ->
;;          Listof(List(SchemeVal, SchemeVal))
;; usage : (invert ((v1 v2) (v3 v4) ...)) =
;;         ((v2 v1) (v4 v3) ...)
(define invert
  (lambda (lst)
    (if (null? lst)
        '()
        (let ((hd (car lst)))
          (cons
           (list (cadr hd) (car hd))
           (invert (cdr lst)))))))

(assert
 (equal?
  (invert '((a 1) (a 2) (1 b) (2 b)))
  '((1 a) (2 a) (b 1) (b 2))))
