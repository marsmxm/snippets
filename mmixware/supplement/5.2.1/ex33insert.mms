%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	5.2.1/ex33insert.mms
%	Author:	M.Ruckert, 26.3.2012
%	Title:	Exercise 33, Optimized Straight Insertion Sort
%		5.2.1 Page 81

key	IS	$0	
n	IS	$1	
j	IS	$2      scaled
i	IS	$3	
k	IS	$4	
ki	IS	$5	
key0	IS	$6	
t	IS	$7	
%%%
	%\r0=R, \r1=N\hidewidth 	&&&Parameter.
%%\mmsskip
	%\r2=j, \r3=i, \r4=k, \hidewidth &&& Local variables.
        %\r5={k_j}, \r6={R_{-1}}
%%\mmsskip
%%%on
:Sort	SUBU	key0,key,8		 1 & $\.key0.\is\.LOC($K_0$).$.
	SL	j,n,3; SUB j,j,16 1 & $j\is N-1$.
	JMP	S1		 1 & 
%%%
S2	ADD	i,j,8		 N-1 & \foolit{j}\ut  S2. Set up  \setfool, $K$, $R$.\\
	LDO	k,key,j		 N-1 &
	JMP	S3		 N-1 &
%%%
S4	STO	ki,key0,i		 B &\ut  S4. Move $R_i$, increase $i$.\\
	ADD	i,i,8		 B &
S3	LDO	ki,key,i		 B+N-1 & \ut  S3. Compare $K : K_i$.\\
	CMP	t,k,ki	 	 B+N-1 &
	PBP	t,S4		 B+N-1\bg{N-1} &
	STO	k,key0,i		 N-1 & \ut  S5. $R$ into $R_{i-1}$.\\
%%%
	SUB	j,j,8		 N-1 &
S1	PBNN	j,S2		 N\bg{1} &\foolit{j}\ut  S1. Loop on \setfool.\\\quad\slug
%%%
%%%rt 5.2.1ex33insert.rt    & (5B+11N-4)\upsilon + (2B+3N-3)\mu
%%%off
	POP	0,0			&
