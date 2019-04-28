module Main
import Data.Vect

main: IO ()
main = putStrLn (cast 'x')

StringOrInt : Bool -> Type
StringOrInt x = case x of
  True => Int
  False => String

getStringOrInt : (x : Bool) -> StringOrInt x
getStringOrInt x = case x of
  True => 42
  False => "Fourty two"

valToString : (x : Bool) -> StringOrInt x -> String
valToString x val = case x of
  True => cast val
  False => val

identity : t -> t
identity x = x

double : Num t => t -> t
double x = x + x

twice : (a -> a) -> a -> a
twice f x = f (f x)

palindrome : Nat -> String -> Bool
palindrome len str = let s = toLower str in
                         if (length s) > len
                          then (reverse s) == s
                          else False

counts : String -> (Nat, Nat)
counts str = (length (words str), length str)

top_ten : Ord a => List a -> List a
top_ten xs = take 10 (reverse (sort xs))

over_length : Nat -> List String -> Nat
over_length len strs = length (filter (\x => (length x) > len) strs)

describeList : List Int -> String
describeList [] = "Empty"
describeList (x :: xs) = "Non-empty, tail = " ++ show xs

allLengths : List String -> List Nat
allLengths [] = []
allLengths (word :: words) = length word :: allLengths words

mutual
  isEven : Nat -> Bool
  isEven Z = True
  isEven (S k) = isOdd k
  isOdd : Nat -> Bool
  isOdd Z = False
  isOdd (S k) = isEven k


fourInts : Vect 4 Int
fourInts = [0, 1, 2, 3]
sixInts : Vect 6 Int
sixInts = [4, 5, 6, 7, 8, 9]
tenInts : Vect 10 Int
tenInts = fourInts ++ sixInts

pred : Nat -> Nat
pred Z = Z
pred (S k) = k

myPlus : Nat -> Nat -> Nat
myPlus Z m = m
myPlus (S k) m = S (myPlus k m)
