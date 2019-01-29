mysum [] = 0
mysum (n:ns) = n + mysum ns

qsort [] = []
qsort (x:xs) = qsort smaller ++ x ++ qsort larger 
                where smaller = [a | a <- xs, a <= x]
                      larger = [b | b <- xs, b > x]
