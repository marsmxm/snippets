%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	6.2.1/usearch.mms
%	Author:	M. Ruckert
%	Title:	Program C, Uniform binary search
% uniform search with delta array

key		IS	$0		Parameter.
n		IS	$1	 	not used
k		IS	$2	
j		IS	$3	

i		IS	$4	scaled	Local variables.
ki		IS	$5	
dj		IS	$6	
t		IS	$7	
%%%on
:Search		LDO	i,j,0	 1 & \ut  C1. Initialize.\\ $j= 1$, $i\is\.DELTA[$j$].$.
		JMP	2F	 1 &
%%%
3H		BZ	t,Success	 C_1 \bg{S} & Jump if $K=K_i$.
		BZ	dj,Failure	 C_1-S \bg{A} & Jump if  $\.DELTA[$j$].=0$.
		SUB	i,i,dj	 C_1-S-A & \ut  C3. Decrease $i$.\\
2H		ADDU	j,j,8	 C & $j\is j+1$.
		LDO	dj,j,0	 C &\ut  C2. Compare.\\
		LDO	ki,key,i	 C &
		CMP	t,k,ki	 C & 
		PBNP	t,3B 	 C\bg{C_2} &  Jump if $K\le K_i$.
		ADD	i,i,dj	 C_2 & \ut  C4. Increase $i$.\\
		PBNZ	dj,2B	 C_2\bg{1-S-A} & Jump if $\.DELTA[$j$].\ne 0$.
%%%
Failure		POP	0,0			& Exit if not in table.
Success		ADDU	$0,key,i	 S & Return \.LOC($K_i$)..
		POP	1,0	   &\slug
%%%off