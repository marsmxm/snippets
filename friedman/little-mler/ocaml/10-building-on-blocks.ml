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
