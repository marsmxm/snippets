type fruit =
  | Peach
  | Apple
  | Pear
  | Lemon
  | Fig

type tree =
  | Bud
  | Flat of fruit * tree
  | Split of tree * tree

let rec flat_only = function
  | Bud -> true
  | Flat (f, t) -> flat_only t
  | Split (_, _) -> false

let rec split_only = function
  | Bud -> true
  | Flat (_, _) -> false
  | Split (t1, t2) -> split_only t1 && split_only t2

let contains_fruit t = not (split_only t)

let rec height = function
  | Bud -> 0
  | Flat (_, t) -> (height t) + 1
  | Split (t1, t2) -> (max (height t1) (height t2)) + 1

let rec occurs = fun (tf, t) ->
  match t with 
  | Bud -> 0
  | Flat (f, t') -> (occurs (tf, t')) + if tf = f then 1 else 0
  | Split (t1, t2) -> (occurs (tf, t1)) + (occurs (tf, t2))

type 'a slist =
  | Empty
  | Scons of ('a sexp) * ('a slist)

and 'a sexp =
  | An_atom of 'a
  | A_slist of 'a slist

let rec occurs_in_slist = function
  | (a, Empty) -> 0
  | (a, Scons (s, y)) -> (occurs_in_sexp (a, s)) + (occurs_in_slist (a, y))
and occurs_in_sexp = function
  | (a, An_atom b) -> if a = b then 1 else 0
  | (a, A_slist y) -> occurs_in_slist (a, y)

let rec subst_in_slist = function
  | (n, a, Empty) -> Empty
  | (n, a, Scons (s, x)) -> Scons (subst_in_sexp (n, a, s), subst_in_slist (n, a, x))
and subst_in_sexp = function
  | (n, a, An_atom b) -> if a = b then An_atom n else An_atom b
  | (n, a, A_slist x) -> A_slist (subst_in_slist (n, a, x))

let rec remove_from_slist = function
  | (a, Empty) -> Empty
  | (a, Scons (An_atom b, y)) ->
    if a = b 
    then remove_from_slist (a, y)
    else Scons (
      An_atom b, 
      remove_from_slist (a, y))
  | (a, Scons (A_slist x, y)) -> 
    Scons (
      A_slist (remove_from_slist (a, x)), 
      remove_from_slist (a, y))
and remove_from_sexp = function
  | (a, An_atom b) -> An_atom b
  | (a, A_slist y) -> A_slist (remove_from_slist (a, y))
