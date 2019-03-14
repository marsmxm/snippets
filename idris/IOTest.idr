import System
import Data.Vect

readNumber : IO (Maybe Nat)
readNumber = do
  input <- getLine
  if all isDigit (unpack input)
     then pure (Just (cast input))
     else pure Nothing

readPair : IO (String, String)
readPair = do
  str1 <- getLine
  str2 <- getLine
  pure (str1, str2)

usePair : IO ()
usePair = do
  (str1, str2) <- readPair
  putStrLn ("You entered " ++ str1 ++ " and " ++ str2)

readNumbers : IO (Maybe (Nat, Nat))
readNumbers =
  do Just num1_ok <- readNumber
       | Nothing => pure Nothing
     Just num2_ok <- readNumber
       | Nothing => pure Nothing
     pure (Just (num1_ok, num2_ok))


countdown : (secs : Nat) -> IO ()
countdown Z = putStrLn "Lift off!"
countdown (S k) = do
  putStrLn (show (S k))
  usleep 1000000
  countdown k


readVectLen : (len : Nat) -> IO (Vect len String)
readVectLen Z = pure []
readVectLen (S k) = do
  x <- getLine
  xs <- readVectLen k
  pure (x :: xs)


data VectUnknown : Type -> Type where
     MkVect : (len : Nat) -> Vect len a -> VectUnknown a

readVect0 : IO (VectUnknown String)
readVect0 = do
  x <- getLine
  if (x == "")
    then pure (MkVect _ [])
    else do
      MkVect _ xs <- readVect0
      pure (MkVect _ (x :: xs))


printVect : Show a => VectUnknown a -> IO ()
printVect (MkVect len xs)
      = putStrLn (show xs ++ " (length " ++ show len ++ ")")


anyVect : (n : Nat ** Vect n String)
anyVect = (3 ** ["Rod", "Jane", "Freddy"])


readVect : IO (n ** Vect n String)
readVect = do
  x <- getLine
  if (x == "")
    then pure (_ ** [])
    else do
      (_ ** xs) <- readVect
      pure (_ ** x :: xs)


zipInputs : IO ()
zipInputs = do putStrLn "Enter first vector (blank line to end):"
               (len1 ** vec1) <- readVect
               putStrLn "Enter second vector (blank line to end):"
               (len2 ** vec2) <- readVect
               case exactLength len1 vec2 of
                    Nothing => putStrLn "Vectors are different lengths"
                    Just vec2' => printLn (zip vec1 vec2')
