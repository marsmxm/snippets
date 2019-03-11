printLonger : IO ()
printLonger = do
  putStrLn "Input two strings:"
  str1 <- getLine
  str2 <- getLine
  if (length str1 >= length str2)
    then putStrLn str1
    else putStrLn str2

printLongerLonger : IO ()
printLongerLonger =
  putStrLn "Input two strings:" >>=
    \_ => getLine >>=
      \str1 => getLine >>=
        \str2 => if (length str1 >= length str2)
          then putStrLn str1
          else putStrLn str2
