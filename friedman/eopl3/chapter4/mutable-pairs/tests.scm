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

      
      (begin-test-1
        "begin 1; 2; 3 end"
        3)

      ;; extremely primitive testing for mutable variables

      (assignment-test-1 "let x = 17
                          in begin set x = 27; x end"
        27)


      (gensym-test
"let g = let count = 0 in proc(d) 
                        let d = set count = -(count,-1)
                        in count
in -((g 11), (g 22))"
-1)

      (even-odd-via-set "
let x = 0
in letrec even(d) = if zero?(x) then 1 
                                  else let d = set x = -(x,1)
                                       in (odd d)
              odd(d)  = if zero?(x) then 0 
                                  else let d = set x = -(x,1)
                                       in (even d)
   in let d = set x = 13 in (odd -99)" 1)
      
     ;; even more primitive testing for mutable pairs

      (simple-mutpair-left-1 "let p = newpair(22,33) in left(p)" 22)
      (simple-mutpair-right-1 "let p = newpair(22,33) in right(p)" 33)

      (simple-mutpair-setleft-1 "
let p = newpair(22,33) in begin setleft p = 77; left(p) end" 77)

      (simple-mutpair-setleft-2 "
let p = newpair(22,33) in begin setleft p = 77; right(p) end" 33)


      (simple-mutpair-setright-1 "
let p = newpair(22,33) in begin setright p = 77; right(p) end" 77)

      (simple-mutpair-setright-2 "
let p = newpair(22,33) in begin setright p = 77; left(p) end" 22)



      (gensym-using-mutable-pair-left
"let g = let count = newpair(0,0) 
         in proc (dummy) 
              begin
               setleft count = -(left(count), -1);
               left(count)
              end
in -((g 22), (g 22))"
-1)

      (gensym-using-mutable-pair-right
"let g = let count = newpair(0,0) 
         in proc (dummy) 
              begin
               setright count = -(right(count), -1);
               right(count)
              end
in -((g 22), (g 22))"
-1)

      (example-for-mutable-pairs-section "
let glo = newpair(11,22) 
in let f = proc (loc) 
            begin  % this is a comment
             setright loc = left(loc);
             setleft  glo = 99;
             -(left(loc),right(loc))
            end
in (f glo)"
                                         88)

      (array-test "
let a = newarray(2,-99)
in let p = proc (x) let v = arrayref(x,1) in arrayset(x,1,-(v,-1))
   in begin arrayset(a,1,0); (p a); (p a); arrayref(a,1) end
" 2)
      (array-length-test "let a=newarray(2,-99) in arraylength(a)" 2)


      ))
  )
