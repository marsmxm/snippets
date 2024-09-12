%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	4.3.1/progb.mms
%	Author:	M. Ruckert
%	Title:	Exercise 8, Addition backwards from hi to lo.
	%	Solution to exercise 4.3.1--8
	%	Addition backwards from hi to lo.

	PREFIX	:Add:
u	IS	$0	Parameter.
v	IS	$1
w	IS	$2
n	IS	$3

j	IS	$4	Local variables.
i	IS	$5
wj	IS	$6
wi	IS	$6	wi and wj can share a register
t	IS	$7
%%%on
:Add	SL	j,n,3                    1 &\ut  B1.\\ $j \is n-1$.
	STCO	0,w,j			 1 &$w_n\is 0$.
	SUB	j,j,8			 1 &$j \is n-1$.
2H	LDOU	wj,u,j			 N &\ut  B2.\\
	LDOU	t,v,j; ADDU wj,wj,t	 N &$w_j\is u_j+v_j \mod b$.
	STOU	wj,w,j			 N &
	CMPU	t,wj,t			 N &\ut  B3.\\
	PBNN	t,4F			 N\bg{L} &
	SET	i,j			 L &$i\is j$.
0H	ADD	i,i,8			 K &$i\is i+1$.
	LDOU	wi,w,i			 K &$w_i\is w_i+1 \mod b$.
	ADDU	wi,wi,1			 K &
	STOU	wi,w,i			 K &
	BZ	wi,0B			 K\bg{K-L} &Repeat until $w_i+1<b$.
4H	SUB	j,j,8			 N &\ut  B4.\\ $j\is j-1$.
	PBNN	j,2B			 N\bg{1} &If $j\ge 0$, go back to B2.
%%%
	POP	0,0			      &\slug
%%%rt 4.3.1progb.rt & (8N+7K+L+5)\upsilon +(3N+2K+1)\mu
%%%off