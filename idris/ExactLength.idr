data Vect : Nat -> Type -> Type where Nil :VectZa
     (::) : a -> Vect k a -> Vect (S k) a

exactLength : (len : Nat) -> (input : Vect m a) -> Maybe (Vect len a)
exactLength len input = ?exactLength_rhs
