type shish_kebab =
  | Skewer
  | Onion of shish_kebab
  | Lamb of shish_kebab
  | Tomato of shish_kebab

(* let rec only_onions shish =
  match shish with
    Skewer -> true
  | Onion inner -> only_onions inner
  | _ -> false *)

let rec only_onions : shish_kebab -> bool = function 
    Skewer -> true
  | Onion x -> only_onions x
  | _ -> false

let rec is_vegetarian = function
  | Skewer -> true
  | Onion x -> is_vegetarian x
  | Lamb _ -> false
  | Tomato x -> is_vegetarian x

type 'a shish =
    Bottom of 'a
  | Onion of 'a shish
  | Lamb of 'a shish
  | Tomato of 'a shish

type rod =
    Dagger
  | Fork
  | Sword

type plate =
    Gold_plate
  | Silver_plate
  | Brass_plate

let _ = Onion (Tomato (Bottom Dagger))

let rec is_veggie = function
  | Bottom _ -> true
  | Onion x -> is_veggie x
  | Lamb _ -> false
  | Tomato x -> is_veggie x

let rec what_bottom = function
  | Bottom x -> x
  | Onion x -> what_bottom x
  | Lamb x -> what_bottom x
  | Tomato x -> what_bottom x

  
