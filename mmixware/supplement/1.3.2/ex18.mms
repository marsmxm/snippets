%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	1.3.2/ex21.mms
%	Author:	M.Ruckert
%	Title:	Exercise 18, Farey series
	PREFIX	:Farey:
%%%on
x	IS	$0	
y	IS	$1	&$\smash{\left.\vcenter to 33pt{\vfil}\right\}}$\quad Parameter
n	IS	$2
k	IS	$3	$k$ scaled by 4
xn	IS	$4	$x_{k+1}$
yn	IS	$5	$y_{k+1}$
xk	IS	$6	$x_k$
yk	IS	$7	$y_k$
xp	IS	$8	$x_{k-1}$
yp	IS	$9	$y_{k-1}$
f	IS	$10	$\lfloor (y_{k-1}+n)/y_k\rfloor$
t	IS	$11
%%\mmsskip
:Farey	SET	k,4		$k\is 1$.
	SET	xp,0		$x_{k-1}\is 0$.
	SET	yp,1		$y_{k-1}\is 1$.
	STT	xp,x,0		Store $x_{k-1}$.
	STT	yp,y,0		Store $y_{k-1}$.
	SET	xk,1		$x_k\is 1$.
	SET	yk,n		$y_k\is n$.
	JMP	1F
%%\mmsskip
Loop	ADD	t,yp,n
	DIV	f,t,yk		$\.f.\is \lfloor (y_{k-1}+n)/y_k\rfloor$.
	MUL	t,f,xk	
	SUB	xn,t,xp		$x_{k+1}\is \.f.\cdot x_k-x_{k-1}$.
	MUL	t,f,yk
	SUB	yn,t,yp		$y_{k+1}\is \.f.\cdot y_k-y_{k-1}$.
	ADD	k,k,4		Advance $k$.
	SET	xp,xk		Advance \.xp..
	SET	xk,xn		Advance \.xk..
	SET	yp,yk		Advance \.yp..
	SET	yk,yn		Advance \.yk..
1H	STT	xk,x,k		Store $x_{k}$.
	STT	yk,y,k		Store $y_{k}$.
	CMP	t,xk,yk		Test if  $x_k<y_k$.
	PBN	t,Loop		If so, continue.
%%\mmsskip
	POP	0,0		Exit from subroutine.\quad\slug
%%%off