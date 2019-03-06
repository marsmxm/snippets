import Data.Vect

addMatrix : Num numType =>
            Vect rows (Vect cols numType) ->
            Vect rows (Vect cols numType) ->
            Vect rows (Vect cols numType)
addMatrix [] [] = []
addMatrix (x :: xs) (y :: ys) = (zipWith (+) x y) :: (addMatrix xs ys)

createEmpties : Vect n (Vect 0 elem)
createEmpties {n = Z} = []
createEmpties {n = (S k)} = [] :: createEmpties

transposeMat : Vect m (Vect n elem) -> Vect n (Vect m elem)
transposeMat [] = createEmpties
transposeMat (x :: xs) = let xsTrans = transposeMat xs in
                         zipWith (::) x xsTrans


multRow : Num numType =>
          Vect m numType ->
          Vect p (Vect m numType) ->
          Vect p numType
multRow xs [] = []
multRow xs (ys :: yss) = (sum (zipWith (*) xs ys)) :: (multRow xs yss)

multHelper : Num numType =>
             (xs : Vect n (Vect m numType)) ->
             (ysTrans : Vect p (Vect m numType)) ->
             Vect n (Vect p numType)
multHelper [] ysTrans = []
multHelper (x :: xs) ysTrans = (multRow x ysTrans) :: (multHelper xs ysTrans)

total multMatrix : Num numType =>
                   Vect n (Vect m numType) ->
                   Vect m (Vect p numType) ->
                   Vect n (Vect p numType)
multMatrix [] [] = []
multMatrix xs ys = let ysTrans = transposeMat ys in
                   multHelper xs ysTrans


lengthV : Vect n elem -> Nat
lengthV {n} xs = n
