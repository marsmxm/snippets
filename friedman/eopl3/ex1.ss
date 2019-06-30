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
  '(d a () c a)))

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


;; 1.24
;; every : (SchemeVal -> Bool) * List(SchemeVal) -> Bool
;; usage : (every pred lst) returns #f if any element of lst fails to satisfy pred, and returns #t otherwise.
(define every?
  (lambda (pred lst)
    (if (null? lst)
	#t
	(and (pred (car lst))
	     (every? pred (cdr lst))))))

(assert
 (equal?
  (every? number? '(a b c 3 e))
  #f))

(assert
 (equal?
  (every? number? '(1 2 3 5 4))
  #t))


;; 1.25
;; exists? : (SchemeVal -> Bool) * List(SchemeVal) -> Bool
;; usage : (exists? pred lst) returns #t if any element of lst satisfies pred, and returns #f otherwise.
(define exists?
  (lambda (pred lst)
    (if (null? lst)
	#f
	(or (pred (car lst))
	    (exists? pred (cdr lst))))))

(assert
 (equal?
  (exists? number? '(a b c 3 e))
  #t))

(assert
 (equal?
  (exists? number? '(a b c d e))
  #f))


;; 1.26
;; up : List(SchemeVal) -> List(SchemeVal)
;; usage : (up lst) removes a pair of parentheses from each top-level element of lst.
;; If a top-level element is not a list, it is included in the result, as is.
(define up
  (lambda (lst)
    (if (null? lst)
	'()
	(if (atom? (car lst))
	    (cons (car lst)
		  (up (cdr lst)))
	    (append (car lst)
		    (up (cdr lst)))))))

(assert
 (equal?
  (up '((1 2) (3 4)))
  '(1 2 3 4)))

(assert
 (equal?
  (up '((x (y)) z))
  '(x (y) z)))


;; 1.27
(define flatten
  (lambda (lst)
    (if (null? lst)
	'()
	(cond
	 [(null? (car lst)) (flatten (cdr lst))]
	 [(atom? (car lst))
	  (cons (car lst)
		(flatten (cdr lst)))]
	 [else (append (flatten (car lst))
		       (flatten (cdr lst)))]))))

(assert
 (equal?
  (flatten '(a b c))
  '(a b c)))

(assert
 (equal?
  (flatten '((a) () (b ()) () (c)))
  '(a b c)))

(assert
 (equal?
  (flatten '((a b) c (((d)) e)))
  '(a b c d e)))

(assert
 (equal?
  (flatten '(a b (() (c))))
  '(a b c)))


;; 1.28
(define merge
  (lambda (loi1 loi2)
    (cond
     [(null? loi1) loi2]
     [(null? loi2) loi1]
     [else (let ((h1 (car loi1))
		 (h2 (car loi2)))
	     (if (<= h1 h2)
		 (cons h1
		       (merge (cdr loi1) loi2))
		 (cons h2
		       (merge loi1 (cdr loi2)))))])))

(assert
 (equal?
  (merge '(1 4) '(1 2 8))
  '(1 1 2 4 8)))

(assert
 (equal?
  (merge '(35 62 81 90 91) '(3 83 85 90))
  '(3 35 62 81 83 85 90 90 91)))


;; 1.29
(define my-sort
  (lambda (loi)
    (if (null? loi)
	'()
	(let ([hd (car loi)]
	      [tl (cdr loi)])
	  (let-values ([(smallers largers)
			(partition
			 (lambda (x) (<= x hd))
			 tl)])
	    (append
	     (my-sort smallers)
	     (cons hd
		   (my-sort largers))))))))

(assert
 (equal?
  (my-sort '(8 2 5 2 3))
  '(2 2 3 5 8)))


;; 1.30
(define sort/predicate
  (lambda (pred loi)
    (if (null? loi)
	'()
	(let ([hd (car loi)]
	      [tl (cdr loi)])
	  (let-values ([(smallers largers)
			(partition
			 (lambda (x) (pred x hd))
			 tl)])
	    (append
	     (sort/predicate pred smallers)
	     (cons hd
		   (sort/predicate pred largers))))))))

(assert
 (equal?
  (sort/predicate < '(8 2 5 2 3))
  '(2 2 3 5 8)))

(assert
 (equal?
  (sort/predicate > '(8 2 5 2 3))
  '(8 5 3 2 2)))


;; 1.31
;; Bintree ::= Int | (Symbol Bintree Bintree)
(define leaf
  (lambda (n) n))
(define interior-node
  (lambda (s t1 t2)
    (list s t1 t2)))
(define leaf?
  (lambda (t) (number? t)))
(define lson
  (lambda (node)
    (cadr node)))
(define rson
  (lambda (node)
    (caddr node)))
(define contents-of
  (lambda (t)
    (if (leaf? t)
        t
        (car t))))

;; 1.32 double tree
(define double-tree
  (lambda (t)
    (if (leaf? t)
        (leaf (* 2 (contents-of t)))
        (interior-node
         (contents-of t)
         (double-tree (lson t))
         (double-tree (rson t))))))

;; 1.33
(define mark-leaves-with-red-depth
  (lambda (t)
    (let f ((target t)
            (red-count 0))
      (if (leaf? target)
          (leaf red-count)
          (let ([new-count (if (eq? 'red (contents-of target))
                               (add1 red-count)
                               red-count)])
            (interior-node (contents-of target)
             (f (lson target) new-count)
             (f (rson target) new-count)))))))

;; 1.34
(define path
  (lambda (target bin-tree)
    (call/cc
     (lambda (k)
       (let f ([n target]
               [bint bin-tree])
         (if (null? bint)
             (k #f)
             (cond
              [(eq? n (car bint)) '()]
              [(< n (car bint))
               (cons 'left (f n (cadr bint)))]
              [else (cons 'right (f n (caddr bint)))])))))))

;; 1.35
(define number-leaves
  (lambda (bintree)
    (let ([count -1])
      (let f ([bt bintree])
        (if (leaf? bt)
            (begin (set! count (add1 count))
                   (leaf count))
            (let* ([ltree (f (lson bt))]
                   [rtree (f (rson bt))])
              (interior-node
               (contents-of bt)
               ltree
               rtree)))))))


;; 1.36
(define number-elements-from
    (lambda (lst n)
      (if (null? lst) '()
        (cons
         (list n (car lst))
         (number-elements-from (cdr lst) (+ n 1))))))
(define number-elements
  (lambda (lst) (number-elements-from lst 0)))


(define g
  (lambda (l1 l2)
    (if (null? l2)
        (cons l1 '())
        (cons l1
              (g
               (cons (add1 (caar l2))
                     (cdar l2))
               (cdr l2))))))
(define number-elements1
  (lambda (lst)
    (if (null? lst) '()
        (g (list 0 (car lst)) (number-elements (cdr lst))))))
