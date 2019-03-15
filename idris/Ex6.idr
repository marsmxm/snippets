import Data.Vect

Matrix : Nat -> Nat -> Type
Matrix n m = Vect n (Vect m Double)

testMatrix : Matrix 2 3
testMatrix = [[0, 0, 0], [0, 0, 0]]

TupleVect : Nat -> Type -> Type
TupleVect Z t = ()
TupleVect (S k) t = Pair t (TupleVect k t)

test : TupleVect 4 Nat
test = (1,2,3,4,())
