#lang racket

;;;;;;;;;;;; Continuation ;;;;;;;;;;;;;;;;
(define atom?
  (lambda (x) (and (not (pair? x)) (not (null? x)))))

(define evens*-co
  (lambda (xs col)
    (cond [(null? xs) (col '() 1 0)]
          [(atom? (car xs))
           (if (even? (car xs))
               (evens*-co
                (cdr xs)
                (lambda (xss p s)
                  (col
                   (cons (car xs) xss)
                   (* (car xs) p)
                   s)))
               (evens*-co
                (cdr xs)
                (lambda (xss p s)
                  (col xss p (+ (car xs) s)))))]
          [else (evens*-co
                 (car xs)
                 (lambda (al ap as)
                   (evens*-co
                    (cdr xs)
                    (lambda (dl dp ds)
                      (col
                       (cons al dl)
                       (* ap dp)
                       (+ as ds))))))])))

;;;;;;;;;;;; Y-combinator ;;;;;;;;;;;;;;;;

;; 有define的时候递归是这样的
(define length
  (lambda (xs)
    (if (null? xs)
        0
        (add1 (length (cdr xs))))))

;; 在lambda calculus里没有define， 所以我们有了poor man's Y
((lambda (length)
   (lambda (xs)
     (if (null? xs)
         0
         (add1 ((length length) (cdr xs))))))
 (lambda (length)
   (lambda (xs)
     (if (null? xs)
         0
         (add1 ((length length) (cdr xs)))))))

;; abstract outer self-application
((lambda (u) (u u))
 (lambda (length)
   (lambda (xs)
     (if (null? xs)
         0
         (add1 ((length length) (cdr xs)))))))

;; abstract inner self-application
;; 注释掉是因为这个调用会造成无限递归
;((lambda (u) (u u))
; (lambda (length)
;   ((lambda (g)
;      (lambda (xs)
;        (if (null? xs)
;            0
;            (add1 (g (cdr xs))))))
;    (length length))))

;; 解决call-by-value调用造成的无限递归
((lambda (u) (u u))
 (lambda (length)
   ((lambda (g)
      (lambda (xs)
        (if (null? xs)
            0
            (add1 (g (cdr xs))))))
    (lambda (v) ((length length) v)))))

;; 把中间的length函数体抽象为函数参数f
((lambda (f)
   ((lambda (u) (u u))
    (lambda (length)
      (f
       (lambda (v) ((length length) v))))))
 (lambda (g)
   (lambda (xs)
     (if (null? xs)
         0
         (add1 (g (cdr xs)))))))

;; 上面的前半部分被调方就是 Y combinator
(lambda (f)
  ((lambda (u) (u u))
   (lambda (x)
     (f (lambda (v) ((x x) v))))))

;; Test
(((lambda (f)
    ((lambda (u) (u u))
     (lambda (x)
       (f (lambda (v) ((x x) v))))))
  (lambda (length)
    (lambda (xs)
      (if (null? xs)
          0
          (add1 (length (cdr xs)))))))
 '(1 2 3 4 5))
;; => 5

(((lambda (f)
    ((lambda (u) (u u))
     (lambda (x)
       (f (lambda (v) ((x x) v))))))
  (lambda (factorial)
    (lambda (n)
      (if (zero? n)
          1
          (* n (factorial (sub1 n)))))))
 5)
;; => 120