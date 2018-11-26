let identity x = x

let true_maker _ = true

type bool_or_int =
  | Hot of bool
  | Cold of int

let hot_maker _ x = Hot x

let help f = 
  Hot (true_maker (if true_maker 5 then f else true_maker))

type chain =
  Link of int * (int -> chain)

let rec ints n = Link (n + 1, ints)
let rec skips n = Link (n + 2, skips)

let divides_evenly (n, c) = (n mod c = 0)

let is_mod_5_or_7 n = divides_evenly (n, 5) || divides_evenly (n, 7)

let rec some_ints n = 
  if is_mod_5_or_7 (n + 1)
  then Link (n + 1, some_ints)
  else some_ints (n + 1)

let rec chain_item = function
  (n, Link (i, f)) -> 
    if n <= 1
    then i
    else chain_item (n - 1, f i)

let rec is_prime n = has_no_divisors (n, n - 1)
and has_no_divisors (n, c) =
  if c = 1 then true
  else if divides_evenly (n, c) 
        then false
        else has_no_divisors (n, c - 1)
