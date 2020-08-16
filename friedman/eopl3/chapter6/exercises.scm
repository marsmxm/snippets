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


;; ex 6.7
(define value-of-program
  (lambda (pgm)
    (cases program pgm
           (a-program (exp1)
                      (value-of/k exp1 (init-env) (lambda (v) v))))))
(define value-of/k
  (lambda (exp env cont)
    (cases expression exp
           (const-exp (num) (cont (num-val num)))
           (var-exp (var) (cont (apply-env env var)))
           (proc-exp (var body)
                     (cont (proc-val (procedure var body env))))
           (letrec-exp (p-name b-var p-body letrec-body)
                       (value-of/k letrec-body
                                   (extend-env-rec p-name b-var p-body env)
                                   cont))
           (zero?-exp (exp1)
                      (value-of/k exp1 env
                                  (lambda (v)
                                    (cont (bool-val (zero? (expval->num v)))))))
           (if-exp (exp1 exp2 exp3)
                   (value-of/k exp1 env
                               (lambda (v)
                                 (if (expval->bool v)
                                     (value-of/k exp2 env cont)
                                     (value-of/k exp3 env cont)))))
           (let-exp (var exp1 body)
                    (value-of/k exp1 env
                                (lambda (v)
                                  (value-of/k body (extend-env var v env) cont))))
           (diff-exp (exp1 exp2)
                     (value-of/k exp1 env
                                 (lambda (v1)
                                   (value-of/k
                                    exp2 env
                                    (lambda (v2)
                                      (let ([num1 (expval->num v1)]
                                            [num2 (expval->num v2)])
                                        (cont
                                         (num-val
                                          (- num1 num2)))))))))
           (cal-exp (rator rand)
                    (value-of/k rator env
                                (lambda (v1)
                                  (value-of/k
                                   rand env
                                   (lambda (v2)
                                     (let ([proc1 (expval->proc v1)])
                                       (apply-procedure/k proc1 v2 cont)))))))))
  (define apply-procedure/k
    (lambda (proc1 val cont)
      (cases proc proc1
             (procedure (var body saved-env)
                        (value-of/k body
                                    (extend-env vvar val saved-env)
                                    cont)))))
  )
