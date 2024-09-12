%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	2.2.5/elevator.mms
%	Author:	M.Ruckert
%	Title:	Coroutine E
%%%on
%%%		Coroutine E
%%%on
E1A		PUSHJ	$0,:LogE1		%%hide
		TRIP	Cycle1,0		%%hide
%% &E1A		&TRIP	&Cycle1,0	& &Set $\.NEXTINST.\is \.E1.$, go to \.Cycle..\cr
E1		IS	@		\ut  E1. Wait for call.\\ (no action)
E2A		TRIP	HoldC,0		Decelerate.
E2		OR	$0,callup,calldown	\ut  E2. Change of state?\\
		OR	$0,$0,callcar	
		PUSHJ	$1,:LogE2		%%hide
		BN	state,1F	Jump if going down.
		ADD	$1,floor,1	State is \.GOINGUP..
		SR	$2,$0,$1
		BNZ	$2,E3		Are there calls for higher floors?
		NEG	$1,64,floor	If not, have passengers in the
		SL	$2,callcar,$1	\quad elevator called for lower floors?
		JMP	2F
%%%
1H		NEG	$1,64,floor	State is \.GOINGDOWN..
		SL	$2,$0,$1
		BNZ	$2,E3		Are there calls for lower floors?
		ADD	$1,floor,1	If not, have passengers in the
		SR	$2,callcar,$1	\quad elevator called for upper floors?
%%%
2H		NEG	state,state	Reverse direction of \.STATE..
		CSZ	state,$2,0	$\.STATE. \is \.NEUTRAL.$ or reversed.
		SL	$0,on,floor
		ANDN	callup,callup,$0	Set all \.CALL. bits to zero.
		ANDN	calldown,calldown,$0
		ANDN	callcar,callcar,$0 
%%%
E3		LDA	c,ELEV3		\ut  E3. Open doors.\\
		PUSHJ	$0,:LogE3		%%hide
		LDO	$0,c,LLINK1	\lineref|NullLLINK|
		BZ	$0,1F		If activity E9 is already scheduled,
		PUSHJ	$0,DeleteW	\quad remove it from the \.WAIT. list.
1H		SET	dt,300
		PUSHJ	$0,Hold		Schedule activity E9 after 300 units.
		LDA	c,ELEV2		
		SET	dt,76
		PUSHJ	$0,Hold		Schedule activity E5 after 76 units.^{Simulation}
		SET	d2,on
		SET	d1,on
		SET	dt,20
E4A		LDA	c,ELEV1
		TRIP	HoldC,0
E4		LDA	$0,elevator		\ut  E4. Let people out, in.\\
		LDA	c,elevator		$\.C.\is \.LOC(ELEVATOR).$.
1H		LDOU	c,c,LLINK2		$\.C.\is \.LLINK2(C).$.\lineref|E4Loop|
		CMP	$1,c,$0			Search \.ELEVATOR. list, right to left.
		BZ	$1,1F			If $\.C.=\.LOC(ELEVATOR).$, search is complete.
		LDB	$1,c,OUT	
		CMP	$1,$1,floor	Compare \.OUT(C). with \.FLOOR..
		BNZ	$1,1B		If not equal, continue searching;\lineref|E4LoopEnd|
		GETA	$0,U6		\quad otherwise, send user to U6.^{GETA+<GETA> (get address)}
		JMP	2F
%%%
1H		16ADDU	$0,floor,queue
		LDOU	c,$0,RLINK2	Set $\.C.\is \.RLINK2(LOC(QUEUE[FLOOR])).$.
		LDOU	$1,c,RLINK2
		CMP	$1,$1,c		Is $\.C.=\.RLINK2(C).$?
		BZ	$1,1F		If so, the queue is empty.
		PUSHJ	$0,DeleteW	If not, cancel action U4 for this user.\lineref|CancelU4|
		GETA	$0,U5		Prepare to replace U4 by U5.
2H		STOU	$0,c,NEXTINST	Set \.NEXTINST(C)..
		PUSHJ	$0,Immed	Put user at the front of the \.WAIT. list.
		SET	dt,25		
		JMP	E4A		Wait 25 units and repeat E4.
1H		SET	d1,off
		SET	d3,on
		PUSHJ	$1,:LogE4		%%hide
		TRIP	Cycle,0		Return to simulate other events.
%%%
E5		BZ	d1,0F	\ut  E5. Close doors.\\
		PUSHJ	$0,:LogE5f		%%hide
		TRIP	HoldCI,40		If people are still getting in or out,
		JMP	E5			\quad wait 40 units and repeat E5.
0H		SET	d3,off			If not loading, stop waiting.
		PUSHJ	$0,:LogE5		%%hide
		LDA	c,ELEV1
		TRIP	HoldCI,20		Wait 20 units, then go to E6.
%%%
E6		SL	$0,on,floor	     \ut  E6. Prepare to move.\\
		ANDN	callcar,callcar,$0   Reset \.CALLCAR. on this floor.
		ZSNN	$1,state,$0	     If not going down, 
		ANDN	callup,callup,$1     \quad reset \.CALLUP. on this floor.
		ZSNP	$1,state,$0	     If not going up,
		ANDN	calldown,calldown,$1 \quad reset \.CALLDOWN. on this floor.
		PUSHJ	$0,Decision	     
E6B		BZ	state,E1A		If $\.STATE.=\.NEUTRAL.$, go to E1 and wait.
		BZ	d2,0F
		PUSHJ	$1,:LogE6		%%hide
		LDA	c,ELEV3		If busy,
		PUSHJ	$0,DeleteW	\quad cancel activity E9
		STCO	0,c,LLINK1	\quad (see line |NullLLINK|).^{STCO+<STCO> (store constant octabyte)}
0H		LDA	c,ELEV1
		TRIP	HoldCI,15	Wait 15 units of time.
		BN	state,E8	If $\.STATE.=\.GOINGDOWN.$, go to E8.
E7		PUSHJ	$0,LogE7 %%hide
		ADD	floor,floor,1 %%hide	
%% &E7		&ADD	&floor,floor,1	&&\ut  E7. Go up a floor.\\\cr
		TRIP	HoldCI,51		Wait 51 units.
		SL	$0,on,floor
		OR	$1,callcar,callup
		AND	$2,$1,$0	Is $\.CALLCAR[FLOOR]. \ne0$
		BNZ	$2,1F		\quad or $\.CALLUP[FLOOR].\ne0$?
		CMP	$2,floor,2	
		BZ	$2,2F		If not, is $\.FLOOR.=2$?
		AND	$2,calldown,$0 	If not, is $\.CALLDOWN[FLOOR].\ne0$?
		BZ	$2,E7		If not, repeat step E7.
2H		OR	$1,$1,calldown
		ADD	$2,floor,1
		SR	$1,$1,$2
		BNZ	$1,E7		Are there calls for higher floors?
1H		SET	dt,14		It is time to stop the elevator.
		JMP	E2A		Wait 14 units and go to E2.\lineref|beforeex8|
%%\mmsskip
%%\omit&&\mmsvdots&&&(See exercise 8.)\cr
%%\mmsskip
%%%off
[[INCLUDE exercise8.mms]]
%%%on	
%%\noalign{\lastmmsline{|lastex8|}}
%%%
E9		STCO	0,c,LLINK1	\ut  E9. Set inaction indicator.\\ (See line |NullLLINK|.)^{STCO+<STCO> (store constant octabyte)}
		SET	d2,off		
		PUSHJ	$0,Decision
		TRIP	Cycle,0		Return to simulation of other events.\quad\slug
%%%off

