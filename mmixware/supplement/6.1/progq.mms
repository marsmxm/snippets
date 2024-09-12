%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	6.1/progq.mms
%	Author:	M.Ruckert
%	Title:	Program Q, Quick sequential search
%%%
key	IS	$0		Parameter
n	IS	$1	
k	IS	$2	
i	IS	$3	scaled		Local variables.
ki	IS	$4	
t	IS	$5	
%%%on
:Search  SL	i,n,3		1 &	\ut  Q1. Initialize.\\
	NEG	i,i		1 &		$\.i.\is -8N$, $i\is 1$.
	SUBU	key,key,i	1 &		$\.key.\is \.LOC($K_{N+1}$).$.
	STO	k,key,0		1 &	$K_{N+1}\is K$.
	JMP	Q2		1 &
Q3	ADD	i,i,8		C-S &	\ut  Q3. Advance.\\
Q2	LDO	ki,key,i		C-S+1 &	\ut  Q2. Compare.\\
	CMP	t,k,ki		C-S+1 &
	PBNZ	t,Q3		C-S+1\bg{1} &	To Q3 if $K\ne K_i$.
	PBN	i,Success	1\bg{1-S} & \ut  Q4. End of file?\\
	POP	0,0			&	Exit if not in table.
Success	ADDU	$0,key,i		S &	Return \.LOC($K_i$)..
	POP	1,0		  &	\slug
%%%rt 6.1progq.rt & (4C-5S+13)\upsilon+(C-S+2)\mu
%%%off
