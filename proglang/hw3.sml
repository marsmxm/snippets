(* Coursera Programming Languages, Homework 3, Provided Code *)

exception NoAnswer

datatype pattern = Wildcard
		 | Variable of string
		 | UnitP
		 | ConstP of int
		 | TupleP of pattern list
		 | ConstructorP of string * pattern

datatype valu = Const of int
	      | Unit
	      | Tuple of valu list
	      | Constructor of string * valu

fun g f1 f2 p =
    let 
	val r = g f1 f2 
    in
	case p of
	    Wildcard          => f1 ()
	  | Variable x        => f2 x
	  | TupleP ps         => List.foldl (fn (p,i) => (r p) + i) 0 ps
	  | ConstructorP(_,p) => r p
	  | _                 => 0
    end

(**** for the challenge problem only ****)

datatype typ = Anything
	     | UnitT
	     | IntT
	     | TupleT of typ list
	     | Datatype of string

(**** you can put all your code here ****)

val only_capitals =
    List.filter (fn x => Char.isUpper(String.sub(x,0)))

val longest_string1 =
    foldl (fn (s1, s2) => if String.size s1 > String.size s2
			  then s1
			  else s2) 
	  ""

val longest_string2 =
     foldl (fn (s1, s2) => if String.size s1 >= String.size s2
			   then s1
			   else s2) 
	   ""

fun longest_string_helper f =
    foldl (fn (s1, s2) => if f(String.size s1, String.size s2)
			  then s1
			  else s2)
	  ""

val longest_string3 =
    longest_string_helper (fn (i1, i2) => i1 > i2)

val longest_string4 =
    longest_string_helper (fn (i1, i2) => i1 >= i2)

val longest_capitalized = longest_string1 o only_capitals

val rev_string = String.implode o rev o String.explode

fun first_answer f xs =
    case xs of
	[] => raise NoAnswer
      | x::xs' => case f x of
		      NONE => first_answer f xs'
		    | SOME v => v


fun all_answers f xs =
    let fun helper xs accu =
	    case xs of
		[] => SOME accu
	      | x::xs' => case f x of
			      NONE => NONE
			    | SOME lst => helper xs' (lst @ accu)
    in
	helper xs []
    end

			
val count_wildcards = g (fn () => 1) (fn x => 0)

val count_wild_and_variable_lengths = g (fn () => 1) (fn x => String.size x)

fun count_some_var (s, p) = g (fn () => 0)
			      (fn x => if x = s then 1 else 0)
			      p

fun check_pat p =
    let
	fun get_list p =
	    case p of
		Variable x        => [x]
	      | TupleP ps         =>
		List.foldl (fn (pp,accu) => ((get_list pp) @ accu)) [] ps
	      | ConstructorP (_,pp) => get_list pp
	      | _                 => []

	fun has_repeats xs =
	    case xs of
		[] => false
	      | x::xs' => (List.exists (fn s => s=x) xs')
			  orelse has_repeats xs'
    in
	not (has_repeats (get_list p))
    end

fun match (v, p) =
    case (p, v) of
	(Wildcard, _) => SOME []
      | (Variable s, _) => SOME [(s, v)]
      | (UnitP, Unit) => SOME []
      | (ConstP i, Const j) => if i=j then SOME [] else NONE
      | (TupleP ps, Tuple vs) => if List.length ps = List.length vs
				 then all_answers match (ListPair.zip (vs, ps))
				 else NONE
      | (ConstructorP (s1,p), Constructor (s2,v)) => if s1=s2
						    then case match (v,p) of
							     NONE => NONE
							   | SOME lst => SOME lst
						    else NONE
      | _ => NONE

fun first_match v ps =
    SOME (first_answer (fn p => match (v,p)) ps)
    handle NoAnswer => NONE


