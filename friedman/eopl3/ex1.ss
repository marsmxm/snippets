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


;; 1.17
;; down : List(SchemeVal) -> List(List(SchemeVal))
;; usage : (down (v1 v2 ...)) = ((v1) (v2) ...)
(define down
  (lambda (lst)
    (if (null? lst)
        '()
        (cons
         (list (car lst))
         (down (cdr lst))))))

(assert
 (equal?
  (down '(1 2 3))
  '((1) (2) (3))))

(assert
 (equal?
  (down '((a) (fine) (idea)))
  '(((a)) ((fine)) ((idea)))))

(assert
 (equal?
  (down '(a (more (complicated)) object))
  '((a) ((more (complicated))) (object))))


;; 1.18
;; swapper : Sym * Sym * S-list -> S-list
;; usage : (swapper 'a 'b '(a b c)) = '(b a c)
(define swapper
  (lambda (s1 s2 slist)
    (cond
     ([null? slist] '())
     (else (let ([head (car slist)]
                 [tail (cdr slist)])
             (cond
              ([atom? head]
               (cond
                ([eq? head s1] (cons
                                s2
                                (swapper s1 s2 tail)))
                ([eq? head s2] (cons
                                s1
                                (swapper s1 s2 tail)))
                (else (cons head (swapper s1 s2 tail)))))
              (else (cons
                     (swapper s1 s2 head)
                     (swapper s1 s2 tail)))))))))

(assert
 (equal?
  (swapper 'a 'd '(a b c d))
  '(d b c a)))

(assert
 (equal?
  (swapper 'a 'd '(a d () c d))
  '(d a () c a))

 (assert
  (equal?
   (swapper 'x 'y '((x) y (z (x))))
   '((y) x (z (y)))))


;; 1.19
;; list-set : List(SchemeVal) * Nat * SchemeVal -> List(SchemeVal)
;; usage (list-set (v1 v2 ... vi ... vn) i x) = (v1 v2 ... x ... vn)
(define list-set
  (lambda (lst n x)
    (if (null? lst)
        '()
        (if (zero? n)
            (cons x (cdr lst))
            (cons (car lst)
                  (list-set (cdr lst) (sub1 n) x))))))

(assert
 (equal?
  (list-set '(a b c d) 2 '(1 2))
  '(a b (1 2) d)))

(assert
 (equal?
  (list-ref (list-set '(a b c d) 3 '(1 5 10)) 3)
  '(1 5 10)))

;; 1.20
;; count-occurrences : Sym * S-list -> Nat
;; usage (count-occurrences s slist) = occurrences of s in slist
(define count-occurrences
  (lambda (s slist)
    (cond
     ([null? slist] 0)
     ([atom? (car slist)]
      (if (eq? (car slist) s)
          (+ 1 (count-occurrences s (cdr slist)))
          (count-occurrences s (cdr slist))))
     (else (+ (count-occurrences s (car slist))
              (count-occurrences s (cdr slist)))))))

(assert
 (equal?
  (count-occurrences 'x '((f x) y (((x z) x))))
  3))

(assert
 (equal?
  (count-occurrences 'x '((f x) y (((x z) () x))))
  3))

(assert
 (equal?
  (count-occurrences 'w '((f x) y (((x z) x))))
  0))


;; 1.21
;; product : Listof(Sym) * Listof(Sym) -> Listof(Sym)
;; usage ; (product '(a b) '(c d e)) = '((a c) (a d) (a e) (b c) (b d) (b e))
(define product
  (lambda (sos1 sos2)
    (if (null? sos1)
        '()
        (append
         (map
          (lambda (s2)
            (list (car sos1) s2))
          sos2)
         (product (cdr sos1) sos2)))))

(assert
 (equal?
  (product '(a b c) '(x y))
  '((a x) (a y) (b x) (b y) (c x) (c y))))


;; 1.22
;; filter-in : (SchemeVal -> Bool) * List(SchemeVal) -> List(SchemeVal)
;; usage : (filter-in pred lst) returns a new list containing only lst's elements x,
;; that (pred x) = #t
(define filter-in
  (lambda (pred lst)
    (if (null? lst)
        '()
        (if (pred (car lst))
            (cons
             (car lst)
             (filter-in pred (cdr lst)))
            (filter-in pred (cdr lst))))))

(assert
 (equal?
  (filter-in number? '(a 2 (1 3) b 7))
  '(2 7)))

(assert
 (equal?
  (filter-in symbol? '(a (b c) 17 foo))
  '(a foo)))


;; 1.23
;; list-index : (SchemeVal -> Bool) * List(SchemeVal) -> Nat or #f
;; usage : (list-index pred lst) returns the 0-based position of the first element
;; of lst that satisfies the predicate pred. If no element of lst
;; satisfies the predicate, then list-index returns #f.
(define list-index
  (lambda (pred lst)
    (let f ([lst0 lst]
            [n 0])
      (if (null? lst0)
          #f
          (if (pred (car lst0))
              n
              (f (cdr lst0) (add1 n)))))))

(assert
 (equal?
  (list-index number? '(a 2 (1 3) b 7))
  1))

(assert
 (equal?
  (list-index symbol? '(a (b c) 17 foo))
  0))

(assert
 (equal?
  (list-index symbol? '(1 2 (a b) 3))
  #f))
