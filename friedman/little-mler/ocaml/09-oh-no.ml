type 'a list =
  | Empty
  | Cons of 'a * 'a list

type box =
  | Bacon
  | Ix of int

exception No_bacon of int

let rec where_is = function
  | Empty -> raise (No_bacon 0)
  | Cons (Bacon, _) -> 1
  | Cons (_, l1) -> 1 + where_is l1

let _ = 
  try 
    where_is (Cons (Ix 1, Cons (Ix 2, Empty)))
  with No_bacon i -> i

exception Out_of_range

let rec list_item = function
  | (n, Empty) -> raise Out_of_range
  | (n, Cons (abox, rest)) -> 
    if n = 1 then abox else list_item (n - 1, rest)

let rec find n boxes =
  let nth_item = (list_item (n, boxes)) in
  match nth_item with
  | Bacon -> n
  | Ix i -> find i boxes
