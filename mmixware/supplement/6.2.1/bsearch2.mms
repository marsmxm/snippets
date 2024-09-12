%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	6.2.1/bsearch2.mms
%	Author:	M. Ruckert
%	Title:	Program B, Binary search
% Version slightly improved
% avoids one jump after step 4 and balances C1 and C2

key		IS	$0			Parameter.
n		IS	$1		
k		IS	$2		
l		IS	$3		Local variables.
u		IS	$4		
ki		IS	$5		
i		IS	$6		
t		IS	$7		
%%%on
:Search		SET	l,0		 1 &\ut  B1. Initialize.\\ $l\is 1$.
		SUB	u,n,1		 1 & $u\is N$.
		JMP	B2		 1 &
B5		ADD	l,i,1		 C_1 &\ut  B5. Adjust $l$.\\
B2		CMP	t,u,l		 C+1-S &\ut  B2. Get midpoint.\\
		BN	t,Failure	 C+1-S\bg{1-S} & Jump if $u<l$.
		ADDU	i,u,l		 C &
		SRU	i,i,1 		 C &$i\is \lfloor (u+l)/2 \rfloor$.
		SLU 	t,i,3	 	 C &\ut  B3. Compare.\\
		LDO 	ki,key,t	 	 C &$\.ki.\is K_i$.
		CMP	t,k,ki	 	 C &
		BP	t,B5		 C \bg{C_1} &Jump if $K>K_i$.
		BZ	t,Success	 C_2 \bg{S} &
		SUB	u,i,1		 C_2-S &\ut  B4. Adjust $u$.\\ $u\is i-1$.
		JMP	B2		 C_2-S & To B2.
Success		8ADDU	$0,i,key		 S &
		POP	1,0		   &
Failure		POP	0,0		   &\slug
%%%rt 6.2.1bsearch2.rt & (8C+3(C_1+C_2) -3S +7)\upsilon + C\mu
%%%off