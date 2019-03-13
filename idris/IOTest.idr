import System

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
