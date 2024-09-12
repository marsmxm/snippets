%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	6.1/ex3.mms
%	Author:	M.Ruckert
%	Title:	Exercise 3, Sequential search in linked list
%
p	IS	$0		Parameter
k	IS	$1	
kp	IS	$2	
t	IS	$3	

LINK	IS	0
KEY	IS	8

%%%on
S3	LDOU	p,p,LINK	C-S 	&	\ut  S3. Advance.\\ $P\is\.LINK($P$).$.
:Search	BZ	p,0F		C-S+1\bg{1-S} & \ut  S4. End of file?\\
	LDO	kp,p,KEY	C 	&	$\.kp.\is \.KEY($P$).$.
	CMP	t,k,kp		C 	&	\ut  S2. Compare.\\
	PBNZ	t,S3		C\bg{S} & 	If $K=\.KEY($P$).$, terminate successfully.	
0H	POP	1,0			&	Return \.p..\quad\slug
%%%rt 6.1ex3.rt & (5C-2S+3)\upsilon + (2C-S)\mu
%%%off
