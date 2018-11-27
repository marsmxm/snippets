type 'a list =
  | Empty
  | Cons of 'a * 'a list

type orapl =
  | Orage
  | Apple

let rec subst = function
  | (rel, n, a, Empty) -> Empty
  | (rel, n, a, Cons (e, t)) ->
    if rel (a, e)
    then Cons (n, subst (rel, n, a, t))
    else Cons (e, subst (rel, n, a, t))

let rec subst_pred = function
  | (pred, n, Empty) -> Empty
  | (pred, n, Cons (e, t)) ->
    if pred e
    then Cons (n, subst_pred (pred, n, t))
    else Cons (e, subst_pred (pred, n, t))

let less_than (m, n) = m < n

let less_than_15 x = less_than (x, 15)

let in_range ((small, large), x) =
  if less_than (small, x)
  then less_than (x, large)
  else false

let in_range_11_16 x = in_range ((11, 16), x)

let in_range_c (small, large) x =
  if less_than (small, x)
  then less_than (x, large)
  else false

let in_range_c_11_16 = in_range_c (11, 16)

let rec subst_c pred t =
  match t with
  | (n, Empty) -> Empty
  | (n, Cons (e, t)) ->
    if pred e
    then Cons (n, subst_c pred (n, t))
    else Cons (e, subst_c pred (n, t))

let subst_c_in_range_11_16 = subst_c (in_range_c (11, 16))

let rec combine = function
  | (Empty, l2) -> l2
  | (Cons (a, l1), l2) -> Cons (a, combine (l1, l2))
  
let rec combine_c l1 l2 =
  match (l1, l2) with
  | (Empty, l2) -> l2
  | (Cons (a, l1), l2) -> Cons (a, combine (l1, l2))

let rec combine_s l =
  let base l2 = l2 in
  match l with
  | Empty -> base
  | Cons (a, l1) -> (fun l2 -> Cons (a, combine_s l1 l2))
