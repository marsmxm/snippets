%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	2.3.2/diff.mms
%	Author:	M. Ruckert
%	Title:	Differentation routines

      	PREFIX	:D:			Part of subroutine D
%%%on
:Const	PUSHJ	q,:Allocate		 $\.Q. \is\hbox{``0''}$.
      	JMP 	D4
%%%
:Var	PUSHJ	q,:Allocate		$\.Q. \is\hbox{``0''}$.
	LDOU	t,p,:INFO
	CMP	t,t,x			Is $\.INFO(P).=\.x.$\hair?
	BNZ	t,D4			If not, it's a constant;
	SET	t,1			\quad else 	$\.Q. \is\hbox{``1''}$.
	STT	t,q,:INFO
	JMP	D4
%%%
:Ln	LDOU	t,q,:INFO
	BZ	t,D4			Return to control routine if $\.INFO(Q).= 0$.
	SET	q+1,q			
	SET	q+3,p1
	PUSHJ	q+2,:Copy		
	GETA    q+3,:Div		^{GETA+<GETA> (get address)}
	PUSHJ	q,:Tree2			$\.Q.\is \.Tree2(Q,Copy(P1),.\hbox{``$/$''}\.).$.
	JMP	D4	
%%%
:Neg	LDOU	t,q,:INFO
	BZ	t,D4			Return to control routine if $\.INFO(Q).= 0$.
	SET	q+1,q
	GETA    q+3,:Neg
	PUSHJ	q,:Tree1			$\.Q.\is \.Tree1(Q,.\cdot\.,.\hbox{``$-$''}\.).$.	
	JMP	D4	
%%%
:Add	LDOU	t,q1,:INFO
	PBNZ	t,1F			Jump unless $\.INFO(Q1).= 0$.
	SET	t+1,q1
	PUSHJ	t,:Free			$\.AVAIL.\Leftarrow \.Q1.$.
	JMP	D3
1H	LDOU	t,q,:INFO	
	PBNZ	t,1F			Jump unless $\.INFO(Q).= 0$.
2H	SET	t+1,q
	PUSHJ	t,:Free			$\.AVAIL.\Leftarrow \.Q.$.
	SET	q,q1			$\.Q.\is \.Q1.$.
	JMP	D3
1H	GETA    q+3,:Add
3H	SET	q+1,q1
	SET	q+2,q
	PUSHJ	q,:Tree2			$\.Q.\is \.Tree2(Q1,Q,.\hbox{``$+$''}\.).$.
	JMP	D3	
%%%
:Sub	LDOU	t,q,:INFO
	BZ	t,2B			If $\.INFO(Q).= 0$, then $-\.Q. = +\.Q.$.
	GETA    q+3,:Sub		Prepare for $\.Q.\is \.Tree2(Q1,Q,.\hbox{``$-$''}\.).$.
	LDOU	t,q1,:INFO	
	PBNZ	t,3B
	SET	t+1,q1
	PUSHJ	t,:Free			$\.AVAIL.\Leftarrow \.Q1.$.
	SET	q+1,q
	GETA    q+3,:Neg
	PUSHJ	q,:Tree1			$\.Q.\is \.Tree1(Q,.\cdot\.,.\hbox{``$-$''}\.).$.
	JMP	D3	
%%%
:Mul	LDOU	t,q1,:INFO		\pageref|2.3.2mul|
	BZ	t,1F			Jump if $\.INFO(Q1).= 0$.
	SET	t+1,q1
	SET	t+3,p2
	PUSHJ	t+2,:Copy
	PUSHJ	t,:Mult			
	SET	q1,t			$\.Q1.\is \.Mult(Q1,Copy(P2)).$.
1H	LDOU	t,q,:INFO	
	BZ	t,:Add			Jump if $\.INFO(Q).= 0$.
	SET	q+2,p1
	PUSHJ	q+1,:Copy
	SET	q+2,q
	PUSHJ	q,:Mult			$\.Q.\is \.Mult(Copy(P1),Q).$.
	JMP	:Add			\slug
%%%off

