import Data.Vect

addMatrix : Num numType =>
            Vect rows (Vect cols numType) ->
            Vect rows (Vect cols numType) ->
            Vect rows (Vect cols numType)
addMatrix xs ys = ?addMatrix_rhs


multMatrix : Num numType =>
             Vect n (Vect m numType) ->
             Vect m (Vect p numType) ->
             Vect n (Vect p numType)
multMatrix xs ys = ?multmatrix_rhs


createEmpties : Vect n (Vect 0 elem)
createEmpties = replicate _ []

transposeMat : Vect m (Vect n elem) -> Vect n (Vect m elem)
transposeMat [] = createEmpties
transposeMat (x :: xs) = let xsTrans = transposeMat xs in
                         zipWith (::) x xsTrans
