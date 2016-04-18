(* Dan Grossman, Coursera PL, HW2 Provided Code *)

(* if you use this function to compare two strings (returns true if the same
   string), then you avoid several of the functions in problem 1 having
   polymorphic types that may be confusing *)
fun same_string(s1 : string, s2 : string) =
    s1 = s2

(* put your solutions for problem 1 here *)
fun all_except_option (s, lst) =
    case lst of
	[] => NONE
      | x :: xs => if same_string (s, x)
		   then SOME xs
		   else case all_except_option(s, xs) of
			    NONE => NONE
			  | SOME lst' => SOME (x :: lst')

fun get_substitutions1 (substitutions, s) =
    case substitutions of
	[] => []
      | x :: xs => case all_except_option (s, x) of
		       NONE => get_substitutions1 (xs, s)
		     | SOME lst => lst @ get_substitutions1 (xs, s)

fun get_substitutions2 (substitutions, s) =
    let
	fun get_sub_helper (subst, accu) =
	    case subst of
		[] => accu
	      | x :: xs => case all_except_option (s, x) of
			       NONE => get_sub_helper (xs, accu)
			     | SOME lst => get_sub_helper (xs, accu @ lst)
    in
	get_sub_helper (substitutions, [])
    end

fun similar_names (subst, {first=f, middle=m, last=l}) =
    let
	fun helper xs =
	    case xs of
		[] => []
	      | x :: xs' => {first=x, middle=m, last=l} ::
			    helper xs'
    in
	{first=f, middle=m, last=l} ::
	helper (get_substitutions2 (subst, f))
    end



(* you may assume that Num is always used with values 2, 3, ..., 10
   though it will not really come up *)
datatype suit = Clubs | Diamonds | Hearts | Spades
datatype rank = Jack | Queen | King | Ace | Num of int 
type card = suit * rank

datatype color = Red | Black
datatype move = Discard of card | Draw 

exception IllegalMove

(* put your solutions for problem 2 here *)
fun card_color (s, r) =
    case s of
	Clubs => Black
      | Diamonds => Red
      | Hearts => Red
      | Spades => Black

fun card_value (s, r) =
    case r of
	Num i => i
      | Ace => 11
      | _ => 10

fun remove_card (cs, c, e) =
    case cs of
	[] => raise e
      | c' :: cs' => if c' = c
		     then cs'
		     else c' :: remove_card(cs', c, e)

fun all_same_color cs =
    case cs of
	[] => true
      | _::[] => true
      | head::(neck::rest) => (card_color head = card_color neck andalso
			       all_same_color (neck::rest))

fun sum_cards cs =
    let fun sum_helper (clist, accu) =
	    case clist of
		[] => accu
	      | c::clist' => sum_helper (clist', accu + card_value c)
    in
	sum_helper (cs, 0)
    end

fun score (cs, goal) =
    let
	val sum = sum_cards cs
	val pre_score = if sum > goal
			then 3 * (sum - goal)
			else goal - sum
    in
	if all_same_color cs
	then pre_score div 2
	else pre_score
    end

fun officiate (card_list, move_list, goal) =
    let fun helper (hlist, clist, mlist) =
	    let
		val hscore = score (hlist, goal)
	    in
		case mlist of
		    [] => hscore
		  | m::ms =>
		    if hscore > goal
		    then hscore
		    else case m of
			     Discard c => helper (remove_card (hlist, c, IllegalMove),
						 clist, ms)
			   | Draw => case clist of
					 [] => hscore
				       | head::clist' => helper (head::hlist, clist', ms)
	    end
    in
	helper ([], card_list, move_list)
    end


fun score_challenge (cs, goal) =
    let
	fun count_ace cs' =
	    case cs' of
		[] => 0
	      | c :: cs'' => case c of
				 (_, Ace) => 1 + count_ace cs''
			       | _ => count_ace cs''
	val ace_count = count_ace cs
	val sum = sum_cards cs
	fun cal_pre_score (sum', ace_count) =
	    if sum' <= goal
	    then goal - sum'
	    else if ace_count = 0
	    then 3 * (sum' - goal)
	    else
		let
		    val next_score = cal_pre_score (sum' - 10, ace_count - 1)
		in
		    if next_score < (3 * (sum' - goal))
		    then next_score
		    else 3 * (sum' - goal)
		end
	val pre_score = cal_pre_score (sum, ace_count)
    in
	if all_same_color cs
	then pre_score div 2
	else pre_score
    end

fun officiate_challenge (card_list, move_list, goal) =
    let fun helper (hlist, clist, mlist) =
	    let
		val hscore = score_challenge (hlist, goal)
	    in
		case mlist of
		    [] => hscore
		  | m::ms =>
		    if hscore > goal
		    then hscore
		    else case m of
			     Discard c => helper (remove_card (hlist,
							       c,
							       IllegalMove),
						 clist, ms)
			   | Draw => case clist of
					 [] => hscore
				       | head::clist' => helper (head::hlist,
								 clist', ms)
	    end
    in
	helper ([], card_list, move_list)
    end

(*
fun careful_player (cs, goal) =
    let fun helper (hlist, clist, accu) =
	    let
		val hscore = score (hlist, goal)
		val hvalue = sum_cards hlist
	    in
		if hscore = 0
		then accu
		else if goal - hvalue > 10
		then case clist of
			 [] => accu @ [Draw]
		       | x::xs => helper (x::hlist, xs, accu @ [Draw])

		else []
	    end
    in
	helper ([], cs, [])
    end


*)
