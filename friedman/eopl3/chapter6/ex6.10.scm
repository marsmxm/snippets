(define list-sum
  (lambda (loi)
    (if (null? loi)
	0
	(+ (car loi)
           (list-sum (cdr loi))))))

(define list-sum/k0
  (lambda (loi cont)
    (if (null? loi)
	(cont 0)
	(list-sum/k0 (cdr loi)
		    (lambda (val)
		      (cont (+ (car loi) val)))))))

(define end-cont
  (lambda ()
    (lambda (val)
      (+ 0 val))))

(define list-sum1-cont
  (lambda (i cont)
    (lambda (val)
      (cont (+ i val)))))

(define apply-cont
  (lambda (cont val)
    (cont val)))


(define end-cont
  (lambda ()
    0))

(define list-sum1-cont
  (lambda (i cont)
    (+ cont i)))

(define apply-cont
  (lambda (cont val)
    (+ cont val)))

(define list-sum/k1
  (lambda (loi cont)
    (if (null? loi)
	(+ cont 0)
	(list-sum/k1 (cdr loi)
		     (+ cont (car loi))))))
