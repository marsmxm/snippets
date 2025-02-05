(module tests mzscheme
  
  (provide test-list)
  ;;;;;;;;;;;;;;;; tests ;;;;;;;;;;;;;;;;
  
  (define test-list
    '(
  
      ;; simple arithmetic
      (positive-const "11" 11)
      (negative-const "-33" -33)
      (simple-arith-1 "-(44,33)" 11)
  
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

      ;; simple applications
      (apply-proc-in-rator-pos "(proc(x) -(x,1)  30)" 29)
      (apply-simple-proc "let f = proc (x) -(x,1) in (f 30)" 29)
      (let-to-proc-1 "(proc(f)(f 30)  proc(x)-(x,1))" 29)


      (nested-procs "((proc (x) proc (y) -(x,y)  5) 6)" -1)
      (nested-procs2 "let f = proc(x) proc (y) -(x,y) in ((f -(10,5)) 6)"
        -1)
      
       (y-combinator-1 "
let fix =  proc (f)
            let d = proc (x) proc (z) ((f (x x)) z)
            in proc (n) ((f (d d)) n)
in let
    t4m = proc (f) proc(x) if zero?(x) then 0 else -((f -(x,1)),-4)
in let times4 = (fix t4m)
   in (times4 3)" 12)
      
       ;; simple letrecs
      (simple-letrec-1 "letrec f(x) = -(x,1) in (f 33)" 32)
      (simple-letrec-2
        "letrec f(x) = if zero?(x)  then 0 else -((f -(x,1)), -2) in (f 4)"
        8)

      (simple-letrec-3
        "let m = -5 
 in letrec f(x) = if zero?(x) then 0 else -((f -(x,1)), m) in (f 4)"
        20)
      
;      (fact-of-6  "letrec
;  fact(x) = if zero?(x) then 1 else *(x, (fact sub1(x)))
;in (fact 6)" 
;                  720)
      
      (HO-nested-letrecs
"letrec even(odd)  = proc(x) if zero?(x) then 1 else (odd -(x,1))
   in letrec  odd(x)  = if zero?(x) then 0 else ((even odd) -(x,1))
   in (odd 13)" 1)

      ;; for exercises
      (simple-let2-1 "let z=3,y=4 in -(y, z)" 1)
      (simple-let3-1 "let w=1,y=2,z=3 in -(z,-(y,w))" 2)
      (simple-let*-1 "let z=1,y=-(3,z) in -(y,z)" 1)

      (emplylist-1 "emptylist" ())
      (conslist-1 "cons(1, cons(2, emptylist))" (1 2))
      (conslist-2 "cons(cons(1, cons(2, emptylist)), 
                        cons(3, emptylist))"
		  ((1 2) 3))

      (car-1 "car(cons(1, emptylist))" 1)
      (car-2 "car(emptylist)" error)

      (cdr-1 "cdr(cons(1, emptylist))" ())
      (cdr-2 "cdr(emptylist)" error)

      (null-1 "null?(emptylist)" #t)
      (null-2 "null?(cons(1,emptylist))" #f)

      (list-1 "list()" ())
      (list-2 "list(1,2,3)" (1 2 3))

      (list-length "
letrec len(es)=
  if null?(es) then 0 else -((len cdr(es)), -1) in
let l1=list(1,2,3) in (len l1)
"
                   3)

      (multi-args-proc-1
       "let f=proc(x,y,z) -(-(x,y),z) in -((f 4 2 1), -1)"
       2)

      (set-begin-1 "let x=3 in begin set x=2; x end" 2)

      (fact "
letrec fact(n)=
  if zero?(n) 
  then 1 
  else *( n, (fact -(n,1)) ) in (fact 4)" 24)

      (fact-iter "
letrec fact-iter(n,a) =
  if zero?(n)
  then a
  else (fact-iter -(n,1) *(n,a)) in (fact-iter 4 1)" 24)
      

      
      ))
  )
