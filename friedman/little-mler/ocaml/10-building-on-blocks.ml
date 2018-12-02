module type N =
  sig
    type number
    exception Too_small
    val is_zero : number -> bool
    val succ : number -> number
    val pred : number -> number
  end

module NumberAsNum =
  functor () ->
    (struct
      type number =
        | Zero
        | One_more_than of number

      exception Too_small

      let is_zero n = (n = Zero)
      let succ n = One_more_than n

      let pred = function
        | Zero -> raise Too_small
        | One_more_than m -> m
    end : N)

module NumStruct = NumberAsNum()

module NumberAsInt =
  functor () ->
    (struct
      type number = int

      exception Too_small

      let is_zero n = (n = 0)
      let succ n = n + 1

      let pred = function
        | m when m > 0 -> m - 1
        | _ -> raise Too_small
    end : N)

module IntStruct = NumberAsInt()


module type P =
  sig
    type number
    val plus : number -> number -> number
  end

module PON =
  functor (AN : N) ->
    (struct
      type number = AN.number

      let rec plus m n =
        if AN.is_zero m
        then n
        else AN.succ (plus (AN.pred m) n)
    end : P)

module IntArith = PON(IntStruct)
module NumArith = PON(NumStruct)

(* let _ = IntArith.plus 2 3 
Error: This expression has type int but an expression was expected of type IntArith.number *)

;;

module type N_C_R =
  sig
    include N
    val conceal : int -> number
    val reveal : number -> int
  end

module NumberAsNum =
  functor () ->
    (struct
      type number =
        | Zero
        | One_more_than of number

      exception Too_small

      let is_zero n = (n = Zero)
      let succ n = One_more_than n

      let pred = function
        | Zero -> raise Too_small
        | One_more_than m -> m

      let rec conceal i =
        if i = 0
        then Zero
        else One_more_than (conceal (i - 1))
      
      let rec reveal = function
          Zero -> 0
        | One_more_than n -> (reveal n) + 1
      
    end : N_C_R)

module NumStruct = NumberAsNum()

module NumberAsInt =
  functor () ->
    (struct
      type number = int

      exception Too_small

      let is_zero n = (n = 0)
      let succ n = n + 1

      let pred = function
        | m when m > 0 -> m - 1
        | _ -> raise Too_small
      
      let conceal i = i
      let reveal n = n
    end : N_C_R)

module IntStruct = NumberAsInt()

module IntArith = PON(IntStruct)
module NumArith = PON(NumStruct)

let _ = NumStruct.reveal (NumStruct.succ (NumStruct.conceal 0))

(* let _ = NumStruct.reveal (NumArith.plus (NumStruct.conceal 1) (NumStruct.conceal 2))
Error: This expression has type NumStruct.number but an expression was expected of type NumArith.number *)

;;

(* the other syntax for functor *)
module PON (AN : N) : P with type number = AN.number =
  struct
    type number = AN.number

    let rec plus m n =
      if AN.is_zero m
      then n
      else AN.succ (plus (AN.pred m) n)
  end

module IntArith = PON(IntStruct)
module NumArith = PON(NumStruct)

let _ = NumStruct.reveal (NumArith.plus (NumStruct.conceal 1) (NumStruct.conceal 2))
let _ = IntStruct.reveal (IntArith.plus (IntStruct.conceal 1) (IntStruct.conceal 2))

module NumberAsInt2 () : N with type number = int =
  struct
    type number = int

    exception Too_small

    let is_zero n = (n = 0)
    let succ n = n + 1

    let pred = function
      | m when m > 0 -> m - 1
      | _ -> raise Too_small
    
    let conceal i = i
    let reveal n = n
  end

module IntStruct2 = NumberAsInt2()
module IntArith2 = PON(IntStruct2)

let _ = IntArith2.plus 2 3

type num =
    Zero
  | One_more_than of num

module NumberAsNum2 () : N with type number = num =
  struct
    type number = num

    exception Too_small

    let is_zero n = (n = Zero)
    let succ n = One_more_than n

    let pred = function
      | Zero -> raise Too_small
      | One_more_than m -> m

    let rec conceal i =
      if i = 0
      then Zero
      else One_more_than (conceal (i - 1))
    
    let rec reveal = function
        Zero -> 0
      | One_more_than n -> (reveal n) + 1
    
  end

module NumStruct2 = NumberAsNum2()
module NumArith2 = PON(NumStruct2)


module type S =
  sig
    type number1
    type number2

    val similar : number1 -> number2 -> bool
  end

module Same (N1 : N) (N2 : N) : S with
    type number1 = N1.number and
    type number2 = N2.number =
  struct
    type number1 = N1.number
    type number2 = N2.number

    let rec sim n m =
      if N1.is_zero n
      then N2.is_zero m
      else sim (N1.pred n) (N2.pred m)

    let similar n m =
      try sim n m
      with
          N1.Too_small -> false
        | N2.Too_small -> false
  end

module SimIntNum = Same (IntStruct2) (NumStruct2)

let _ = SimIntNum.similar 3 (One_more_than (One_more_than Zero))

module type J =
  sig
    val new_plus : int -> int -> int
  end

module NP (N1 : N_C_R) 
          (P1 : P with type number = N1.number) : J =
  struct
    let new_plus x y =
      N1.reveal (P1.plus (N1.conceal x) (N1.conceal y))
  end

module NPStruct = NP (NumStruct) (NumArith)

module type T =
  sig
    type number
    val times : number -> number -> number
  end

module TON (A_N : N) 
           (A_P : P with type number = A_N.number) 
           : (T with type number = A_N.number) = struct
  type number = A_N.number

  let rec times n1 n2 =
    if A_N.is_zero n1
    then n1
    else A_P.plus n2 (times (A_N.pred n1) n2)
end

;;

module type Ysig =
  sig
    val y : (('a -> 'a) -> ('a -> 'a)) -> ('a -> 'a)
  end

module Yfunc () : Ysig = struct
  type 'a t = Into of ('a t -> 'a)

  let rec y f =
    h f (Into (h f))
  and h f a =
    f (g a)
  and g (Into a) x =
    a (Into a) x
end

module Ystruct = Yfunc ()

let mk_fact fact n =
  if n = 0
  then 1
  else n * fact (n - 1)


let _ = Ystruct.y mk_fact 10
