;;#lang racket

(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

;; Ex 1.11
(define (f1 n)
  (if (< n 3)
      n
      (+ (f1 (- n 1)) (* 2 (f1 (- n 2))) (* 3 (f1 (- n 3))))))

(define (f2 n)
  (define (f2-iter a b c counter)
    (if (zero? counter)
        c
        (f2-iter (+ a (* 2 b) (* 3 c)) a b (sub1 counter))))
  (f2-iter 2 1 0 n))

					; Ex 1.12
					;     1
					;    1 1
					;   1 2 1
					;  1 3 3 1
					; 1 4 6 4 1
(define (pt r c)
  (if (or (equal? c 1)
          (equal? r c))
      1
      (+ (pt (sub1 r) (sub1 c))
         (pt (sub1 r) c))))

;; Ex 1.16
;; fast-exp-iter
(define (expt b n)
  (if (= n 0)
      1
      (* b (expt b (- n 1)))))

(define (fast-expt1 b n)
  (cond ((= n 0) 1)
        ((even? n) (sqr (fast-expt1 b (/ n 2))))
        (else (* b (fast-expt1 b (- n 1))))))

(define (fast-expt2 b n)
  (define (fast-expt-iter b n a)
    (cond [(zero? n) a]
          [(even? n) (fast-expt-iter (sqr b) (/ n 2) a)]
          [else (fast-expt-iter b (sub1 n) (* a b))]))
  (fast-expt-iter b n 1))

;; Ex 1.17
					;(define (* a b)
					;  (if (= b 0)
					;      0
					;      (+ a (* a (- b 1)))))
(define (fast-mult a b)
  (define (double x) (* x 2))
  (define (halve x) (/ x 2))
  (cond [(zero? b) 0]
        [(even? b) (fast-mult (double a) (halve b))]
        [else (+ a (fast-mult a (sub1 b)))]))
;; Ex 1.18
(define (fast-mult2 a b)
  (define (double x) (* x 2))
  (define (halve x) (/ x 2))
  (define (fast-mult-iter a b c)
    (cond [(zero? b) c]
          [(even? b) (fast-mult-iter (double a)
                                     (halve b)
                                     c)]
          [else (fast-mult-iter a (sub1 b) (+ c a))]))
  (fast-mult-iter a b 0))

;; Ex 1.19
(define (fib n)
  (define (fib-iter a b count)
    (if (= count 0)
        b
        (fib-iter (+ a b) a (- count 1))))
  (fib-iter 1 0 n))

(define (fib2 n) ;wrong
  (define (fib-iter a b p q count)
    (cond ((= count 0) b)
          ((even? count)
           (fib-iter a
                     b
                     (+ p q) ; compute p’
                     p       ; compute q’ 
                     (/ count 2)))
          (else (fib-iter (+ (* b q) (* a q) (* a p))
                          (+ (* b p) (* a q))
                          p
                          q
                          (- count 1)))))
  (fib-iter 1 0 0 1 n))


;; Exercise 2.28
(define (fringe l)
  (cond [(null? l) null]
        [(pair? l) (append (fringe (car l))
                           (fringe (cdr l)))]
        [else (list l)]))

;; Exercise 2.29
(define (make-mobile left right)
  (list left right))

(define (left-branch mobile)
  (car mobile))

(define (right-branch mobile)
  (car (cdr mobile)))

(define (make-branch length structure)
  (list length structure))

(define (branch-length branch)
  (car branch))

(define (branch-structure branch)
  (car (cdr branch)))

(define (total-weight mobile)
  (letrec ([left (left-branch mobile)]
           [right (right-branch mobile)]
           [left-structure (branch-structure left)]
           [right-structure (branch-structure right)]
           [structure-weight (lambda (s)
                               (if (not (pair? s))
                                   s
                                   (total-weight s)))])
    (+ (structure-weight left-structure)
       (structure-weight right-structure))))

(define (mobile-balanced? mobile)
  (letrec ([left (left-branch mobile)]
           [right (right-branch mobile)]
           [left-structure (branch-structure left)]
           [right-structure (branch-structure right)]
           [structure-weight (lambda (s)
                               (if (not (pair? s))
                                   s
                                   (total-weight s)))]
           [structure-balanced? (lambda (s)
                                  (if (not (pair? s))
                                      #t
                                      (mobile-balanced? s)))])
    (and (eq? (* (branch-length left) (structure-weight left-structure))
              (* (branch-length right) (structure-weight right-structure)))
         (structure-balanced? left-structure))
    (structure-balanced? right-structure)))

					;(define (make-mobile left right)
					;  (cons left right))
					;(define (right-branch mobile)
					;  (cdr mobile))
					;
					;(define (make-branch length structure)
					;  (cons length structure))
					;(define (branch-structure branch)
					;  (cdr branch))

;; Exercise 2.30
(define (map-mine proc items)
  (if (null? items)
      null
      (cons (proc (car items))
            (map-mine proc (cdr items)))))

(define (square-tree tree)
  (map-mine (lambda (sub-tree)
              (if (pair? sub-tree)
                  (square-tree sub-tree)
                  (* sub-tree sub-tree)))
            tree))

(define (square-tree-low tree)
  (cond [(null? tree) null]
        [(pair? tree) (cons (square-tree-low (car tree))
                            (square-tree-low (cdr tree)))]
        [else (* tree tree)]))

;; Exercise 2.32
(define (subsets s)
  (if (null? s)
      (list null)
      (let ((rest (subsets (cdr s))))
        (append rest (map-mine (lambda (elem) (cons (car s) elem)) rest)))))

;; Exercise 2.33
;; fold-right
(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (map-accu p sequence)
  (accumulate (lambda (x y) (cons (p x) y)) null sequence))

(define (append-accu seq1 seq2)
  (accumulate cons seq2 seq1))

(define (length-accu sequence)
  (accumulate (lambda (x y) (add1 y)) 0 sequence))

;; Exercise 2.34
(define (horner-eval x coefficient-sequence)
  (accumulate (lambda (this-coeff higher-terms)
                (+ this-coeff (* x higher-terms)))
              0
              coefficient-sequence))

;; Exercise 2.35
(define (count-leaves-old x)
  (cond ((null? x) 0)
        ((not (pair? x)) 1)
        (else (+ (count-leaves-old (car x))
                 (count-leaves-old (cdr x))))))

(define (count-leaves t)
  (accumulate + 0 (map-mine (lambda (sub-t)
                              (if (pair? sub-t)
                                  (count-leaves sub-t)
                                  1))
                            t)))

;; Exercise 2.36
(define (accumulate-n op init seqs)
  (if (null? (car seqs))
      null
      (cons (accumulate op init (map-mine car seqs))
            (accumulate-n op init (map-mine cdr seqs)))))

;; Exercise 2.37
(define (dot-product v w)
  (accumulate + 0 (map * v w)))

(define (matrix-*-vector m v) (map (lambda (mv) (dot-product mv v)) m))

(define (transpose mat) (accumulate-n cons null mat))

(define (matrix-*-matrix m n)
  (let ((cols (transpose n)))
    (map (lambda (row)
           (map (lambda (col) (dot-product row col)) cols))
         m)))

;; Exercise 2.39
(define (fold-left op initial sequence)
  (define (iter result rest)
    (if (null? rest)
        result
        (iter (op result (car rest))
              (cdr rest))))
  (iter initial sequence))

(define fold-right accumulate)

(define (reverse0 xs)
  (if (null? xs)
      null
      (append (reverse0 (cdr xs)) (list (car xs)))))

(define (reverse1 sequence)
  (fold-right (lambda (x y) (append y (list x))) null sequence))
(define (reverse2 sequence)
  (fold-left (lambda (x y) (cons y x)) null sequence))

;; Exercise 2.40
(define (enumerate-interval low high)
  (if (> low high)
      null
      (cons low (enumerate-interval (+ low 1) high))))

(define (flatmap proc seq)
  (accumulate append null (map proc seq)))

(define (unique-pairs n)
  (flatmap
   (lambda (i)
     (map
      (lambda (j) (list i j))
      (enumerate-interval 1 (sub1 i))))
   (enumerate-interval 1 n)))

;;(require math/number-theory)
(define (prime-sum? pair)
  (prime? (+ (car pair) (cadr pair))))
(define (make-pair-sum pair)
  (list (car pair) (cadr pair) (+ (car pair) (cadr pair))))
(define (prime-sum-pairs n)
  (map make-pair-sum
       (filter prime-sum?
               (flatmap
                (lambda (i)
                  (map (lambda (j) (list i j))
                       (enumerate-interval 1 (- i 1))))
                (enumerate-interval 1 n)))))
(define (prime-sum-pairs1 n)
  (map make-pair-sum
       (filter prime-sum?
               (unique-pairs n))))

;; Exercise 2.41
(define (fix-sum-triples n s)
  (filter (lambda (t) (= s (+ (car t) (cadr t) (caddr t))))
          (flatmap
           (lambda (i)
             (flatmap
              (lambda (j)
                (map (lambda (k) (list i j k))
                     (enumerate-interval 1 (sub1 j))))
              (enumerate-interval 1 (sub1 i))))
           (enumerate-interval 1 n))))

;; Exercise 2.42
(define empty-board '())

(define (adjoin-position new-row k rest-of-queens)
  (cons (cons k new-row) rest-of-queens))

(define (safe? k positions)
  (letrec ([new-row (cdr (car positions))]
           [iter (lambda (n positions)
                   (cond [(= n k) #t]
                         [(= new-row (cdr (car positions))) #f] ;; same row
                         [(= (abs (- new-row (cdr (car positions))))
                             (- k (car (car positions)))) #f] ;; same diagonal
                         [else (iter (add1 n) (cdr positions))]))])
    (iter 1 (cdr positions))))

(define (queens board-size)
  (define (queen-cols k)
    (if (= k 0)
        (list empty-board)
        (filter
         (lambda (positions) (safe? k positions))
         (flatmap
          (lambda (rest-of-queens)
            (map (lambda (new-row)
                   (adjoin-position new-row
                                    k
                                    rest-of-queens))
                 (enumerate-interval 1 board-size)))
          (queen-cols (- k 1))))))
  (queen-cols board-size))


;; 2.2.4 Example: A Picture Language

;; vector
(define (make-vect x y)
  (cons x y))
(define (xcor-vect v)
  (car v))
(define (ycor-vect v)
  (cdr v))
(define (dot-vect operator)
  (lambda (v1 v2)
    (make-vect (operator (xcor-vect v1) (xcor-vect v2))
               (operator (ycor-vect v1) (ycor-vect v2)))))
(define add-vect (dot-vect +))
(define sub-vect (dot-vect -))
(define (scale-vect v s)
  (make-vect (* s (xcor-vect v))
             (* s (ycor-vect v))))

;; frame
(define (make-frame origin edge1 edge2)
  (list origin edge1 edge2))
(define (origin-frame frame)
  (car frame))
(define (edge1-frame frame)
  (cadr frame))
(define (edge2-frame frame)
  (caddr frame))

(define (frame-coord-map frame)
  (lambda (v)
    (add-vect
     (origin-frame frame)
     (add-vect (scale-vect (xcor-vect v)
                           (edge1-frame frame))
               (scale-vect (ycor-vect v)
                           (edge2-frame frame))))))

;; segment
(define (make-segment start-v end-v)
  (cons start-v end-v))
(define (start-segment seg)
  (car seg))
(define (end-segment seg)
  (cdr seg))

					;(define (segments->painter segment-list)
					;  (lambda (frame)
					;    (for-each
					;     (lambda (segment)
					;       (draw-line
					;        ((frame-coord-map frame)
					;         (start-segment segment))
					;        ((frame-coord-map frame)
					;         (end-segment segment))))
					;     segment-list)))

(define (transform-painter painter origin corner1 corner2)
  (lambda (frame)
    (let ((m (frame-coord-map frame)))
      (let ((new-origin (m origin)))
        (painter (make-frame
                  new-origin
                  (sub-vect (m corner1) new-origin)
                  (sub-vect (m corner2) new-origin)))))))

(define (flip-vert painter)
  (transform-painter
   painter
   (make-vect 0.0 1.0) ;new origin
   (make-vect 1.0 1.0) ;new end of edge1
   (make-vect 0.0 0.0))) ;new end of edge2

(define (shrink-to-upper-right painter)
  (transform-painter
   painter (make-vect 0.5 0.5)
   (make-vect 1.0 0.5) (make-vect 0.5 1.0)))

(define (rotate90 painter)
  (transform-painter painter
                     (make-vect 1.0 0.0)
                     (make-vect 1.0 1.0)
                     (make-vect 0.0 0.0)))

(define (squash-inwards painter)
  (transform-painter painter
                     (make-vect 0.0 0.0)
                     (make-vect 0.65 0.35)
                     (make-vect 0.35 0.65)))

(define (beside painter1 painter2)
  (let ((split-point (make-vect 0.5 0.0)))
    (let ((paint-left
           (transform-painter
            painter1
            (make-vect 0.0 0.0)
            split-point
            (make-vect 0.0 1.0)))
          (paint-right
           (transform-painter
            painter2
            split-point
            (make-vect 1.0 0.0)
            (make-vect 0.5 1.0))))
      (lambda (frame)
        (paint-left frame)
        (paint-right frame)))))

(define below 1)

(define flip-horiz 1)

(define rotate180 1)

					;(define (right-split painter n)
					;  (if (= n 0)
					;      painter
					;      (let ([smaller (right-split painter (- n 1))])
					;        (beside painter (below smaller smaller)))))
					;
					;(define (up-split painter n)
					;  (if (= n 0)
					;      painter
					;      (let ([smaller (up-split painter (- n 1))])
					;        (below painter (beside smaller smaller)))))

(define (split place-self place-smaller)
  (lambda (painter n)
    (if (= n 0)
        painter
        (let ([smaller ((split place-self place-smaller) painter (sub1 n))])
          (place-self painter (place-smaller smaller))))))

(define right-split (split beside below))
(define up-split (split below beside))

(define (corner-split painter n)
  (if (= n 0)
      painter
      (let ([up (up-split painter (- n 1))]
            [right (right-split painter (- n 1))])
        (let ([top-left (beside up up)]
              [bottom-right (below right right)]
              [corner (corner-split painter (- n 1))])
          (beside (below painter top-left)
                  (below bottom-right corner))))))


(define (square-of-four tl tr bl br)
  (lambda (painter)
    (let ([top (beside (tl painter) (tr painter))]
          [bottom (beside (bl painter) (br painter))])
      (below bottom top))))

					;(define (flipped-pairs painter)
					;  (let ((painter2 (beside painter (flip-vert painter))))
					;    (below painter2 painter2)))

(define (flipped-pairs painter)
  (let ([combine4 (square-of-four identity flip-vert
                                  identity flip-vert)])
    (combine4 painter)))

					;(define (square-limit painter n)
					;  (let ([quarter (corner-split painter n)])
					;    (let ([half (beside (flip-horiz quarter) quarter)])
					;      (below (flip-vert half) half))))

(define (square-limit painter n)
  (let ([combine4 (square-of-four flip-horiz identity
                                  rotate180 flip-vert)])
    (combine4 (corner-split painter n))))


;; 2.3.2 Example: Symbolic Differentiation
(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp) (if (same-variable? exp var) 1 0))
        ((sum? exp) (make-sum (deriv (addend exp) var)
                              (deriv (augend exp) var)))
        ((product? exp)
         (make-sum
          (make-product (multiplier exp)
                        (deriv (multiplicand exp) var))
          (make-product (deriv (multiplier exp) var)
                        (multiplicand exp))))
        ((exponentiation? exp)
         (make-product
          (make-product
           (exponent exp)
           (make-exponentiation (base exp) (sub1 (exponent exp))))
          (deriv (base exp) var)))
        (else
         (error "unknown expression type: DERIV" exp))))

(define (=number? exp num) (and (number? exp) (= exp num)))

(define (rm-num xs num)
  (cond ((null? xs) null)
        ((=number? (car xs) num) (rm-num (cdr xs) num))
        (else (cons (car xs) (rm-num (cdr xs) num)))))

(define (variable? x) (symbol? x))

(define (same-variable? v1 v2)
  (and (variable? v1) (variable? v2) (eq? v1 v2)))

(define (make-sum a1 a2 . rest)
  (let* ([operands (cons a1 (cons a2 rest))]
         [tup
          (accumulate
           (lambda (cur accu)
             (if (number? cur)
                 (cons (+ cur (car accu)) (cdr accu))
                 (cons (car accu) (cons cur (cdr accu)))))
           '(0)
           operands)])
    (cond
     [(null? (cdr tup)) (car tup)]
     [(= 0 (car tup)) (cons '+ (cdr tup))]
     [else (cons '+ tup)])))

(define (sum? x) (and (pair? x) (eq? (car x) '+)))

(define (addend s) (cadr s))

(define (augend s)
  (if (= (length (cddr s)) 1)
      (caddr s)
      (apply make-sum (cddr s))))

(define (make-product m1 m2) (list '* m1 m2))

(define (product? x) (and (pair? x) (eq? (car x) '*)))

(define (multiplier p) (cadr p))

(define (multiplicand p) (caddr p))

(define (make-exponentiation base exponent)
  (cond
   ((=number? exponent 0) 1)
   ((=number? exponent 1) base)
   ((=number? base 0) 0)
   ((=number? base 1) 1)
   (else (list '** base exponent))))

(define (exponentiation? x) (and (pair? x) (eq? (car x) '**)))

(define (base e) (cadr e))

(define (exponent e) (caddr e))


;; 2.3.3

(define (element-of-set? x set)
  (cond
   ((null? set) false)
   ((equal? x (car set)) true)
   (else (element-of-set? x (cdr set)))))

(define (adjoin-set x set)
  (if (element-of-set? x set)
      set
      (cons x set)))

(define (intersection-set set1 set2)
  (cond
   ((or (null? set1) (null? set2)) '())
   ((element-of-set? (car set1) set2)
    (cons (car set1)
	  (intersection-set (cdr set1) set2)))
   (else (intersection-set (cdr set1) set2))))

(define (union-set s1 s2)
  (cond
   [(null? s1) s2]
   [(element-of-set? (car s1) s2) (union-set (cdr s1) s2)]
   [else (cons (car s1) (union-set (cdr s1) s2))]))


(define (element-of-set-ordered? x set)
  (cond
   [(null? set) #f]
   [(= x (car set)) #t]
   [(< x (car set)) #f]
   [else (element-of-set? x (cdr set))]))

(define (intersection-set-ordered set1 set2)
  (if (or (null? set1) (null? set2))
      '()
      (let ((x1 (car set1)) (x2 (car set2)))
	(cond
	 [(= x1 x2) (cons x1 (intersection-set-ordered
			      (cdr set1)
			      (cdr set2)))]
	 [(< x1 x2) (intersection-set-ordered (cdr set1) set2)]
	 [(> x1 x2) (intersection-set-ordered set1 (cdr set2))]))))

(define (adjoin-set-ordered x set)
  (cond
   [(null? set) (cons x null)]
   [(<= x (car set)) (cons x set)]
   [else (cons (car set) (adjoin-set-ordered x (cdr set)))]))

(define (union-set-ordered set1 set2)
  (cond
   [(null? set1) set2]
   [(< (car set1) (car set2))
    (cons (car set1) (union-set-ordered (cdr set1) set2))]
   [(= (car set1) (car set2))
    (cons (car set1) (union-set-ordered (cdr set1) (cdr set2)))]
   [(> (car set1) (car set2))
    (cons (car set2) (union-set-ordered set1 (cdr set2)))]))

;; set as tree
(define (entry tree) (car tree))

(define (left-branch tree) (cadr tree))

(define (right-branch tree) (caddr tree))

(define (make-tree entry left right)
  (list entry left right))

(define (adjoin-set-tree x set)
  (cond
   ((null? set) (make-tree x '() '()))
   ((= x (entry set)) set)
   ((< x (entry set))
    (make-tree (entry set)
	       (adjoin-set x (left-branch set))
	       (right-branch set)))
   ((> x (entry set))
    (make-tree (entry set) (left-branch set)
	       (adjoin-set x (right-branch set))))))

(define (tree->list-1 tree)
  (if (null? tree)
      '()
      (append (tree->list-1 (left-branch tree))
	      (cons (entry tree)
		    (tree->list-1
		     (right-branch tree))))))

(define (tree->list-2 tree)
  (define (copy-to-list tree result-list)
    (if (null? tree)
	result-list
	(copy-to-list (left-branch tree)
		      (cons (entry tree)
			    (copy-to-list
			     (right-branch tree)
			     result-list)))))
  (copy-to-list tree '()))

(define (list->tree elements)
  (car (partial-tree elements (length elements))))

;; (define (partial-tree elts n)
;;   (if (= n 0)
;;       (cons '() elts)
;;       (let ((left-size (quotient (- n 1) 2)))
;; 	(let ((left-result
;; 	       (partial-tree elts left-size)))
;; 	  (let ((left-tree (car left-result))
;; 		(non-left-elts (cdr left-result))
;; 		(right-size (- n (+ left-size 1))))
;; 	    (let ((this-entry (car non-left-elts))
;; 		  (right-result
;; 		   (partial-tree
;; 		    (cdr non-left-elts)
;; 		    right-size)))
;; 	      (let ((right-tree (car right-result))
;; 		    (remaining-elts
;; 		     (cdr right-result)))
;; 		(cons (make-tree this-entry
;; 				 left-tree
;; 				 right-tree)
;; 		      remaining-elts))))))))

;; divide elts list to three parts: elts for left-tree, entry and
;; elts for right-tree.
;; Then recursively apply 'partial-tree to left and right trees.
(define (partial-tree elts n)
  (if (= n 0)
      (cons '() elts)
      (let* ([left-size (quotient (- n 1) 2)]
	     [left-result (partial-tree elts left-size)]
	     [left-tree (car left-result)]
	     [non-left-elts (cdr left-result)]
	     [this-entry (car non-left-elts)]
	     [right-size (- n (+ left-size 1))]
	     [right-result (partial-tree (cdr non-left-elts)
					 right-size)]
	     [right-tree (car right-result)]
	     [remaining-elts (cdr right-result)])
	(cons (make-tree this-entry
			 left-tree
			 right-tree)
	      remaining-elts))))

(define (union-set-tree set1 set2)
  (let ([list1 (tree->list-1 set1)]
	[list2 (tree->list-1 set2)])
    (list->tree (union-set-ordered list1 list2))))

(define (intersection-set-tree set1 set2)
  (let ([list1 (tree->list-1 set1)]
	[list2 (tree->list-1 set2)])
    (list->tree (intersection-set-ordered list1 list2))))


;; Exercise 2.66
(define (lookup given-key set-of-records)
  (cond
   [(null? set-of-records) #f]
   [(equal? (key (entry set-of-records)) given-key)
    (entry set-of-records)]
   [(< given-key (entry set-of-records))
    (lookup given-key (left-branch set-of-records))]
   [else (lookup given-key (right-branch set-of-records))]))


;; 2.3.4  Example: Huffman Encoding Trees
(define (make-leaf symbol weight)
  (list 'leaf symbol weight))
(define (leaf? object)
  (eq? (car object) 'leaf))
(define (symbol-leaf x) (cadr x))
(define (weight-leaf x) (caddr x))

(define (make-code-tree left right)
  (list left
        right
        (append (symbols left) (symbols right))
        (+ (weight left) (weight right))))

(define (left-branch tree) (car tree))
(define (right-branch tree) (cadr tree))

(define (symbols tree)
  (if (leaf? tree)
      (list (symbol-leaf tree))
      (caddr tree)))

(define (weight tree)
  (if (leaf? tree)
      (weight-leaf tree)
      (cadddr tree)))

(define (adjoin-set x set)
  (cond ((null? set) (list x))
	((< (weight x) (weight (car set))) (cons x set))
	(else (cons (car set)
		    (adjoin-set x (cdr set))))))

(define (make-leaf-set pairs)
  (if (null? pairs)
      '()
      (let ((pair (car pairs)))
        (adjoin-set (make-leaf (car pair)    ; symbol
                               (cadr pair))  ; frequency
                    (make-leaf-set (cdr pairs))))))

(define (generate-huffman-tree pairs)
  (define (successive-merge leaf-set)
    (cond
     [(null? leaf-set) '()]
     [(= 1 (length leaf-set)) (car leaf-set)]
     [else (successive-merge
	    (adjoin-set (make-code-tree (car leaf-set)
					(cadr leaf-set))
			(cddr leaf-set)))]))
  (successive-merge (make-leaf-set pairs)))

(define (decode bits tree)
  (define (choose-branch bit branch)
    (cond
     ((= bit 0) (left-branch branch))
     ((= bit 1) (right-branch branch))
     (else (error 'chosse-branch "bad bit" bit))))
  (define (decode-1 bits current-branch)
    (if (null? bits)
        '()
        (let ((next-branch
               (choose-branch (car bits) current-branch)))
          (if (leaf? next-branch)
              (cons (symbol-leaf next-branch)
                    (decode-1 (cdr bits) tree))
              (decode-1 (cdr bits) next-branch)))))
  (decode-1 bits tree))

(define (encode-symbol char tree)
  (let* ([include-char?
	  (lambda (char chars)
	    (not (not (memq char chars))))])
    (cond
     [(not (include-char? char (symbols tree)))
      (error 'encode "unexpected symbol" char)]
     [(leaf? tree) '()]
     [(include-char? char (symbols (left-branch tree)))
      (cons 0 (encode-symbol char (left-branch tree)))]
     [else (cons 1 (encode-symbol char (right-branch tree)))])))

(define (encode message tree)
  (if (null? message)
      '()
      (append (encode-symbol (car message) tree)
              (encode (cdr message) tree))))


;; Exercise 2.78
(define (attach-tag type-tag contents)
  (cond
   [(eq? type-tag 'scheme-number) contents]
   [else (cons type-tag contents)]))

(define (type-tag datum)
  (cond
   [(number? datum) 'scheme-number]
   [(pair? datum) (car datum)]
   [else (error 'type-tag "Bad tagged datum" datum)]))

(define (contents datum)
  (cond
   [(number? datum) datum]
   [(pair? datum) (cdr datum)]
   [else (error 'contents "Bad tagged datum" datum)]))


;; Exercise 3.1
(define (make-accumulator initial)
  (lambda (amount)
    (set! initial (+ initial amount))
    initial))


;; Exercise 3.2
(define (make-monitored f)
  (let ([count 0])
    (lambda (m)
      (case m
	[(how-many-calls?) count]
	[(reset-count) (set! count 0)]
	[else (set! count (add1 count))
	      (f m)]))))


;; Exercise 3.3, 3.4
(define (make-account balance password)
  (define incorrects 0)
  (define (call-the-cops) "Cops are comming")
  (define (withdraw amount)
    (if (>= balance amount)
        (begin (set! balance (- balance amount))
               balance)
        "Insufficient funds"))
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)
  (define (dispatch input-pswd m)
    (cond
     ((not (eq? password input-pswd)) 
      (lambda (amount)
	(if (>= incorrects 7)
	    (call-the-cops)
	    (begin (set! incorrects (add1 incorrects))
		   "Incorrect password"))))
     (else (set! incorrects 0)
	   (cond
	    ((eq? m 'withdraw) withdraw)
	    ((eq? m 'deposit) deposit)
	    (else (error 'make-account "Unknown request" m))))))
  dispatch)


;; Exercise 3.5
(define (random-in-range low high)
  (let ((range (- high low)))
    (+ low (random range))))

(define (monte-carlo trials experiment)
  (define (iter trials-remaining trials-passed)
    (cond
     ((= trials-remaining 0)
      (/ trials-passed trials))
     ((experiment)
      (iter (- trials-remaining 1) (+ trials-passed 1)))
     (else
      (iter (- trials-remaining 1) trials-passed))))
  (iter trials 0))

(define (estimate-integral predicate x1 x2 y1 y2 trials)
  (let ([rect-area (* (- x2 x1) (- y2 y1))]
	[experiment
	 (lambda ()
	   (predicate (random-in-range x1 x2)
		      (random-in-range y1 y2)))])
    (* rect-area (monte-carlo trials experiment))))

;; (exact->inexact 
;;  (/ (estimate-integral 
;;      (lambda (x y) (<= (+ (* (- x 5) (- x 5))
;; 			  (* (- y 7) (- y 7)))
;; 		       9)) 
;;      2 8 4 10 1000000)
;;     9))


;; Exercise 3.6
(define rand
  (let ((x random-init))
    (lambda (m)
      (case m
	[(generate) 
	 (set! x (rand-update x))
	 x]
	[(reset)
	 (lambda (init)
	   (set! x init))]))))


