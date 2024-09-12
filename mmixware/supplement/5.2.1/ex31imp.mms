%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	5.2.1/ex31imp.mms
%	Author:	M.Ruckert, 27.4.2012
%	Title:	Exercise 31, Pratt's Sorting method with different setting of m
%		5.2.1 exercise 31
%		improved setting m lower
%

	PREFIX	:Sort:

%%%
R	IS	$0	& Parameter
n	IS	$1
H	IS	$2
t	IS	$3
s	IS	$4	& Local variables
j	IS	$5	
i	IS	$6
Kj	IS	$7
Ki	IS	$8
Rh	IS	$9
Rn	IS	$10
d	IS	$11
h	IS	$12
m	IS	$13
c	IS	$14	

:Sort	SL	n,n,3		1 & $N \is \hbox{\rm size in bytes}$.
	ADD	Rn,R,n		1 & Address of $R_N$.
	SL	s,t,3		1 & \ut D1. Loop on $s$.\\
	JMP	1F		1 &
2H	LDO	h,H,s		T & \ut D2. Loop on $j$.\\
	SL	h,h,3		T &
	SUB	Rh,Rn,h		T &  $\.Rh. \is \mathop{\hbox{Address~of}} R_{N-h}$.
	SET	m,h
%%%on
	SL	c,m,1; CMP	c,c,n;	BNP	c,0F;	SUB	m,n,h
%%%off
	JMP	0F		T & 
%%%
3H	LDO	Kj,Rn,j		NT-S-B+A & Load and compare $K_j : K_{j-h}$.
	LDO	Ki,Rh,j		NT-S-B+A & 
	CMP	c,Kj,Ki	NT-S-B+A & 	
	PBNN	c,7F		NT-S-B+A+2B &	If $K_j \ge K_{j-h}$ jump to increment $j$.
	STO	Ki,Rn,j		B &	Exchange $K_j$ and $K_{j-h}$.
	STO	Kj,Rh,j		B &
	ADD	j,j,h		B & Increment $j$.
7H	ADD	j,j,h		NT-S-B+A & Increment $j$.
	PBN	j,3B
0H	SUB	m,m,8		S &
	SUB	j,m,n		S & $j \is m$.
	PBNN	m,7B
%%%
1H	SUB	s,s,8		T+1 & Decrement $s$.
	PBNN	s,2B		T+3 & $0\le s < t$
	POP	0,0		    &\slug
%%%
	PREFIX	:
