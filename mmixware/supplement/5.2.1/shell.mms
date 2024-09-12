%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	5.2.1/shell.mms
%	Author:	M. Ruckert, 27.4.2012
%		see also solution of Author: Blake Hegerle 
%	Title:	Program D, Shellsort
%		5.2.1 Page 85

	PREFIX	:Sort:

key	IS	$0	 Parameter
n	IS	$1	
inc	IS	$2
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
%%%on
:Sort	8ADDU	keyn,n,key		 1 & $\.keyn.\is \.LOC($K_{N+1}$).$.
	SL	s,t,3		 1 & $s\is t-1$.
	JMP	D1		 1 & 
D2	LDO	h,inc,s		 T & \foolit{j}\ut  D2. Loop on \setfool.\\ $h\is h_s$.
	SL	h,h,3		 T & 
	ADDU	keyh,key,h	 T & $\.keyh.\is \.LOC($K_{h+1}$).$.
	SUBU	d,keyn,keyh	 T & $\.d.\is N-h$.
	SUBU	j,keyh,keyn	 T &  $j\is h+1 $.
	JMP	0F		 T & 
D3	ADD	i,d,j		 NT-S &\foolit{j}  \ut  D3. Set up  \setfool, $K$, $R$.\\ $i\is j-h$.\lineref|5.2.1-shell-d|
	LDO	k,keyn,j		 NT-S &
D4	LDO	ki,key,i		 B+NT-S-A & \ut  D4. Compare $K : K_i$.\\\lineref|5.1.2-shell-d4|
	CMP	c,k,ki	 	 B+NT-S-A &
	BNN	c,D6		 B+NT-S-A\bg{NT-S-A}\hidewidth&\qquad\qquad To D6 if $K\ge K_i$.
	STO	ki,keyh,i		 B &\ut  D5. Move $R_i$, decrease $i$.\\
	SUB	i,i,h		 B &$i\is i-h$.
	PBNN	i,D4		 B\bg{A} & To D4 if $i\ge 0$.
D6	STO	k,keyh,i		 NT-S & \ut  D6. $R$ into $R_{i+1}$.\\
	ADD	j,j,8		 NT-S & $j\is j+1$.
0H	PBN	j,D3		 NT-S+T\bg{T} & To D3 if $j < N$.\lineref|5.1.2-shell-end|
D1	SUB	s,s,8		 T+1 & \ut  D1. Loop on $s$.\\
	PBNN	s,D2		 T+1\bg{1} & $0\le s < t$.\quad\slug
%%%rt 5.2.1shell.rt & (6B+10NT+11T-10S-3A+7)\upsilon + (2B+3NT+T-3S-A)\mu
%%%off

	POP	0,0

	PREFIX	:
%%%on