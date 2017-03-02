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
   ((null? set) #f)
   ((equal? x (car set)) #t)
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
(define random-init 0)
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


;; Exercise 3.8
(define f
  (let ([state -1])
    (lambda (num)
      (if (eq? state 0)
	  0
	  (begin (set! state num)
		 num)))))


;; Exercise 3.16
(define (count-pairs x)
  (if (not (pair? x))
      0
      (+ (count-pairs (car x))
         (count-pairs (cdr x))
	 1)))

(count-pairs '(a b c))
;; => 3

(let* ([third '(c)]
       [second (cons 'b third)]
       [first (cons third second)])
  (count-pairs first))
;; => 4

(let* ([third '(c)]
       [second (cons third third)]
       [first (cons second second)])
  (count-pairs first))
;; => 7

;; (let* ([third '(c)]
;;        [second (cons 'b third)]
;;        [first (cons 'a second)])
;;   (set-cdr! third first)
;;   (count-pairs first))
;; => never return


;; Exercise 3.17
(define count-pairs-good
  (letrec ([last-pair
	    (lambda (xs)
	      (if (null? (cdr xs))
		  xs
		  (last-pair (cdr xs))))])
    (lambda (ls)
      (letrec ([helper
		(lambda (xs seen)
		  (if (or (not (pair? xs))
			  (memq xs seen))
		      0
		      (begin (set-cdr! (last-pair seen) (list xs))
			     (+ (helper (car xs) seen)
				(helper (cdr xs) seen)
				1))))])
	(helper ls '(()))))))


;; Exercise 3.18
(define list-cyclic?
  (lambda (ls)
    (letrec ([race
	      (lambda (hare tortoise)
		(cond
		 [(or (not (pair? hare))
		      (not (pair? (cdr hare)))) #f]
		 [(eq? hare tortoise) #t]
		 [else (race (cddr hare) (cdr tortoise))]))])
      (cond
       [(not (pair? ls)) #f]
       [else (race (cdr ls) ls)]))))


;; Exercise 3.21
(define print-queue
  (lambda (q) (car q)))


;; Exercise 3.22
(define (make-queue)
  (let ((front-ptr '())
        (rear-ptr '()))
    (define (set-front-ptr! item) (set! front-ptr item))
    (define (set-rear-ptr! item) (set! rear-ptr item))
    (define (empty-queue?) (null? front-ptr))
    (define (front-queue)
      (if (empty-queue?)
	  (error 'front-queue "FRONT called with an empty queue" front-ptr)
	  (car front-ptr)))
    (define (insert-queue! item)
      (let ((new-pair (cons item '())))
	(cond ((empty-queue?)
	       (set-front-ptr! new-pair)
	       (set-rear-ptr! new-pair)
	       dispatch)
	      (else
	       (set-cdr! rear-ptr new-pair)
	       (set-rear-ptr! new-pair)
	       dispatch))))
    (define (delete-queue!)
      (cond ((empty-queue?)
	     (error 'delete-queue "DELETE! called with an empty queue" front-ptr))
	    (else
	     (set-front-ptr! (cdr front-ptr))
	     dispatch)))
    (define (print-queue) front-ptr)
    (define (dispatch m)
      (case m
	[(front-ptr) front-ptr]
	[(rear-ptr) rear-ptr]
	[(set-front-ptr!) set-front-ptr!]
	[(set-rear-ptr!) set-rear-ptr!]
	[(empty-queue?) (empty-queue?)]
	[(front-queue) (front-queue)]
	[(insert-queue!) insert-queue!]
	[(delete-queue!) (delete-queue!)]
	[(print-queue) (print-queue)]))
    dispatch))


;; Exercise 3.24
(define (make-table same-key?)
  (let ((local-table (list '*table*))
	(key-predict
	 (lambda (k1) 
	   (lambda (k2) (same-key? k1 k2)))))
    (define (lookup key-1 key-2)
      (let ((subtable (assp (key-predict key-1) (cdr local-table))))
        (if subtable
            (let ((record (assp (key-predict key-2) (cdr subtable))))
              (if record
                  (cdr record)
                  #f))
            #f)))
    (define (insert! key-1 key-2 value)
      (let ((subtable (assp (key-predict key-1) (cdr local-table))))
        (if subtable
            (let ((record (assp (key-predict key-2) (cdr subtable))))
              (if record
                  (set-cdr! record value)
                  (set-cdr! subtable
                            (cons (cons key-2 value)
                                  (cdr subtable)))))
            (set-cdr! local-table
                      (cons (list key-1
                                  (cons key-2 value))
                            (cdr local-table)))))
      'ok)    
    (define (dispatch m)
      (cond ((eq? m 'lookup-proc) lookup)
            ((eq? m 'insert-proc!) insert!)
	    ((eq? m 'change-same-key)
	     (lambda (new-same-key?) (set! same-key? new-same-key?)))
	    ((eq? m 'print) local-table)
            (else (error 'table "Unknown operation" m))))
    dispatch))


;; Exercise 3.25
(define (make-table-flex)
  (let ((local-table (list '*table*)))
    (define (lookup keys)
      (letrec ([lookup-helper
		(lambda (keys table)
		  (let ([subtable (if (pair? (cdr table))
				      (assoc (car keys) (cdr table))
				      #f)])
		    (if subtable
			(if (null? (cdr keys))
			    (if (eq? (car keys) (car subtable))
				(cdr subtable)
				#f)
			    (lookup-helper (cdr keys) subtable))
				    #f)))])
	(if (not (list? keys))
	    (error 'lookup "Please put keys in a list" keys)
	    (lookup-helper keys local-table))))
    (define (insert! keys value)
      (letrec ([insert-helper
		(lambda (keys table)
		  (let ([subtable (if (pair? (cdr table))
				      (assoc (car keys) (cdr table))
				      #f)])
		    (if subtable
			(if (null? (cdr keys))
			    (set-cdr! subtable value)
			    (insert-helper (cdr keys) subtable))
			(begin (and (not (pair? (cdr table))) ;; if current table is a record,
				    (set-cdr! table '()))     ;; remove the value
			       (if (null? (cdr keys))
				   (set-cdr! table
					     (cons (cons (car keys) value)
						   (cdr table)))
				   (let ([new-table (cons (car keys) '())])
				     (set-cdr! table (cons new-table (cdr table)))
				     (insert-helper (cdr keys) new-table)))))))])
	(if (not (list? keys))
	    (error 'insert! "Please put keys in a list" keys)
	    (insert-helper keys local-table)))
      'ok)    
    (define (dispatch m)
      (cond ((eq? m 'lookup-proc) lookup)
            ((eq? m 'insert-proc!) insert!)
	    ((eq? m 'print) local-table)
            (else (error 'table "Unknown operation" m))))
    dispatch))


;; Exercise 3.26
;; TODO tree table


;; 3.3.4  A Simulator for Digital Circuits
(define (make-wire)
  (let ((signal-value 0)
	(action-procedures '()))
    (define (set-my-signal! new-value)
      (if (not (= signal-value new-value))
          (begin (set! signal-value new-value)
                 (call-each action-procedures))
          'done))
    (define (accept-action-procedure! proc)
      (set! action-procedures (cons proc action-procedures))
      (proc))
    (define (dispatch m)
      (cond ((eq? m 'get-signal) signal-value)
            ((eq? m 'set-signal!) set-my-signal!)
            ((eq? m 'add-action!) accept-action-procedure!)
            (else (error 'wire "Unknown operation" m))))
    dispatch))

(define (call-each procedures)
  (if (null? procedures)
      'done
      (begin
        ((car procedures))
        (call-each (cdr procedures)))))

(define (get-signal wire)
  (wire 'get-signal))
(define (set-signal! wire new-value)
  ((wire 'set-signal!) new-value))
(define (add-action! wire action-procedure)
  ((wire 'add-action!) action-procedure))

(define (make-agenda) 'notimplemented)
(define the-agenda (make-agenda))
(define inverter-delay 2)
(define and-gate-delay 3)
(define or-gate-delay 5)

(define (probe name wire)
  (add-action! wire
               (lambda ()        
                 (newline)
                 (display name)
                 (display " ")
                 (display (current-time the-agenda))
                 (display "  New-value = ")
                 (display (get-signal wire)))))

(define (after-delay delay action)
  (add-to-agenda! (+ delay (current-time the-agenda))
                  action
                  the-agenda))

(define (propagate)
  (if (empty-agenda? the-agenda)
      'done
      (let ((first-item (first-agenda-item the-agenda)))
        (first-item)
        (remove-first-agenda-item! the-agenda)
        (propagate))))

(define (logical-not s)
  (cond ((= s 0) 1)
        ((= s 1) 0)
        (else (error 'logical-not "Invalid signal" s))))

(define (logical-and s1 s2)
  (cond
   [(and (= s1 1) (= s2 1)) 1]
   [else 0]))

(define (logical-or s1 s2)
  (cond
   [(and (= s1 0) (= s2 0)) 0]
   [else 1]))

(define (inverter input output)
  (define (invert-input)
    (let ((new-value (logical-not (get-signal input))))
      (after-delay inverter-delay
                   (lambda ()
                     (set-signal! output new-value)))))
  (add-action! input invert-input)
  'ok)

(define (and-gate a1 a2 output)
  (define (and-action-procedure)
    (let ((new-value
           (logical-and (get-signal a1) (get-signal a2))))
      (after-delay and-gate-delay
                   (lambda ()
                     (set-signal! output new-value)))))
  (add-action! a1 and-action-procedure)
  (add-action! a2 and-action-procedure)
  'ok)

;; Exercise 3.28
(define (or-gate a1 a2 output)
  (define (or-action-procedure)
    (let ([new-value (logical-or (get-signal a1) (get-signal a2))])
      (after-delay or-gate-delay
		   (lambda () (set-signal! output new-value)))))
  (add-action! a1 or-action-procedure)
  (add-action! a2 or-action-procedure)
  'ok)

;; Exercise 3.29
(define (or-gate-compound a1 a2 output)
  (let ([and-output (make-wire)]
	[and-input1 (make-wire)]
	[and-input2 (make-wire)])
    (inverter a1 and-input1)
    (inverter a2 (and-input2))
    (and-gate and-input1 and-input2 and-output)
    (inverter and-output output)
    'ok))

(define (half-adder a b s c)
  (let ((d (make-wire)) (e (make-wire)))
    (or-gate a b d)
    (and-gate a b c)
    (inverter c e)
    (and-gate d e s)
    'ok))

(define (full-adder a b c-in sum c-out)
  (let ((s (make-wire))
        (c1 (make-wire))
        (c2 (make-wire)))
    (half-adder b c-in s c1)
    (half-adder a s sum c2)
    (or-gate c1 c2 c-out)
    'ok))

;; Exercise 3.30
(define (ripple-carry-adder As Bs Ss C)
  (letrec ([internal-c-outs
	    (let ([zero-c-in (make-wire)])
	      (set-signal! zero-c-in 0)
	      (list zero-c-in))]
	   [attach-fa
	    (lambda (a b s c-out)
	      (let ([c-in (car internal-c-outs)])
		(full-adder a b c-in s c-out)
		(set! internal-c-outs (cons c-cout internal-c-outs))))]
	   [helper
	    (lambda (as bs cs)
	      (if (null? (cdr as))
		  (attach-fa (car as) (car bs) (car cs) C)
		  (begin (attach-fa (car as) (car bs) (car cs) (make-wire))
			 (helper (cdr as) (cdr bs) (cdr cs)))))])
    (if (null? As)
	(error 'ripple-carry-adder "No wire" As)
	(helper As Bs Ss))))

;; 3.5 Streams
(define-syntax cons-stream
  (syntax-rules ()
    [(_ a b) (cons a (delay b))]))

(define stream-car car)

(define stream-cdr
  (lambda (s)
    (force (cdr s))))

(define (stream-ref s n)
  (if (= n 0)
      (stream-car s)
      (stream-ref (stream-cdr s) (- n 1))))

(define (stream-take s n)
  (if (zero? n)
      '()
      (cons (stream-car s)
            (stream-take (stream-cdr s) (sub1 n)))))

(define stream-null? null?)

(define the-empty-stream '())

;; Exercise 3.51
(define (stream-map proc . argstreams)
  (if (stream-null? (car argstreams))
      the-empty-stream
      (cons-stream
       (apply proc (map stream-car argstreams))
       (apply stream-map
              (cons proc (map stream-cdr argstreams))))))

(define (stream-filter pred stream)
  (cond ((stream-null? stream) the-empty-stream)
        ((pred (stream-car stream))
         (cons-stream (stream-car stream)
                      (stream-filter pred
                                     (stream-cdr stream))))
        (else (stream-filter pred (stream-cdr stream)))))

(define (scale-stream stream factor)
  (stream-map (lambda (x) (* x factor)) stream))

(define ones (cons-stream 1 ones))

(define fibs
  (cons-stream 0
               (cons-stream 1
                            (add-streams (stream-cdr fibs)
                                         fibs))))

(define (add-streams s1 s2)
  (stream-map + s1 s2))

(define integers (cons-stream 1 (add-streams ones integers)))

;; Exercise 3.54
(define (mul-streams s1 s2)
  (stream-map * s1 s2))

(define factorials (cons-stream 1 (mul-streams
                                   (add-streams ones integers)
                                   factorials)))

;; Exercise 3.55
(define (partial-sums s)
  (let f ([accu (stream-car s)]
          [s-part (stream-cdr s)])
    (cons-stream
     accu
     (f (+ accu (stream-car s-part))
        (stream-cdr s-part)))))

;; Exercise 3.56
(define (merge s1 s2)
  (cond ((stream-null? s1) s2)
        ((stream-null? s2) s1)
        (else
         (let ((s1car (stream-car s1))
               (s2car (stream-car s2)))
           (cond ((< s1car s2car)
                  (cons-stream s1car (merge (stream-cdr s1) s2)))
                 ((> s1car s2car)
                  (cons-stream s2car (merge s1 (stream-cdr s2))))
                 (else
                  (cons-stream s1car
                               (merge (stream-cdr s1)
                                      (stream-cdr s2)))))))))

(define S (cons-stream 1 (merge (scale-stream S 2)
                                (merge (scale-stream S 3)
                                       (scale-stream S 5)))))

;; Exercise 3.58
(define (expand num den radix)
  (cons-stream
   (quotient (* num radix) den)
   (expand (remainder (* num radix) den) den radix)))
;; The result is the rational value that num divide den in base radix.

;; Exercise 3.59
(define (integrate-series coefficients)
  (let f ([power 1]
          [s coefficients])
    (cons-stream
     (* (/ 1 power) (stream-car s))
     (f (add1 power) (stream-cdr s)))))

(define exp-series
  (cons-stream 1 (integrate-series exp-series)))

(define cosine-series
  (cons-stream 1 (scale-stream (integrate-series sine-series) -1)))

(define sine-series
  (cons-stream 0 (integrate-series cosine-series)))


;; Exercise 3.60
(define (mul-series s1 s2)
  (cons-stream (* (stream-car s1) (stream-car s2))
               (add-streams (scale-stream (stream-cdr s2) (stream-car s1))
                            (mul-series (stream-cdr s1) s2))))

;; Exercise 3.61
(define (invert-unit-series s)
  (letrec ([x (cons-stream 1
                           (mul-series (stream-cdr s)
                                       (scale-stream x -1)))])
    x))


;; Exercise 3.62
(define (div-series numer denom)
  (if (zero? (stream-car denom))
      (error 'div-series "devide by zero" denom)
      (mul-series numer (invert-unit-series denom))))


;; 3.5.3 Exploiting the Stream Paradigm
(define (sum ls)
  (if (null? ls)
      0
      (+ (car ls) (sum (cdr ls)))))

(define (average . ls)
  (if (> (length ls) 0)
      (/ (sum ls) (length ls))
      (error 'average "null args" ls)))

(define square
  (lambda (n)
    (* n n)))

(define (sqrt-improve guess x)
  (average guess (/ x guess)))

(define (sqrt-stream x)
  (define guesses
    (cons-stream
     1.0
     (stream-map (lambda (guess)
                   (sqrt-improve guess x))
                 guesses)))
  guesses)

;; π/4 = 1 - 1/3 + 1/5 - 1/7 ... 
(define (pi-summands n)
  (cons-stream (/ 1.0 n)
               (stream-map - (pi-summands (+ n 2)))))

(define pi-stream
  (scale-stream (partial-sums (pi-summands 1)) 4))

(define (euler-transform s)
  (let ((s0 (stream-ref s 0))           ; Sn-1
        (s1 (stream-ref s 1))           ; Sn
        (s2 (stream-ref s 2)))          ; Sn+1
    (cons-stream (- s2 (/ (square (- s2 s1))
                          (+ s0 (* -2 s1) s2)))
                 (euler-transform (stream-cdr s)))))

;; a stream of streams in which each stream is
;; the transform of the preceding one
(define (make-tableau transform s)
  (cons-stream s
               (make-tableau transform
                             (transform s))))

(define (accelerated-sequence transform s)
  (stream-map stream-car
              (make-tableau transform s)))


;; Exercise 3.64
(define (stream-limit x tolerance)
  (let f ([fst (stream-car x)]
          [snd (stream-car (stream-cdr x))]
          [s (stream-cdr (stream-cdr x))])
    (if (< (abs (- snd fst))
           tolerance)
        snd
        (f snd
           (stream-car s)
           (stream-cdr s)))))


;; Exercise 3.65
(define ln2-stream
  (letrec ([ln2-summands
            (lambda (n)
              (cons-stream (/ 1.0 n)
                           (stream-map - (ln2-summands (add1 n)))))])
    (partial-sums (ln2-summands 1))))


(define (interleave s1 s2)
  (if (stream-null? s1)
      s2
      (cons-stream (stream-car s1)
                   (interleave s2 (stream-cdr s1)))))

(define (pairs0 f s t)
  (cons-stream
   (f (stream-car s) (stream-car t))
   (interleave
    (stream-map (lambda (x) (f (stream-car s) x))
                (stream-cdr t))
    (pairs0 f (stream-cdr s) (stream-cdr t)))))

(define (pairs s t)
  (pairs0 list s t))

;; Exercise 3.69
(define (triples s t u)
  (cons-stream
   (list 
    (stream-car s)
    (stream-car t) 
    (stream-car u))
   (interleave
    (stream-map (lambda (x) (cons (stream-car s) x))
                (stream-cdr (pairs t u)))
    (triples (stream-cdr s)
             (stream-cdr t)
             (stream-cdr u)))))


(define pythagoreans
  (stream-filter
   (lambda (triple)
     (eq? (+ (square (car triple))
             (square (cadr triple)))
          (square (caddr triple))))
   (triples integers integers integers)))


(define (integral integrand initial-value dt)
  (define int
    (cons-stream initial-value
                 (add-streams (scale-stream integrand dt)
                              int)))
  int)


;; Exercise 3.73
(define RC
  (lambda (R C dt)
    (lambda (is v0)
      (add-stream
       (scale-stream is R)
       (integral (scale-stream is (/ 1 C))
                 v0
                 dt)))))


;; Exercise 3.74
(define sense-data integers)

(define sign-change-detector
  (lambda (x y)
    (cond
     [(and (>= x 0) (< y 0)) 1]
     [(and (< 0 x) (>= y 0)) -1]
     [else 0])))

(define (make-zero-crossings input-stream last-value)
  (cons-stream
   (sign-change-detector (stream-car input-stream) last-value)
   (make-zero-crossings (stream-cdr input-stream)
                        (stream-car input-stream))))

(define zero-crossings (make-zero-crossings sense-data 0))

(define zero-crossings-new
  (stream-map sign-change-detector sense-data (cons-stream 0 sense-data)))


;; Exercise 3.76
(define smooth
  (lambda (s)
    (stream-map
     (lambda (x y) (/ (+ x y) 2))
     s
     (stream-cdr s))))


;; 4.1  The Metacircular Evaluator
(define apply-in-underlying-scheme apply)

(define (apply0 procedure arguments)
  (cond ((primitive-procedure? procedure)
         (apply-primitive-procedure procedure arguments))
        ((compound-procedure? procedure)
         (eval-sequence
           (procedure-body procedure)
           (extend-environment
             (procedure-parameters procedure)
             arguments
             (procedure-environment procedure))))
        (else
         (error
          "Unknown procedure type -- APPLY" procedure))))

(define (eval exp env)
  (cond ((self-evaluating? exp) exp)
        ((variable? exp) (lookup-variable-value exp env))
        ((quoted? exp) (text-of-quotation exp))
        ((assignment? exp) (eval-assignment exp env))
        ((definition? exp) (eval-definition exp env))
        ((if? exp) (eval-if exp env))
        ((lambda? exp)
         (make-procedure (lambda-parameters exp)
                         (lambda-body exp)
                         env))
        ((begin? exp) 
         (eval-sequence (begin-actions exp) env))
        ((cond? exp) (eval (cond->if exp) env))
        ((let? exp) (eval (let->combination exp) env))
        ((application? exp)
         (apply0 (eval (operator exp) env)
                (list-of-values (operands exp) env)))
        (else
         (error "Unknown expression type -- EVAL" exp))))


(define (list-of-values exps env)
  (if (no-operands? exps)
      '()
      (cons (eval (first-operand exps) env)
            (list-of-values (rest-operands exps) env))))

(define (eval-if exp env)
  (if (true? (eval (if-predicate exp) env))
      (eval (if-consequent exp) env)
      (eval (if-alternative exp) env)))

(define (eval-sequence exps env)
  (cond ((last-exp? exps) (eval (first-exp exps) env))
        (else (eval (first-exp exps) env)
              (eval-sequence (rest-exps exps) env))))

(define (eval-assignment exp env)
  (set-variable-value! (assignment-variable exp)
                       (eval (assignment-value exp) env)
                       env)
  'ok)

(define (eval-definition exp env)
  (define-variable! (definition-variable exp)
                    (eval (definition-value exp) env)
                    env)
  'ok)

;; Exercise 4.1
(define (list-of-values-l2r exps env)
  (if (no-operands? exps)
      '()
      (let ([first (eval (first-operand exps))])
        (cons first
              (list-of-values-l2r (rest-operands exps) env)))))

(define (list-of-values-r2l exps env)
  (list-of-values-l2r (reverse-exps exps) env))


;; 4.1.2  Representing Expressions
(define (self-evaluating? exp)
  (cond
   [(number? exp) #t]
   [(string? exp) #t]
   [else #f]))

(define (variable? exp) (symbol? exp))

(define (quoted? exp)
  (tagged-list? exp 'quote))

(define (text-of-quotation exp) (cadr exp))

(define (tagged-list? exp tag)
  (if (pair? exp)
      (eq? (car exp) tag)
      #f))

(define (assignment? exp)
  (tagged-list? exp 'set!))
(define (assignment-variable exp) (cadr exp))
(define (assignment-value exp) (caddr exp))

(define (definition? exp)
  (tagged-list? exp 'define))
(define (definition-variable exp)
  (if (symbol? (cadr exp))
      (cadr exp)
      (caadr exp)))
(define (definition-value exp)
  (if (symbol? (cadr exp))
      (caddr exp)
      (make-lambda (cdadr exp)   ; formal parameters
                   (cddr exp)))) ; body

(define (lambda? exp) (tagged-list? exp 'lambda))
(define (lambda-parameters exp) (cadr exp))
(define (lambda-body exp) (cddr exp))
(define (make-lambda parameters body)
  (cons 'lambda (cons parameters body)))

(define (if? exp) (tagged-list? exp 'if))
(define (if-predicate exp) (cadr exp))
(define (if-consequent exp) (caddr exp))
(define (if-alternative exp)
  (if (not (null? (cdddr exp)))
      (cadddr exp)
      'false))

(define (make-if predicate consequent alternative)
  (list 'if predicate consequent alternative))

(define (begin? exp) (tagged-list? exp 'begin))
(define (begin-actions exp) (cdr exp))
(define (last-exp? seq) (null? (cdr seq)))
(define (first-exp seq) (car seq))
(define (rest-exps seq) (cdr seq))

(define (sequence->exp seq)
  (cond ((null? seq) seq)
        ((last-exp? seq) (first-exp seq))
        (else (make-begin seq))))
(define (make-begin seq) (cons 'begin seq))

(define (application? exp) (pair? exp))
(define (operator exp) (car exp))
(define (operands exp) (cdr exp))
(define (no-operands? ops) (null? ops))
(define (first-operand ops) (car ops))
(define (rest-operands ops) (cdr ops))

(define (cond? exp) (tagged-list? exp 'cond))
(define (cond-clauses exp) (cdr exp))
(define (cond-else-clause? clause)
  (eq? (cond-predicate clause) 'else))
(define (cond-predicate clause) (car clause))
(define (cond-actions clause) (cdr clause))
(define (cond->if exp)
  (expand-clauses (cond-clauses exp)))

(define (expand-clauses clauses)
  (if (null? clauses)
      'false                          ; no else clause
      (let ((first (car clauses))
            (rest (cdr clauses)))
        (if (cond-else-clause? first)
            (if (null? rest)
                (sequence->exp (cond-actions first))
                (error "ELSE clause isn't last -- COND->IF"
                       clauses))
            (if (cond-arrow-clause? first)
                (make-if (cond-predicate first)
                         (list (cond-lambda first) (cond-predicate first))
                         (expand-clauses rest))
                (make-if (cond-predicate first)
                         (sequence->exp (cond-actions first))
                         (expand-clauses rest)))))))


;; Exercise 4.2
(define (application-louis? exp) (tagged-list? exp 'call))

;; Exercise 4.5
(define (cond-arrow-clause? clause)
  (eq? '=> (cadr clause)))

(define cond-lambda caddr)


;; Exercise 4.6, 4.8
(define unzip
  (lambda (pairs)
    (if (null? pairs)
        '(() ())
        (let ([pair (car pairs)]
              [ans (unzip (cdr pairs))])
          (list (cons (car pair) (car ans))
                (cons (cadr pair) (cadr ans)))))))

(define (let? exp) (tagged-list? exp 'let))

(define (named-let? exp)
  (let ([second (cadr exp)])
    (and (not (pair? second))
         (not (null? second)))))

(define let->combination
  (lambda (exp)
    (if (named-let? exp)
        (let ([name (cadr exp)]
              [two-lists (unzip (caddr exp))])
          ; might cause syntax violation when "define" isn't allowed, should use letrec
          (sequence->exp
           (list (list 'define (cons name (car two-lists)) (cadddr exp))
                 (cons name (cadr two-lists)))))
        (let ([two-lists (unzip (cadr exp))])
          (list (make-lambda (car two-lists) (caddr exp))
                (cadr two-lists))))))

;; Exercise 4.7
(define make-let
  (lambda (bindings body)
    (list 'let bindings body)))

(define let*?
  (lambda (exp) (tagged-list? exp 'let*)))

(define let*->nested-lets
  (lambda (exp)
    (let ([bindings (cadr exp)]
          [body (caddr exp)])
      (if (null? bindings)
          (make-let bindings body)
          (make-let (list (car bindings))
                    (let*->nested-lets (list 'let* (cdr bindings) body)))))))

;; Exercise 4.8


;; Evaluator Data Structures
(define (true? x)
  (not (eq? x 'false)))
(define (false? x)
  (eq? x 'false))

(define (make-procedure parameters body env)
  (list 'procedure parameters body env))
(define (compound-procedure? p)
  (tagged-list? p 'procedure))
(define (procedure-parameters p) (cadr p))
(define (procedure-body p) (caddr p))
(define (procedure-environment p) (cadddr p))

(define (enclosing-environment env) (cdr env))
(define (first-frame env) (car env))
(define the-empty-environment '())

(define (make-frame variables values)
  (cons variables values))
(define (frame-variables frame) (car frame))
(define (frame-values frame) (cdr frame))
(define (add-binding-to-frame! var val frame)
  (set-car! frame (cons var (car frame)))
  (set-cdr! frame (cons val (cdr frame))))

(define (extend-environment vars vals base-env)
  (if (= (length vars) (length vals))
      (cons (make-frame vars vals) base-env)
      (if (< (length vars) (length vals))
          (error 'extend "Too many arguments supplied" vars vals)
          (error 'extend "Too few arguments supplied" vars vals))))

(define (lookup-variable-value var env)
  (define (env-loop env)
    (define (scan vars vals)
      (cond ((null? vars)
             (env-loop (enclosing-environment env)))
            ((eq? var (car vars))
             (car vals))
            (else (scan (cdr vars) (cdr vals)))))
    (if (eq? env the-empty-environment)
        (error 'lookup "Unbound variable" var)
        (let ((frame (first-frame env)))
          (scan (frame-variables frame)
                (frame-values frame)))))
  (env-loop env))

(define (set-variable-value! var val env)
  (define (env-loop env)
    (define (scan vars vals)
      (cond ((null? vars)
             (env-loop (enclosing-environment env)))
            ((eq? var (car vars))
             (set-car! vals val))
            (else (scan (cdr vars) (cdr vals)))))
    (if (eq? env the-empty-environment)
        (error 'set-var "Unbound variable -- SET!" var)
        (let ((frame (first-frame env)))
          (scan (frame-variables frame)
                (frame-values frame)))))
  (env-loop env))

(define (define-variable! var val env)
  (let ((frame (first-frame env)))
    (define (scan vars vals)
      (cond ((null? vars)
             (add-binding-to-frame! var val frame))
            ((eq? var (car vars))
             (set-car! vals val))
            (else (scan (cdr vars) (cdr vals)))))
    (scan (frame-variables frame)
          (frame-values frame))))

;; Exercise 4.11
(define zip
  (lambda (l1 l2)
    (if (null? l1)
        '()
        (cons (cons (car pl1) (car l2))
              (zip (cdr l1) (cdr l2))))))

(define (make-frame-my variables values)
  (zip variables values))
(define (frame-variables-my frame) (map car frame))
(define (frame-values-my frame) (map cdr frame))
(define (add-binding-to-frame!-my var val frame)
  (cons (cons var val) frame))

(define (extend-environment-my vars vals base-env)
  (if (= (length vars) (length vals))
      (cons (make-frame-my vars vals) base-env)
      (if (< (length vars) (length vals))
          (error 'extend "Too many arguments supplied" vars vals)
          (error 'extend "Too few arguments supplied" vars vals))))

(define (lookup-variable-value-my var env)
  (define (env-loop env)
    (define (scan bindings)
      (cond ((null? bindings)
             (env-loop (enclosing-environment env)))
            ((eq? var (car (car bindings)))
             (cdr (car bingins)))
            (else (scan (cdr bindgins)))))
    (if (eq? env the-empty-environment)
        (error 'lookup "Unbound variable" var)
        (scan (first-frame env))))
  (env-loop env))

(define (set-variable-value!-my var val env)
  (define (env-loop env)
    (define (scan bindings)
      (cond ((null? bindings)
             (env-loop (enclosing-environment env)))
            ((eq? var (car (car bindings)))
             (set-cdr! (car bindings) val))
            (else (scan (cdr bindings)))))
    (if (eq? env the-empty-environment)
        (error 'set-variable-value "Unbound variable -- SET!" var)
        (scan (first-frame env))))
  (env-loop env))

(define (define-variable!-my var val env)
  (let ((frame (first-frame env)))
    (define (scan bindings)
      (cond ((null? bindings)
             (add-binding-to-frame!-my var val frame))
            ((eq? var (car (car bindings)))
             (set-cdr! (car bindings) val))
            (else (scan (cdr bindings)))))
    (scan frame)))

;; Exercise 4.13
(define make-unbound!
  (lambda (var env)
    (let ([frame (first-frame env)])
      (let ([new-frame
             (lambda (vars vals)
               (cond
                [(null? vars) (error 'make-unbound! "Unbound variable" var)]
                [(eq? var (car vars)) (cons (cdr vars) (cdr vals))]
                [else (let ([ans (new-frame (cdr vars) (cdr vals))])
                        (cons (cons (car vars) (car ans))
                              (cons (car vals) (cdr ans))))]))])
        (set-car! env (new-frame (frame-variables frame)
                                 (frame-values frame)))))))

;; 4.1.4 Running the Evaluator as a Program
(define (primitive-procedure? proc)
  (tagged-list? proc 'primitive))

(define (primitive-implementation proc) (cadr proc))

(define primitive-procedures
  (list (list '+ +)
        (list '- -)
        (list '* *)
        (list '/ /)
        (list 'car car)
        (list 'cdr cdr)
        (list 'cons cons)
        (list 'list list)
        (list 'map map)
        (list 'null? null?)))

(define (primitive-procedure-names)
  (map car
       primitive-procedures))

(define (primitive-procedure-objects)
  (map (lambda (proc) (list 'primitive (cadr proc)))
       primitive-procedures))

(define (setup-environment)
  (let ((initial-env
         (extend-environment (primitive-procedure-names)
                             (primitive-procedure-objects)
                             the-empty-environment)))
    (define-variable! 'true #t initial-env)
    (define-variable! 'false #f initial-env)
    initial-env))
(define the-global-environment (setup-environment))

(define (apply-primitive-procedure proc args)
  (apply-in-underlying-scheme
   (primitive-implementation proc) args))

(define input-prompt ";;; M-Eval input:")
(define output-prompt ";;; M-Eval value:")
(define (driver-loop)
  (prompt-for-input input-prompt)
  (let ((input (read)))
    (let ((output (eval input the-global-environment)))
      (announce-output output-prompt)
      (user-print output)))
  (driver-loop))
(define (prompt-for-input string)
  (newline) (newline) (display string) (newline))

(define (announce-output string)
  (newline) (display string) (newline))

(define (user-print object)
  (if (compound-procedure? object)
      (display (list 'compound-procedure
                     (procedure-parameters object)
                     (procedure-body object)
                     '<procedure-env>))
      (display object)))

