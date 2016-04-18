

fun is_older (date1 : int*int*int, date2 : int*int*int) =
    if #1 date1 < #1 date2
    then true
    else if #1 date1 > #1 date2
    then false
    else if #2 date1 < #2 date2
    then true
    else if #2 date1 > #2 date2
    then false
    else if #3 date1 < #3 date2
    then true
    else false

fun number_in_month (dates : (int*int*int) list, month : int) =
    if null dates
    then 0
    else if #2 (hd dates) = month
    then 1 + number_in_month (tl dates, month)
    else number_in_month (tl dates, month)

fun number_in_months (dates : (int*int*int) list, months : int list) =
    if null months
    then 0
    else number_in_month(dates, hd months) + number_in_months(dates, tl months)

fun dates_in_month (dates : (int*int*int) list, month : int) =
    if null dates
    then []
    else if #2 (hd dates) = month
    then hd dates :: dates_in_month (tl dates, month)
    else dates_in_month (tl dates, month)

fun dates_in_months (dates : (int*int*int) list, months : int list) =
    if null months
    then []
    else dates_in_month (dates, hd months) @ dates_in_months (dates, tl months)

fun get_nth (strings : string list, n : int) =
    if n = 1
    then hd strings
    else get_nth (tl strings, n - 1)

fun get_nth_int (ints : int list, n : int) =
    if n = 1
    then hd ints
    else get_nth_int (tl ints, n - 1)

fun date_to_string (date : int*int*int) =
    let
	val months_list = ["January","February","March","April","May","June","July","August","September","October","November","December"]
	val month_name = get_nth (months_list, #2 date)
    in
	month_name ^ " " ^ Int.toString(#3 date) ^ ", " ^ Int.toString(#1 date)
    end

fun number_before_reaching_sum (sum : int, numbers : int list) =
    if sum <= 0
    then ~1
    else 1 + number_before_reaching_sum (sum - (hd numbers), tl numbers)

fun what_month (day : int) =
    let
	val days_list = [31,28,31,30,31,30,31,31,30,31,30,31]
    in
	number_before_reaching_sum (day, days_list) + 1
    end

fun month_range (day1 : int, day2 : int) =
    if day1 > day2
    then []
    else what_month (day1) :: month_range(day1+1, day2)

fun oldest (dates : (int*int*int) list) =
    if null dates
    then NONE
    else let fun oldest_of_nonempty (dates : (int*int*int) list) =
		 if null (tl dates)
		 then hd dates
		 else
		     let
			 val ans = oldest_of_nonempty (tl dates)
		     in
			 if is_older (hd dates, ans)
			 then hd dates
			 else ans
		     end
	 in
	     SOME (oldest_of_nonempty dates)
	 end

fun remove_duplicates (alist : int list) =
    let fun is_member (e : int, alist : int list) =
	    if null alist
	    then false
	    else if e = hd alist
	    then true
	    else is_member (e, tl alist)
    in
	if null alist
	then []
	else if is_member (hd alist, tl alist)
	then remove_duplicates (tl alist)
	else hd alist :: remove_duplicates (tl alist)
    end


fun number_in_months_challenge (dates : (int*int*int) list, months : int list) =
    let
	val new_months = remove_duplicates (months)
    in
	if null new_months
	then 0
	else number_in_month(dates, hd new_months) + number_in_months(dates, tl new_months)
    end

fun dates_in_months_challenge (dates : (int*int*int) list, months : int list) =
    let
	val new_months = remove_duplicates (months)
    in
	if null new_months
	then []
	else dates_in_month (dates, hd new_months) @ dates_in_months (dates, tl new_months)
    end

fun reasonable_date (date : int*int*int) =
    let
	val days_list = [31,28,31,30,31,30,31,31,30,31,30,31]
	val days_list_leap = [31,29,31,30,31,30,31,31,30,31,30,31]
	fun is_leap_year (year : int) =
	    if year mod 400 = 0 orelse (year mod 4 = 0 andalso year mod 100 <> 0)
	    then true
	    else false

	fun day_is_ok () =
	    let
		val temp_list =
		    if is_leap_year (#1 date)
		    then days_list_leap
		    else days_list
	    in
		if #3 date >= 1 andalso #3 date <= get_nth_int (temp_list, #2 date)
		then true
		else false
	    end
    in
	if #1 date < 1
	then false
	else if #2 date < 1 orelse #2 date > 12
	then false
	else if not (day_is_ok ())
	then false
	else true	     
    end


