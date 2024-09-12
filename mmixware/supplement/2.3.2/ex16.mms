%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	2.3.2/ex16.mms
%	Author:	M.Ruckert
%	Title:	Exercise 16, Differentiation of Power
	PREFIX	:D:		This is part of subroutine D
%%%on
r	IS	t+1	
:Pwr	LDOU	t,q1,:INFO
	BZ	t,2F		Jump if $\.INFO(Q1).=0$.
	SET	r+1,p1
	PUSHJ	r,:Copy		$\.R.\is\.Copy(P1).$.
	LDWU	diff,p2,:DIFF
	BNZ	diff,1F		Jump if $\.DIFF(P2). \ne 0$.
%%%				
	LDT	info,p2,:INFO	Load value of constant \.P2..
	CMP	t,info,2	Is it 2?
	BZ	t,3F		If yes, jump.
%%%
	SET	r+1,r		1) \.R.
	PUSHJ	r+2,:Allocate	2) New constant
	SUB	info,info,1	   \qquad with value $\.INFO(P2).-1$
	STT	info,r+2,:INFO
	GETA	r+3,:Pwr		3) ``$\uparrow$''^{GETA+<GETA> (get address)}
	PUSHJ	r,:Tree2		$\.R.\is \.Tree2(R,INFO(P2).-1\.,.\hbox{``$\uparrow$''}\.).$.
	JMP	3F
%%%				$\.DIFF(P2). \ne 0$
1H	SET	r+1,r		1) \.R.
	SET	r+4,p2		\qquad \qquad $\alpha$) \.P2.
	PUSHJ	r+3,:Copy	\qquad a) \.Copy(P2).
	PUSHJ	r+4,:Allocate	\qquad b) New constant 
	SET	info,1		\qquad\qquad with value 1
	STT	info,r+4,:INFO
	GETA    r+5,:Sub	\qquad c) ``$-$''
	PUSHJ	r+2,:Tree2	2) \.Tree2(Copy(P2),1,.``$-$''\.).
	GETA	r+3,:Pwr		3) ``$\uparrow$''
	PUSHJ	r,:Tree2		$\.R.\is \.Tree2(R,Tree2(Copy(P2),1,.\hbox{``$-$''}\.),.\hbox{``$\uparrow$''}\.).$
%%%
3H	SET	r+1,q1		1) \.Q1.
	SET	r+4,p2		\qquad \qquad $\alpha$) \.P2.
	PUSHJ	r+3,:Copy	\qquad a) \.Copy(P2).
	SET	r+4,r		\qquad b) \.R.
	PUSHJ	r+2,:Mult	2) \.Mult(Copy(P2),R).
%%%
	PUSHJ	r,:Mult		$\.R.\is \.Mult(Q1,Mult(Copy(P2),R)).$.
	SET	q1,r		$\.Q1.\is\.Mult(Q1,Mult(Copy(P2),R)).$.	
%%%	
2H	LDOU	t,q,:INFO	
	BZ	t,:Add		If $\.INFO(Q).=0$ go to \.Add..
%%%
	SET	q+4,p1		\qquad \qquad \qquad i) \.P1.
	PUSHJ	q+3,:Copy	\qquad \qquad $\alpha$) \.Copy(P1).
	GETA	q+5,:Ln		\qquad \qquad $\beta$) ignored, $\gamma$) ``$\ln$''
	PUSHJ	q+2,:Tree1	\qquad a) \.Tree1(Copy(P1),.$\cdot$\.,.\hbox{``$\ln$''}\.).
	SET	q+3,q		\qquad b) \.Q.
	PUSHJ	q+1,:Mult	1) \.Mult(Tree1(Copy(P1),.$\cdot$\.,.``$\ln$''\.),Q).
%%%
	SET	q+4,p1		\qquad \qquad $\alpha$) \.P1.
	PUSHJ	q+3,:Copy	\qquad a) \.Copy(P1).
	SET	q+5,p2		\qquad \qquad $\alpha$) \.P2.
	PUSHJ	q+4,:Copy	\qquad b) \.Copy(P2).
	GETA	q+5,:Pwr		\qquad c) ``$\uparrow$''
	PUSHJ	q+2,:Tree2	2) \.Tree2(Copy(P1),Copy(P2),.\hbox{``$\uparrow$''}\.).
%%%
	GETA    q+3,:Mul		3) ``$\times$''
	PUSHJ	q,:Tree2		$\.Q.\is \.Tree2(Mult(Tree1(Copy(P1),.\cdot\.,.\hbox{``$\ln$''}\.),Q),.$
	JMP	:Add		\hfill \.Tree2(Copy(P1),Copy(P2),.``$\uparrow$''\.),.``$\times$''\.)..\quad\slug
%%%off
