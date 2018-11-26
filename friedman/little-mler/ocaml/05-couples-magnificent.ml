type 'a pizza =
  | Bottom
  | Topping of ('a * ('a pizza))

type fish =
  | Anchovy
  | Lox
  | Tuna

let p1 = Topping (Anchovy, Topping (Tuna, Topping (Anchovy, Bottom)))

let rec rem_anchovy = function
  | Bottom -> Bottom
  | Topping (Anchovy, x) -> rem_anchovy x
  | Topping (fish, x) -> Topping (fish, rem_anchovy x)

let rec rem_tuna = function
  | Bottom -> Bottom
  | Topping (Tuna, x) -> rem_tuna x
  | Topping (fish, x) -> Topping (fish, rem_tuna x)

let eq_fish = function
  | (Anchovy, Anchovy) -> true
  | (Lox, Lox) -> true
  | (Tuna, Tuna) -> true
  | _ -> false

let rec rem_fish = function
  | (x, Bottom) -> Bottom
  | (x, Topping (t, p)) -> 
    if eq_fish (x, t) 
    then rem_fish (x, p)
    else Topping (t, rem_fish (x, p))

let eq_int : int * int -> bool = fun (m, n) -> m = n

let rec rem_int = function
  | (x, Bottom) -> Bottom
  | (x, Topping (t, p)) ->
    if eq_int (x, t) then rem_int (x, p) else Topping (t, rem_int (x, p))

let rec rem = fun (f, p) ->
  match p with
  | Bottom -> Bottom
  | Topping (t, p') ->
    if f t then rem (f, p') else Topping (t, rem (f, p'))

let rem_fish2 (x, p) = rem ((fun x' -> eq_fish (x, x')), p)
let rem_int2 (x, p) = rem ((fun x' -> eq_int (x, x')), p)


type num =
    Zero
  | One_more_than of num

let rec eq_num = function
  | (Zero, Zero) -> true
  | (One_more_than n1, One_more_than n2) -> eq_num (n1, n2)
  | _ -> false
