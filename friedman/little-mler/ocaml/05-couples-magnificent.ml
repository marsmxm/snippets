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

