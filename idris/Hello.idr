module Main

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

