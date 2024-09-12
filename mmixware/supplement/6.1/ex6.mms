%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	6.1/ex6.mms
%	Author:	M.Ruckert
%	Title:	Exercise 6, Program Q' with loop unrolling
%%%
key	IS	$0		Parameter
n	IS	$1
k	IS	$2
i	IS	$3	        Local variables.
ki	IS	$4
key1	IS	$5
key2	IS	$6
t	IS	$7
%%%on
:Search   SL	i,n,3		1 &	\ut  Q1. Initialize.\\
	NEG	i,i		1 &	$\.i.\is -8N$, $i\is 1$.
	SUBU	key,key,i	1 &	$\.key.+\.i.\is \.LOC($K_{N+1}$).$.
	ADDU	key1,key,8	1 &	$\.key1.+\.i.\is \.LOC($K_{N+2}$).$.
	ADDU	key2,key1,8	1 &	$\.key2.+\.i.\is \.LOC($K_{N+3}$).$.
	STO	k,key,0		1 &	$K_N\is K$.
	JMP	Q2		1 &
%%%
Q3	ADD	i,i,24		\lfloor(C-S)/3\rfloor  &	\ut  Q3. Advance.\\ (3 times)
Q2	LDO	ki,key,i		\lfloor(C-S)/3\rfloor+1  &	\ut  Q2. Compare.\\
	CMP	t,k,ki		\lfloor(C-S)/3\rfloor+1  &
	BZ	t,Q4		\lfloor(C-S)/3\rfloor+1\bg{1-F} & To Q4	if $K=K_i$.
%%%
	LDO	ki,key1,i		\lfloor(C-S)/3\rfloor+F&	\ut  Q2. Compare.\\
	CMP	t,k,ki		\lfloor(C-S)/3\rfloor+F&
	BZ	t,0F		\lfloor(C-S)/3\rfloor+F\bg{F-G}&  To Q4	if $K=K_{i+1}$.
%%%
	LDO	ki,key2,i		\lfloor(C-S)/3\rfloor+G &	\ut  Q2. Compare.\\
	CMP	t,k,ki		\lfloor(C-S)/3\rfloor+G &
	PBNZ	t,Q3		\lfloor(C-S)/3\rfloor+G\bg{G}  & To Q3 if $K\ne K_{i+2}$.
	ADD	i,i,8		G &
%%%
0H	ADD	i,i,8		F &
%%%
Q4	PBN	i,Success	1\bg{1-S} & \ut  Q4. End of file?\\
	POP	0,0			&	Exit if not in table.
Success	ADDU	$0,key,i		S &	Return \.LOC($K_i$)..
	POP	1,0		  & \slug
%%%rt 6.1ex6.rt & (10\lfloor (C-S)/3\rfloor -S+4F+4G+15)\upsilon +(3\lfloor (C-S)/3\rfloor+F+G+2)\mu
%%%off

