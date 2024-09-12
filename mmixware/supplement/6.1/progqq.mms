%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	6.1/progqq.mms
%	Author:	M.Ruckert
%	Title:	Program Q', Quicker sequential search
%%%
key	IS	$0			Parameter
n	IS	$1	
k	IS	$2	
i	IS	$3	scaled		Local variables.
ki	IS	$4	
key1	IS	$5	
t	IS	$6	
%%%on
:Search   SL	i,n,3		1 &	\ut  Q1. Initialize.\\
	NEG	i,i		1 &		$\.i.\is -8N$, $i\is 1$.
	SUBU	key,key,i	1 &		$\.key.\is \.LOC($K_{N+1}$).$.
	ADDU	key1,key,8		1 &	$\.key1.+\.i.\is \.LOC($K_{N+2}$).$.
	STO	k,key,0		1 &	$K_{N+1}\is K$.
	JMP	Q2		1 &
%%%
Q3	ADD	i,i,16		\lfloor (C-S)/2\rfloor  &	\ut  Q3. Advance.\\ (twice)
Q2	LDO	ki,key,i		\lfloor (C-S)/2\rfloor +1  &	\ut  Q2. Compare.\\
	CMP	t,k,ki		\lfloor (C-S)/2\rfloor +1  &
	BZ	t,Q4		\lfloor (C-S)/2\rfloor +1\bg{1-F} & To Q4 if $K=K_i$.
%%%
	LDO	ki,key1,i		\lfloor (C-S)/2\rfloor +F &	\ut  Q2. Compare.\\
	CMP	t,k,ki		\lfloor (C-S)/2\rfloor +F &
	PBNZ	t,Q3		\lfloor (C-S)/2\rfloor +F\bg{F}  & To Q3 if $K\ne K_i$.
	ADD	i,i,8		F &
%%%
Q4	PBN	i,Success	1\bg{1-S} & \ut  Q4. End of file?\\
	POP	0,0			&	Exit if not in table.
Success	ADDU	$0,key,i		S &	Return \.LOC($K_i$)..
	POP	1,0		  & \slug
%%%off
