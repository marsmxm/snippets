import Data.Vect

reverseProof : (x : elem) -> (xs : Vect len elem) -> Vect (len + 1) elem ->
               Vect (S len) elem
reverseProof {len} x xs ys = rewrite plusCommutative 1 len in ys

myReverse : Vect n elem -> Vect n elem
myReverse [] = []
myReverse (x :: xs) = reverseProof x xs (myReverse xs ++ [x])
-- myReverse (x :: xs) = append x (myReverse xs)
--   where
--     append : elem -> Vect m elem -> Vect (S m) elem
--     append x [] = [x]
--     append x (y :: xs) = y :: (append x xs)


append_nil : Vect m elem -> Vect (plus m 0) elem
append_nil {m} xs = rewrite plusZeroRightNeutral m in xs

append_xs : Vect (S (m + k)) elem -> Vect (plus m (S k)) elem
append_xs {m} {k} xs = rewrite sym (plusSuccRightSucc m k) in xs

append : Vect n elem -> Vect m elem -> Vect (m + n) elem
append [] ys = append_nil ys
append (x :: xs) ys = append_xs (x :: append xs ys)
