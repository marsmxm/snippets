%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	4.3.1/progac.mms
%	Author:	M. Ruckert
%	Title:	Exercise 3, Addition in columns
%		Solution to exercise 4.3.1--3
%		Addition in columns

	PREFIX	:Classic:
%%%
u0	IS	$0	Parameter.
m	IS	$1
w	IS	$2
n	IS	$3

i	IS	$4	Local variables.
u	IS	$5
j	IS	$6
k	IS	$7
wj	IS	$8
t	IS	$9
%%%on
:AddC	8ADDU	w,n,w				1 &
	SL	j,n,3; NEG j,j    		1 &$j \is 0$.
	SET	k,0   	   	  		1 &$k \is 0$.
	JMP	4F				1 &
%%%
1H	8ADDU	u,n,u0				N & $i\is 0$.
	LDOU	t,u,j; ADDU wj,k,t		N &$w_j\is u_{0j}+k$.
	ZSZ 	k,wj,k				N &Carry?
	SET	i,m				N &
	JMP	3F				N &
2H	LDOU	t,u,j; ADDU wj,wj,t		N(M-1) &$w_j\is w_j+u_{ij}$.
	CMPU	t,wj,t; ZSN t,t,1		N(M-1) &Carry?
	ADD	k,k,t				N(M-1) &
3H	8ADDU	u,n,u				NM &Advance $i$.
	SUB	i,i,1				NM &	
	PBP	i,2B				NM\bg{N} &Loop on $i$.
	STOU	wj,w,j				N &
	ADD	j,j,8				N &$j\is j+1$.
4H	PBN	j,1B				N+1\bg{1} &Loop on $j$.
	STOU	k,w,j				1 &$w_n\is k$.
%%%
	POP	0,0				&\slug
%%%rt 4.3.1progac.rt & (8NM+6N+9)\upsilon + (NM+N+1)\mu
%%%off