(module tests mzscheme
  
  (provide test-list)
  ;;;;;;;;;;;;;;;; tests ;;;;;;;;;;;;;;;;
  
  (define test-list
    '(
  
      ;; Ex 6.13
      (removeall "
letrec removeall(n s k) =
          if null?(s)
          then (k emptylist)
          else if number?(car(s))
               then if equal?(n,car(s))
                    then (removeall n cdr(s) k)
                    else (removeall n cdr(s) proc(v) (k cons(car(s), v)))
               else (removeall n car(s) 
                               proc(v1)
                                (removeall n cdr(s)
                                           proc(v2) (k cons(v1,v2))))
in (removeall 5 cons(1, cons(5, cons(2, cons(5, emptylist)))) proc(v) v)
"
                 (1 2))
      )))

