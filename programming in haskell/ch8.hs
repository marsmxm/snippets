module Ch8 where

import Parsing

expr :: Parser Int
expr = do t <- term
          do symbol "+"
             e <- expr
             return (t + e)
            +++ return t

term :: Parser Int
term = do f <- factor
          do symbol "*"
             t <- term
             return (f * t)
            +++ return f

factor :: Parser Int
factor = do symbol "("
            e <- expr
            symbol ")"
            return e
           +++ natural
         
eval :: String -> Int
eval xs = case parse expr xs of
           [(n, [])] -> n
           [(_, out)] -> error ("unusedinput"++out)
           [] -> error "invalid input"

comment :: Parser ()
comment = do string "--"
             many (sat (\c -> c /= '\n'))
             char '\n'
             return ()
             

