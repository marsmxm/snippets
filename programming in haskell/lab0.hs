import Data.Char

factor :: Int -> [Int]
factor n = [x | x <- [1..n], n `mod` x == 0]

prime :: Int -> Bool
prime n = factor n == [1, n]

primes :: Int -> [Int]
primes n = [x | x <- [2..n], prime x]

sp xs ys = sum [x * y | (x, y) <- zip xs ys]

-- Caesar cipher
let2int :: Char -> Int
let2int c = ord c - ord baseChar
  where baseChar = if isLower c then 'a' else 'A'

int2let :: Int -> Char -> Char
int2let n baseChar = chr (ord baseChar + n)

shift :: Int -> Char -> Char
shift n c
  | isLower c = int2let ((let2int c + n) `mod` 26) 'a'
  | isUpper c = int2let ((let2int c + n) `mod` 26) 'A'
  | otherwise = c

encode :: Int -> String -> String
encode n xs = [shift n x | x <- xs]



