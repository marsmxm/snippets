type meza =
    Shrimp
  | Calamari
  | Escargots
  | Hummus

type main =
    Steak
  | Ravioli
  | Chicken
  | Eggplant

type salad =
    Green
  | Cucumber
  | Greek

type dessert =
  | Sundae
  | Mousse
  | Torte

let add_a_steak x = (x, Steak)

let has_steak : meza * main * dessert -> bool = function
    (_, Steak, _) -> true
  | _ -> false
