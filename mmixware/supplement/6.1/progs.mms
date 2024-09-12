%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	6.1/progs.mms
%	Author:	M.Ruckert
%	Title:	Program S, Sequential search
%%%
key	IS	$0		Parameter
n	IS	$1		
k	IS	$2		
i	IS	$3		scaled	Local variables.
ki	IS	$4		
t	IS	$5		
%%%on
:Search  SL	i,n,3		1 &		\ut  S1. Initialize.\\
	NEG	i,i		1 &		$\.i.\is -8N$, $i\is 1$.
	SUBU	key,key,i	1 &		$\.key.\is \.LOC($K_{N+1}$).$.
S2	LDO	ki,key,i	C &		\ut  S2. Compare.\\
	CMP	t,k,ki		C &
	BZ	t,Success	C\bg{S} &	Exit if $K =K_i$.
	ADD	i,i,8		C-S & 		\ut S3. Advance.\\
	PBN	i,S2		C-S\bg{1-S} & 	\ut  S4. End of file?\\
	POP	0,0		& 	    	Return zero if not in table.
Success	ADDU	$0,key,i		S &		Return \.LOC($K_i$)..
	POP	1,0		  & \slug
%%%rt 6.1progs.rt   & (5C-S+5)\upsilon+ C\mu
%%%off
