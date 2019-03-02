import Data.Vect

addMatrix : Num numType =>
            Vect rows (Vect cols numType) ->
            Vect rows (Vect cols numType) ->
            Vect rows (Vect cols numType)
addMatrix [] [] = ?addMatrix_rhs_1
addMatrix (x :: xs) (y :: ys) = ?addMatrix_rhs_3


multMatrix : Num numType =>
             Vect n (Vect m numType) ->
             Vect m (Vect p numType) ->
             Vect n (Vect p numType)
multMatrix xs ys = ?multmatrix_rhs


createEmpties : Vect n (Vect 0 elem)
createEmpties = replicate _ []

transposeHelper : (x : Vect n elem) ->
                  (xsTrans : Vect n (Vect len elem)) ->
                  Vect n (Vect (S len) elem)
transposeHelper [] [] = []
transposeHelper (x :: xs) (y :: ys) = (x :: y) :: transposeHelper xs ys

transposeMat : Vect m (Vect n elem) -> Vect n (Vect m elem)
transposeMat [] = createEmpties
transposeMat (x :: xs) = let xsTrans = transposeMat xs in
                         transposeHelper x xsTrans
