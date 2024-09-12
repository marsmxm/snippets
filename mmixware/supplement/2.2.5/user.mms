%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	2.2.5/user.mms
%	Author:	M.Ruckert
%	Title:	Coroutine U
%%%on
%%%
%%%		Coroutine U
%%%
		PREFIX	:
%%%		
U1		PUSHJ	$0,Values	\ut  U1. Enter, prepare for successor.\\
		PUSHJ	$0,Hold		Put \.NODE(C). in \.WAIT. list.\lineref|user1|
		PUSHJ	$0,Allocate	Allocate new \.NODE(C)..\lineref|user1a|
		PUSHJ	$0,LogU1 %%hide
		STB	fi,c,IN	
		STB	fo,c,OUT	\lineref|user1b|
U2		SET	c0,c		\ut  U2. Signal and wait.\\ Save value of \.C..
		CMP	$0,fi,floor			 
		BNZ	$0,2F		Jump if $\.FLOOR.\ne \.fi.$.
		LDA	c,ELEV1		Set current coroutine to \.ELEV1..
		LDOU	$0,c,NEXTINST
		GETA	$1,E6		^{GETA+<GETA> (get address)}
		CMPU	$0,$0,$1	Is elevator positioned at E6?
		BNZ	$0,3F
		GETA	$0,E3
		STOU	$0,c,NEXTINST	If so, reposition at E3.
		PUSHJ	$0,DeleteW	Remove it from \.WAIT. list
		JMP	4F		\quad and reinsert it at front of \.WAIT..
3H		BZ	d3,2F		Jump if not waiting;
		SET	d3,off     	\quad otherwise, make it not waiting,
		SET	d1,on		\quad but loading.
4H		PUSHJ	$0,Immed	Schedule \.ELEV1. for 
		JMP	U3		\qquad immediate execution.^{Simulation}
%%%
2H		SL	$1,on,fi	Elevator is not on floor \.fi..
		CMP	$0,fo,fi
		ZSP	$2,$0,$1
		OR	callup,callup,$2
		ZSN	$2,$0,$1
		OR	calldown,calldown,$2 Press buttons.
		BZ	d2,0F		If not busy, make a decision.
		LDOU	$0,ELEV1+NEXTINST
		GETA	$1,E1
		CMP	$0,$0,$1	Elevator at E1?
		BNZ	$0,U3		If yes,
0H		PUSHJ	$0,Decision	\quad make a decision.
%%%
U3		SET	c,c0		\ut  U3. Enter queue.\\ Restore \.C..
		16ADDU	$1,fi,queue	^{9ADDU+<16ADDU> (times 16 and add unsigned)}
		PUSHJ	$0,Insert	Insert \.NODE(C). at right end of \.QUEUE[IN]..
U4A		SET	dt,tg		\lineref|2.2.5giveup|
		TRIP	HoldC,0		Wait \.GIVEUPTIME. units.
%%%
U4 		LDB	fi,c,IN		\ut  U4. Give up.\\
		PUSHJ	$0,LogU4 %%hide
		CMP	$0,fi,floor
		BNZ	$0,U6		Give up if $\.fi.\ne \.FLOOR.$.
		BNZ	d1,U4A		See exercise 7.\lineref|user7|
U6		PUSHJ	$0,Delete	\ut  U6. Get out.\\ 
		PUSHJ	$0,LogU6 %%hide
		PUSHJ	$0,Free		$\.AVAIL.\Leftarrow\.C.$. \lineref|2.2.5free|
		TRIP	Cycle,0		Continue simulation.
U5		PUSHJ	$0,Delete	\ut  U5. Get in.\\ Delete \.C. from \.QUEUE..
		PUSHJ	$0,LogU5 %%hide
		SET	$1,elevator
		PUSHJ	$0,Insert	Insert it at right of \.ELEVATOR..
		LDB	fo,c,OUT
		SL	$0,on,fo
		OR	callcar,callcar,$0	Set bit $\.CALLCAR[OUT(C)].\is 1$.
		BZ	state,1F
%%%
		TRIP	Cycle,0
%%%
1H		CMP	state,fo,floor 	$\.STATE.\is 1$, $0$, or $-1$.
		LDA	c,ELEV2		
		PUSHJ	$0,DeleteW	Remove E5 action from \.WAIT. list.
		TRIP	HoldCI,25
		JMP	E5		Restart E5 action 25 units from now.\quad\slug
%%%