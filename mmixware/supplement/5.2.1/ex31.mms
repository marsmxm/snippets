%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	5.2.1/ex31.mms
%	Author:	M.Ruckert, 27.4.2012
%	Title:	Exercise 31, Pratt's Sorting method

	PREFIX	:Sort:

key	IS	$0		Parameter
keyn	IS	key
n	IS	$1	scaled
inc	IS	$2	
t	IS	$3	
s	IS	$4	scaled by 8	Local variables
j	IS	$5	scaled by 8 minus N
i	IS	$6
k	IS	$7	
kh	IS	$8	
keyh	IS	$9	

d	IS	$11
h	IS	$12	scaled by 8
m	IS	$13	scaled by 8
c	IS	$14
%%%on
:Sort	8ADDU	keyn,n,key	1 & $\.keyn.\is \.LOC($K_{N+1}$).$.
	SL	n,n,3		1 & Scale $N$.
	SL	s,t,3		1 & $s\is t-1$.
	JMP	1F		1 &
2H	LDO	h,inc,s		T & 
	SL	h,h,3		T & Scale $h$.
	SUB	keyh,keyn,h	T &  $\.keyh.\is \.LOC($K_{h+1}$).$.
	SET	m,h		T & \ut  Loop on $m$.\\
	JMP	0F		T & \lineref|5.2.1-ex31-insert|
%%%
3H	LDO	k,keyn,j		NT-S-B+A &\subfoolit{j}\ut  Load and compare $K$\setfool${} : K$\setfool${}_{{}-h}$.\\
	LDO	kh,keyh,j		NT-S-B+A & 
	CMP	c,k,kh		NT-S-B+A & 	
	PBNN	c,7F		NT-S-B+A\bg{B} & Jump if $K_j \ge K_{j-h}$.
	STO	kh,keyn,j		B &	\subfoolit{j}\ut  Exchange $K$\setfool and $K$\setfool${}_{{}-h}$.\\
	STO	k,keyh,j		B &
	ADD	j,j,h		B & Increment $j$.
7H	ADD	j,j,h		NT-B+A & Increment $j$.\lineref|5.2.1-ex31-loop|
	PBN	j,3B		NT-B+A\bg{S} & $m < j+N < N $.
0H	SUB	m,m,8		T+S & Decrement $m$.
	SUB	j,m,n		T+S & $j\is n$.
	PBNN	m,7B		T+S\bg{T} & $0\le m < h$.\lineref|5.2.1-ex31-loopend|
%%%
1H	SUB	s,s,8		T+1 &  \ut  Loop on $s$.\\
	PBNN	s,2B		T+1\bg{1} & $0\le s < t$.\quad\slug
%%%rt 5.2.1ex31.rt    & (6NT+6A-B+S+12T+8)\upsilon + (2NT+2A+T-2S)\mu
%%%off
	POP	0,0
	PREFIX	:
%%%on