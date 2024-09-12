%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	5.2.1/ex10.mms
%	Author:	Martin Ruckert, 27.4.2012
%		see also solution of Author: Blake Hegerle 
%	Title:	Exercise 10, Optimized Shell Sort

	PREFIX	:Sort:

key	IS	$0	  Parameter
n	IS	$1	
H	IS	$2	
t	IS	$3	

s	IS	$4	& Local variables
j	IS	$5	
i	IS	$6
k	IS	$7	
ki	IS	$8	
keyh	IS	$9	
keyn	IS	$10	
d	IS	$11	
h	IS	$12
c	IS	$13	
%%%rton
:Sort	8ADDU	keyn,n,key		1 & Address of $R_n$.
	SL	s,t,3		1 &
	JMP	D1		1 &
D2	LDO	h,H,s		T & \ut  D2. Loop on $j$.\\
	SL	h,h,3		T &
	ADD	keyh,key,h		T & 
	SUBU	d,keyn,keyh		T & 
	SUBU	j,keyh,keyn		T &  $j\is h+1 $.
	JMP	0F		T & 
D3	ADD	i,d,j		NT-S & \ut  D3. Set up  $j$, $K$, $R$.\\ $i\is j-h$.
	LDO	k,keyn,j		NT-S &
%%%on
	LDO	ki,key,i		NT-S &  \ut  D4. Compare $K : K_i$.\\
	CMP	c,k,ki		NT-S & 	
	BNN	c,7F		NT-S\bg{C} &	If $K_j \ge K_{j-h}$, jump to increment $j$.
D5	STO	ki,keyh,i		B & \ut  D5. Move $R_i$, decrease $i$.\\
	SUB	i,i,h		B & $i\is i-h$.
	BN	i,D6		B\bg{A} & To D6 if     $i < 0$.
	LDO	ki,key,i		B-A & \ut  D4. Compare $K : K_i$.\\
	CMP	c,k,ki		B-A &
	PBN	c,D5		B-A\bg{NT-S-C-A}& To D5 if $K<K_i$.
D6	STO	k,keyh,i		NT-S-C & \ut  D6. $R$ into $R_{i+1}$.\\
7H	ADD	j,j,8		NT-S & $j\is j+1$.
0H	PBN	j,D3		NT-S+T\bg{T} &To D3 if  $j < N$.\quad\slug
%%%off
%%%rton
D1	SUB	s,s,8		T+1 &  \ut  D1. Loop on $s$.\\
	PBNN	s,D2		T+1\bg{1} & $0\le s < t$
%%%rtoff

	POP	0,0

	PREFIX	:
%%%on