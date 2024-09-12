%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	5.2.1/insert3.mms
%	Author:	M.Ruckert, 26.3.2012
%	Title:	Program S, Straight Insertion Sort
%		5.2.1 Page 81
%%%
key	IS	$0		Parameter 
n	IS	$1	
j	IS	$2		Local variables
i	IS	$3
k	IS	$4	
ki	IS	$5	
key1	IS	$6	
keyn	IS	$7	
d	IS	$8	
c	IS	$9	
%%%on
:Sort	ADD	key1,key,8		 1 &\pageref|5.2.1s|
	8ADDU	keyn,n,key		 1 & 
	SUBU	d,keyn,key1		 1 & 
	SUBU	j,key1,keyn		 1 &  $j\is 1$.
	JMP	S1		 1 & 
%%%
S2	LDO	k,keyn,j		 N-1 &\foolit{j}\ut  S2. Set up  \setfool, $K$, $R$.\\
	ADD	i,d,j		 N-1 & $i\is j-1$.
S3	LDO	ki,key,i		 N-1+B-A & \ut  S3. Compare $K : K_i$.\\
	CMP	c,k,ki	 	 N-1+B-A &
	BNN	c,S5		 N-1+B-A\bg{N-1-A} & To S5 if $K\ge K_i$. \lineref|5.2.1-insert-opt|
	STO	ki,key1,i		 B &\ut  S4. Move $R_i$, decrease $i$.\\
	SUB	i,i,8		 B &$i\is i-1$.
	PBNN	i,S3		 B\bg{A} & To S3 if $i\ge 0$.
S5	STO	k,key1,i		 N-1 & \ut  S5. $R$ into $R_{i+1}$.\\
%%%
	ADD	j,j,8		 N-1 & $j\is j+1$.
S1	PBN	j,S2		 N\bg{1} &\foolit{j}\ut  S1. Loop on \setfool.\\  $1\le j < N$.
%%%	
	POP	0,0			&\slug
%%%rt 5.2.1insert3.rt &  (10N-3A +6B-2)\upsilon+ (3N-1A+2B-3)\mu
%%%off