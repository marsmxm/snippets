module Main

import System
import Effect.Random

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


guess : (target : Nat) -> IO ()
guess target = do
  putStrLn "Guess a number:"
  input <- getLine
  if all isDigit (unpack input)
    then if (cast input) < target
      then do
        putStrLn "Too small!"
        guess target
      else if (cast input) > target
        then do
          putStrLn "Too large!"
          guess target
        else
          putStrLn "You get it!"
    else do
      putStrLn "Please input a valid number."
      guess target
