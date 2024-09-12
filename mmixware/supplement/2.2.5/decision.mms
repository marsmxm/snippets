%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	2.2.5/decision.mms
%	Author:	M.Ruckert
%	Title:	Exercise 9, Decision routine
%%%on
		PREFIX	:Decision:
%%\mmsskip
next		IS	$0			&\.NEXTINST(ELEV1).
e1		IS	$1			&Zero if $\.next.=\.E1.$
calls		IS	$2			&All buttons combined
j		IS	$3			
c		IS	$4			&Local copy of \.:c.
rJ		IS	$5
t		IS	$6
%%\mmsskip
%%%
:Decision	BNZ	:state,9F		&\ut  D1. Decision necessary?\\
		LDOU	next,:ELEV1+:NEXTINST	&\ut  D2. Should doors open?\\
		GETA	t,:E1			&^{GETA+<GETA> (get address)}
		CMP	e1,next,t
		BNZ	e1,D3			&Jump if elevator not at E1.
		OR	calls,:callup,:calldown
		OR	calls,calls,:callcar
		GETA	next,:E3		&Prepare to schedule E3.
		AND	t,calls,1<<2
		BNZ	t,8F			&Jump if call set in 2.
D3		SL	t,:on,:floor		&\ut  D3. Any calls?\\
		ANDN	calls,calls,t		&Calls except in current floor
		SUB	t,calls,1
		SADD	j,t,calls		&Smallest $j$ with a call^{SADD+<SADD> (sideways add)}^{Sideways addition}
		BNZ	calls,D4		&Jump if calls with $j\ne\.FLOOR.$.
		GET	rJ,:rJ		
		GETA	t,:E6B
		CMPU	t,rJ,t			&Invoked by step E6?
		BNZ	t,9F			&If not, exit subroutine.
		SET	j,2
%%%
D4		CMP	:state,j,:floor		&\ut  D4. Set \.STATE..\\
		BNZ	e1,9F			&\ut  D5. Elevator dormant?\\ 
		BZ	:state,9F		&Exit if $j=2$.
		GETA	next,:E6		&Prepare to schedule E6.
%%%
8H		SET	c,:c			&Save current thread.
		LDA	:c,:ELEV1		&Disguise as \.ELEV1..
		STOU	next,:c,:NEXTINST	&Set \.NEXTINST. to E3 or E6.
		SET	:dt,20			&Wait 20 units of time.
		GET	rJ,:rJ
		PUSHJ	t,:Hold			&Schedule the activity.
		PUT	:rJ,rJ
		SET	:c,c			&Restore current thread.
%%%
9H		POP	0,0			&\slug
%%%off