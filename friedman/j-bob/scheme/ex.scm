;; Load the transcript of all proofs in the book:
(load "little-prover.scm")

(J-Bob/step (prelude)
  '(equal 't 't)
  '((() (equal-same 't))))

(J-Bob/step (prelude)
  '(if a c c)
  '((() (if-same a c))
    (() (if-same
	 (if (equal a 't)
	     (if (equal 'nil 'nil)
		 a
		 b)
	     (equal 'or
		    (cons 'black '(coffee))))
	 c))
    ((Q E 2) (cons 'black '(coffee)))
    ((Q A Q) (equal-same 'nil))
    ))

(defun prelude+first-of-pair ()
  (J-Bob/define (prelude)
    '(((defun pair (x y)
	 (cons x (cons y '())))
       nil)
      
      ((defun first-of (x)
	 (car x))
       nil)

      ((defun second-of (x)
	 (car (cdr x)))
       nil)

      ((dethm first-of-pair (a b)
	 (equal (first-of (pair a b)) a))
       nil
       ((1 1) (pair a b))
       ((1) (first-of (cons a (cons b '()))) a)
       ((1) (car/cons a (cons b '())))
       (() (equal-same a)))
      
      )))



(J-Bob/prove (prelude)
  '(((defun list? (x)
	(if (atom x)
	    (equal x '())
	    (list? (cdr x))))
     (size x)
     ((Q) (natp/size x))
     (() (if-true
	  (if (atom x)
	      't
	      (< (size (cdr x)) (size x)))
	  'nil))
     ((E) (size/cdr x))
     (() (if-same (atom x) 't)))))


(J-Bob/prove (prelude)
  '(((dethm size-decrease (x)
       (equal 't
	      (if (natp (size x))
		  (if (atom x)
		      't
		      (< (size (cdr x)) (size x)))
		  'nil)))
     nil
     ((2 Q) (natp/size x))
     ((2) (if-true
	  (if (atom x)
	      't
	      (< (size (cdr x)) (size x)))
	  'nil))
     ((2 E) (size/cdr x))
     ((2) (if-same (atom x) 't))
     (() (equal-same 't)))
    
    ((defun memb? (xs)
       (if (atom xs)
	   'nil
	   (if (equal (car xs) '?)
	       't
	       (memb? (cdr xs)))))
     (size xs)
     ((Q) (natp/size xs))
     (() (if-true
	  (if (atom xs)
	      't
	      (if (equal (car xs) '?)
		  't
		  (< (size (cdr xs)) (size xs))))
	  'nil))
     ((E E) (size/cdr xs))
     ((E) (if-same (equal (car xs) '?) 't))
     (() (if-same (atom xs) 't)))

    ((defun remb (xs)
       (if (atom xs)
	   '()
	   (if (equal (car xs) '?)
	       (remb (cdr xs))
	       (cons (car xs) (remb (cdr xs))))))
     (size xs)
     (() (size-decrease xs)))

    ))
