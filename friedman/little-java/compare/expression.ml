exception BadResult of string

type exp =
    Int    of int
  | Negate of exp
  | Add    of exp * exp

let rec eval = function  e ->
  match e with
      Int _      -> e
    | Negate e1  -> (match eval e1 with
                        Int i -> Int (-i)
                      | _ -> raise (BadResult "non-int in negation"))
    | Add(e1,e2) -> (match (eval e1, eval e2) with
                        (Int i, Int j) -> Int (i+j)
                      | _ -> raise (BadResult "non-ints in addition"))

let rec toString = function e ->
  match e with
      Int i      -> string_of_int i
    | Negate e1  -> "-(" ^ (toString e1) ^ ")"
    | Add(e1,e2) -> "("  ^ (toString e1) ^ " + " ^ (toString e2) ^ ")"

let rec hasZero = function e ->
  match e with
      Int i      -> i=0
    | Negate e1  -> hasZero e1
    | Add(e1,e2) -> (hasZero e1) || (hasZero e2)

(* let rec noNegConstants = function e ->
  match e with
      Int i       -> if i < 0 then Negate(Int(-i)) else e
    | Negate e1   -> Negate(noNegConstants e1)
    | Add(e1,e2)  -> Add(noNegConstants e1, noNegConstants e2) *)

(* type ’a ext_exp =
    Int    of int
  | Negate of ’a ext_exp
  | Add    of ’a ext_exp * ’a ext_exp
  | OtherExtExp  of ’a

let rec eval_ext = function (f, e) ->
  match e with
      Int i -> i
    | Negate e1 -> 0 - (eval_ext (f,e1))
    | Add(e1,e2) -> (eval_ext (f,e1)) + (eval_ext (f,e2)) 
    | OtherExtExp e -> f e *)
;;
toString (eval (Add ((Negate (Int 5)), (Int 6))))