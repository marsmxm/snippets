(load "little-prover.scm")

(J-Bob/prove (defun.atoms)
  '(((dethm set?/add-atoms (a bs)
       (if (set? bs)
	   (equal (set? (add-atoms a bs)) 't)
	   't))
     (add-atoms a bs)
     )))

(J-Bob/prove (defun.atoms)
  '(((defun my-list-induction (x)
       (if (atom x)
           '()
           (my-list-induction (cdr x))))
     (size x)
     ((Q) (natp/size x))
     (() (if-true
          (if (atom x)
              't
              (< (size (cdr x)) (size x)))
          'nil))
     ((E) (size/cdr x))
     (() (if-same (atom x) 't)))
    
    ((dethm set?/t (xs)
       (if (set? xs) (equal (set? xs) 't) 't))
     (list-induction xs))
    ))

    
