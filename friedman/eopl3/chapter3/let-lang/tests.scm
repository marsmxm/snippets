(module tests mzscheme
  
  (provide test-list)

  ;;;;;;;;;;;;;;;; tests ;;;;;;;;;;;;;;;;
  
  (define test-list
    '(
  
      ;; simple arithmetic
      (positive-const "11" 11)
      (negative-const "-33" -33)
      ;; Ex 3.6
      (test-minus1-1 "minus(5)" -5)
      (test-minus1-2 "minus(-(minus(5),9))" 14)
      (simple-arith-1 "-(44,33)" 11)
      ;; Ex 3.7
      (simple-arith-2 "+(44,33)" 77)
      (simple-arith-3 "*(44,33)" 1452)
      (simple-arith-4 "/(44,33)" 1)
  
      ;; nested arithmetic
      (nested-arith-left "-(-(44,33),22)" -11)
      (nested-arith-right "-(55, -(22,11))" 44)
  
      ;; simple variables
      (test-var-1 "x" 10)
      (test-var-2 "-(x,1)" 9)
      (test-var-3 "-(1,x)" -9)
      
      ;; simple unbound variables
      (test-unbound-var-1 "foo" error)
      (test-unbound-var-2 "-(x,foo)" error)
  
      ;; simple conditionals
      (if-true "if zero?(0) then 3 else 4" 3)
      (if-false "if zero?(1) then 3 else 4" 4)
      ;; Ex 3.8
      (if-equal-1 "if equal?(3, 3) then 3 else 4" 3)
      (if-equal-2 "if equal?(3, 4) then 3 else 4" 4)
      (if-greater "if greater?(3, 2) then 3 else 4" 3)
      (if-lesser "if lesser?(3, 2) then 3 else 4" 4)
      
      ;; test dynamic typechecking
      (no-bool-to-diff-1 "-(zero?(0),1)" error)
      (no-bool-to-diff-2 "-(1,zero?(0))" error)
      (no-int-to-if "if 1 then 2 else 3" error)

      ;; make sure that the test and both arms get evaluated
      ;; properly. 
      (if-eval-test-true "if zero?(-(11,11)) then 3 else 4" 3)
      (if-eval-test-false "if zero?(-(11, 12)) then 3 else 4" 4)
      
      ;; and make sure the other arm doesn't get evaluated.
      (if-eval-test-true-2 "if zero?(-(11, 11)) then 3 else foo" 3)
      (if-eval-test-false-2 "if zero?(-(11,12)) then foo else 4" 4)

      ;; simple let
      (simple-let-1 "let x = 3 in x" 3)

      ;; make sure the body and rhs get evaluated
      (eval-let-body "let x = 3 in -(x,1)" 2)
      (eval-let-rhs "let x = -(4,1) in -(x,1)" 2)

      ;; check nested let and shadowing
      (simple-nested-let "let x = 3 in let y = 4 in -(x,y)" -1)
      (check-shadowing-in-body "let x = 3 in let x = 4 in x" 4)
      (check-shadowing-in-rhs "let x = 3 in let x = -(x,1) in x" 2)

      ;; Ex 3.9
      (list-car "car(cons(1,emptylist))" 1)
      (list-car-empty "car(emptylist)" error)
      (list-cdr "cdr(cons(1,cons(2, emptylist)))" (2))
      (list-cdr-empty "cdr(emptylist)" error)
      (list-1 "let x = 4 in cons(x,cons(cons(-(x,1),emptylist),emptylist))" (4 (3)))
      ))
  )
