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

      (occurs-in?-1 "
letrec occurs-in?(n s k) =
  if null?(s)
  then (k 0)
  else if number?(car(s))
       then if equal?(n, car(s))
            then (k 1)
            else (occurs-in? n cdr(s) k)
       else (occurs-in? n car(s)
                        proc(v) 
                         if equal?(1, v)
                         then (k 1)
                         else (occurs-in? n cdr(s) k))
in (occurs-in? 7 cons(1,cons(2,cons(7,cons(3, emptylist)))) proc(v) v)
"
		    1)

      (occurs-in?-2 "
letrec occurs-in?(n s k) =
  if null?(s)
  then (k 0)
  else if number?(car(s))
       then if equal?(n, car(s))
            then (k 1)
            else (occurs-in? n cdr(s) k)
       else (occurs-in? n car(s)
                        proc(v) 
                         if equal?(1, v)
                         then (k 1)
                         else (occurs-in? n cdr(s) k))
in (occurs-in? 7 cons(1,cons(2,cons(2,cons(3, emptylist)))) proc(v) v)
"
		    0)

      (occurs-in?-3 "
letrec occurs-in?(n s k) =
  if null?(s)
  then (k 0)
  else if number?(car(s))
       then if equal?(n, car(s))
            then (k 1)
            else (occurs-in? n cdr(s) k)
       else (occurs-in? n car(s)
                        proc(v) 
                         if equal?(1, v)
                         then (k 1)
                         else (occurs-in? n cdr(s) k))
in (occurs-in? 7 cons(cons(7,emptylist), emptylist) proc(v) v)
"
		    1)

      (remfirst "
letrec occurs-in?(n s k) =
  if null?(s)
  then (k 0)
  else if number?(car(s))
       then if equal?(n, car(s))
            then (k 1)
            else (occurs-in? n cdr(s) k)
       else (occurs-in? n car(s)
                        proc(v) 
                         if equal?(1, v)
                         then (k 1)
                         else (occurs-in? n cdr(s) k))
in letrec remfirst(n s) =
    letrec loop(s k) =
             if null?(s)
             then (k emptylist)
             else if number?(car(s))
                  then if equal?(n, car(s))
                       then (k cdr(s))
                       else (loop cdr(s) proc(v) cons(car(s), v))
                  else (occurs-in? n car(s)
                                   proc(v) 
                                    if equal?(v, 1)
                                    then (loop car(s) proc(v1) cons(v1, cdr(s)))
                                    else (loop cdr(s) proc(v1) cons(car(s), v1)))
      in (loop s proc(v) v)
in (remfirst 7 cons(cons(7, emptylist), cons(1, emptylist)))
"
		(() 1))

      (depth "
letrec
 depth(s k) =
  if null?(s)
  then (k 1)
  else if number?(car(s))
       then (depth cdr(s) proc(v) (k +(v, 1)))
       else (depth car(s) 
                   proc(v1) 
                    (depth cdr(s) 
                           proc(v2)
                            if less?(+(v1,1), v2)
                            then (k v2)
                            else (k +(v1,1))))
in (depth cons(cons(1, cons(2, emptylist)), cons(3, emptylist)) proc(v) v)
"
	     4)


      (map "
letrec
 map(f l k) = if null?(l)
              then (k emptylist)
              else (f car(l) 
                      proc(v1) 
                       (map f cdr(l) 
                            proc(v2) (k cons(v1, v2))))
 square(n k) = (k *(n,n))
in (map square list(1,2,3,4,5) proc(v) v)
"
	   (1 4 9 16 25))

      (fnlrgtn "
letrec
 fnlrgtn(l n k) =
  if null?(l)
  then (k emptylist)
  else if number?(car(l))
       then if less?(n, car(l))
            then (k car(l))
            else (fnlrgtn cdr(l) n k)
       else (fnlrgtn car(l) n
                     proc(v1)
                      if number?(v1)
                      then (k v1)
                      else (fnlrgtn cdr(l) n k))
in (fnlrgtn list(1, list(3, list(2), 7, list(9))) 6 proc(v) v)
"
	       7)

      (every "
letrec
 every(pred l k) =
  if null?(l)
  then (k 1)
  else (pred car(l) 
             proc(v)
              if v
              then (every pred cdr(l) k)
              else (k 0))
in (every proc(n k) (k less?(n, 10)) list(6,7,8,9) proc(v) v)
"
	     1)
      
      )))

