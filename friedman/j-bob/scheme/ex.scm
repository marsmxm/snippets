(load "little-prover.scm")

(J-Bob/prove (defun.atoms)
  '(((dethm set?/add-atoms (a bs)
       (if (set? bs)
	   (equal (set? (add-atoms a bs)) 't)
	   't))
     (add-atoms a bs)
     )))


