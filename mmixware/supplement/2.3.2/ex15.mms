%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	2.3.2/ex15.mms
%	Author:	M.Ruckert
%	Title:	Exercise 15, Differentiation of division
%%%on
	PREFIX	:D:		This is part of subroutine D.
%%%
:Div	LDOU	t,q1,:INFO
	BZ	t,1F
	SET	t+1,q1
 	SET	t+3,p2
	PUSHJ	t+2,:Copy
	GETA    t+3,:Div	^{GETA+<GETA> (get address)}	
	PUSHJ	t,:Tree2
	SET	q1,t		$\.Q1.\is \.Tree2(Q1,Copy(P2),.\hbox{``$/$''}\.).$.
1H	LDOU	t,q,:INFO	
	BZ	t,:Sub
%%%
	SET	q+3,p1
	PUSHJ	q+2,:Copy
	SET	q+3,q
	PUSHJ	q+1,:Mult	$\.Q+1.\is \.Mult(Copy(P1),Q).$.
%%%
	SET	q+4,p2
	PUSHJ	q+3,:Copy
	PUSHJ	q+4,:Allocate
	SET	q+5,2		
	STTU	q+5,q+4,:INFO
	GETA    q+5,:Pwr	
	PUSHJ	q+2,:Tree2	$\.Q+2.\is \.Tree2(Copy(P2),Allocate(),.\hbox{``$\uparrow$''}\.).$.
	GETA    q+3,:Div	
	PUSHJ	q,:Tree2		$\.Q.\is \.Tree2(Q+1,Q+2,.\hbox{``$/$''}\.).$.
	JMP	:Sub		$\.Q.\is \.Q1. - \.Q.$.\quad\slug
%%%off
