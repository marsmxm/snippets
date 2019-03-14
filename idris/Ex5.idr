module Main

import System
import Data.Vect

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

readToBlank : IO (List String)
readToBlank = do
  x <- getLine
  if x == ""
    then pure []
    else do xs <- readToBlank
            pure (x :: xs)

saveListHelper : (List String) -> (h :File) -> IO ()
saveListHelper [] h = pure ()
saveListHelper (x :: xs) h = do
  Right _ <- fPutStrLn	h x
    | Left err => printLn err
  saveListHelper xs h

saveList : (List String) -> (filename : String) -> IO ()
saveList xs filename = do
  Right h <- openFile filename Append
    | Left err => printLn err
  saveListHelper xs h
  closeFile h

readAndSave : IO ()
readAndSave = do
  strs <- readToBlank
  putStrLn ("Input a filename:")
  filename <- getLine
  saveList strs filename

readVectFileHelper : (h : File) -> IO (n : Nat ** Vect n String)
readVectFileHelper h = do
  eof <- fEOF h
  if eof
    then pure (_ ** [])
    else do
      Right x <- fGetLine h
        | Left err => do
          printLn err
          pure (_ ** [])
      (_ ** xs) <- readVectFileHelper h
      pure (_ ** x :: xs)

readVectFile : (filename : String) -> IO (n ** Vect n String)
readVectFile filename = do
  Right h <- openFile filename Read
    | Left err => do
      printLn err
      pure (_ ** [])
  readVectFileHelper h
