%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	2.2.5/exercise8.mms
%	Author:	M.Ruckert
%	Title:	Exercise 8, Step E8
%%%on
E8		PUSHJ	$0,LogE8 %%hide
		SUB	floor,floor,1 %%hide	
%% &E8	&SUB	&floor,floor,1		&&\ut  E8. Go down a floor.\\\lineref|firstex8|\cr
		TRIP	HoldCI,61		Wait 61 units.
		SL	$0,on,floor
		OR	$1,callcar,calldown
		AND	$2,$1,$0	Is $\.CALLCAR[FLOOR]. \ne0$
		BNZ	$2,1F		\quad or $\.CALLDOWN[FLOOR].\ne0$?	
		CMP	$2,floor,2
		BZ	$2,2F		If not, is $\.FLOOR.=2$?
		AND	$2,callup,$0 	If not, is $\.CALLUP[FLOOR].\ne0$?
		BZ	$2,E8		If not, repeat step E8.
2H		OR	$1,$1,callup   
		NEG	$2,64,floor	
		SL	$1,$1,$2	Ignore \.FLOOR. and above.
		BNZ	$1,E8		Are there calls for lower floors?
1H		SET	dt,23		It is time to stop the elevator.
		JMP	E2A		Wait 23 units and go to E2.\quad\slug
%%%off