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


(J-Bob/step (defun.remb)
  '(equal (memb?
	   (remb '()))
	  'nil)
  '(((1 1) (remb '()))
    ((1 1 Q) (atom '()))
    ((1 1) (if-true '() (if (equal (car '()) '?)
			    (remb (cdr '()))
			    (cons (car '()) (remb (cdr '()))))))
    ((1) (memb? '()))
    ((1 Q) (atom '()))
    ((1) (if-true 'nil
		  (if (equal (car '()) '?)
		      't
		      (memb? (cdr '())))))
    (() (equal-same 'nil))
    ))

(J-Bob/prove (dethm.memb?/remb2)
  '(((dethm memb?/remb (xs)
       (equal (memb? (remb xs)) 'nil))
     (list-induction xs)
     ;; base
     ((A 1 1) (remb xs))
     ((A 1 1) (if-nest-A
	       (atom xs)
	       '()
	       (if (equal (car xs) '?)
		   (remb (cdr xs))
		   (cons (car xs) (remb (cdr xs))))))
     ((A 1) (memb? '()))
     ((A 1 Q) (atom '()))
     ((A 1) (if-true
	     'nil
	     (if (equal (car '()) '?)
		 't
		 (memb? (cdr '())))))
     ((A) (equal-same 'nil))
     ;; induction
     ((E A 1 1) (remb xs))
     ((E A 1 1) (if-nest-E
		 (atom xs)
		 '()
		 (if (equal (car xs) '?)
		     (remb (cdr xs))
		     (cons (car xs) (remb (cdr xs))))))
     ((E A 1) (if-same
	       (equal (car xs) '?)
	       (memb?
		(if (equal (car xs) '?)
		    (remb (cdr xs))
		    (cons (car xs) (remb (cdr xs)))))))
     ((E A 1 A 1) (if-nest-A
		   (equal (car xs) '?)
		   (remb (cdr xs))
		   (cons (car xs) (remb (cdr xs)))))
     ((E A 1 E 1) (if-nest-E
		   (equal (car xs) '?)
		   (remb (cdr xs))
		   (cons (car xs) (remb (cdr xs)))))
     ((E A 1 A) (equal-if
		 (memb? (remb (cdr xs)))
		 'nil))
     ((E A 1 E) (memb? (cons (car xs) (remb (cdr xs)))))
     ((E A 1 E Q) (atom/cons (car xs) (remb (cdr xs))))
     ((E A 1 E) (if-false
		 'nil
		 (if (equal (car (cons (car xs) (remb (cdr xs)))) '?)
		     't
		     (memb? (cdr (cons (car xs) (remb (cdr xs))))))))
     ((E A 1 E Q 1) (car/cons (car xs) (remb (cdr xs))))
     ((E A 1 E E 1) (cdr/cons (car xs) (remb (cdr xs))))
     ((E A 1 E) (if-nest-E
		 (equal (car xs) '?)
		 't
		 (memb? (remb (cdr xs)))))
     ((E A 1 E) (equal-if
		 (memb? (remb (cdr xs)))
		 'nil))
     ((E A 1) (if-same (equal (car xs) '?) 'nil))
     ((E A) (equal-same 'nil))
     ((E) (if-same
	   (equal (memb? (remb (cdr xs))) 'nil)
	   't))
     (() (if-same
	  (atom xs)
	  't)))

    ))


(J-Bob/prove (dethm.memb?/remb)
  '(((defun ctx? (x)
       (if (atom x)
           (equal x '?)
           (if (ctx? (car x))
               't
               (ctx? (cdr x)))))
     (size x)
     ((Q) (natp/size x))
     (() (if-true
          (if (atom x)
              't
              (if (< (size (car x)) (size x))
                  (if (ctx? (car x))
                      't
                      (< (size (cdr x)) (size x)))
                  'nil))
          'nil))
     ((E Q) (size/car x))
     ((E A E) (size/cdr x))
     ((E A) (if-same
             (ctx? (car x))
             't))
     ((E) (if-true 't 'nil))
     (() (if-same (atom x) 't)))

    ((dethm ctx?/sub (x y)
       (if (ctx? x)
           (if (ctx? y)
               (equal (ctx? (sub x y)) 't)
               't)
           't))
     (star-induction y)
     (() (if-same
	  (ctx? x)
	  (if (atom y)
	      (if (ctx? x)
		  (if (ctx? y) (equal (ctx? (sub x y)) 't) 't)
		  't)
	      (if (if (ctx? x)
		      (if (ctx? (car y)) (equal (ctx? (sub x (car y))) 't) 't)
		      't)
		  (if (if (ctx? x)
			  (if (ctx? (cdr y)) (equal (ctx? (sub x (cdr y))) 't) 't)
			  't)
		      (if (ctx? x)
			  (if (ctx? y) (equal (ctx? (sub x y)) 't) 't)
			  't)
		      't)
		  't))))
     ((A A) (if-nest-A
	     (ctx? x)
	     (if (ctx? y) (equal (ctx? (sub x y)) 't) 't)
	     't))
     ((A E Q) (if-nest-A
	       (ctx? x)
	       (if (ctx? (car y)) (equal (ctx? (sub x (car y))) 't) 't)
	       't))
     ((A E A Q) (if-nest-A
		 (ctx? x)
		 (if (ctx? (cdr y)) (equal (ctx? (sub x (cdr y))) 't) 't)
		 't))
     ((A E A A) (if-nest-A
		 (ctx? x)
		 (if (ctx? y) (equal (ctx? (sub x y)) 't) 't)
		 't))
     ((E A) (if-nest-E
	     (ctx? x)
	     (if (ctx? y) (equal (ctx? (sub x y)) 't) 't)
	     't))
     ((E E Q) (if-nest-E
	       (ctx? x)
	       (if (ctx? (car y)) (equal (ctx? (sub x (car y))) 't) 't)
	       't))
     ((E E A Q) (if-nest-E
		 (ctx? x)
		 (if (ctx? (cdr y)) (equal (ctx? (sub x (cdr y))) 't) 't)
		 't))
     ((E E A A) (if-nest-E
		 (ctx? x)
		 (if (ctx? y) (equal (ctx? (sub x y)) 't) 't)
		 't))
     ((E E A) (if-true 't 't))
     ((E E) (if-true 't 't))
     ((E) (if-same (atom y) 't))
     
     )
    ))
