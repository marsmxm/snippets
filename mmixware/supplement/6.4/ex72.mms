%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	6.4/ex72.mms
%	Author:	M. Ruckert
%	Title:	Exercise 72 (New), Universal hash funktion
%	New exercise 72 b

	PREFIX	:hash:
d	IS	$0	Tabledefinitionblock: Table, M, Vacancies
k	IS	$1	$K$ Key

m	IS	$2	$m$ Local variables
i	IS	$3	scaled
key	IS	$4	$T$
ki	IS	$5	$k_i$
j	IS	$6
t	IS	$7	$t$

TABLE	IS	0
M	IS	8
VACANCIES	IS	12

%%%
:Start	LDT	m,d,M		1&
	LDOU	key,d,TABLE	1&
%%%on
        SRU	j,k,7*8-3; LDTU	i,:h,j		1&
	SLU	j,k,8; SRU t,j,7*8-3; INCL t,1*4*258; LDTU t,:h,t; XOR	i,i,t	1&
	SLU	j,j,8; SRU t,j,7*8-3; INCL t,2*4*258; LDTU t,:h,t; XOR	i,i,t	1&
	SLU	j,j,8; SRU t,j,7*8-3; INCL t,3*4*258; LDTU t,:h,t; XOR	i,i,t	1&
	SLU	j,j,8; SRU t,j,7*8-3; INCL t,4*4*258; LDTU t,:h,t; XOR	i,i,t	1&
	SLU	j,j,8; SRU t,j,7*8-3; INCL t,5*4*258; LDTU t,:h,t; XOR	i,i,t	1&
	SLU	j,j,8; SRU t,j,7*8-3; INCL t,6*4*258; LDTU t,:h,t; XOR	i,i,t	1&
	SLU	j,j,8; SRU t,j,7*8-3; INCL t,7*4*258; LDTU t,:h,t; XOR	i,i,t	1&
%%%off
	SL	i,i,3	
	JMP	L2		1 &	
%%%
L3	SL	i,m,3		E & \ut  L3. Advance to next.\\
L3B	SUB	i,i,8		C+E-1 & $i\is i-1$.
L2	LDO	ki,key,i	C+E & \ut  L2. Compare.\\
	CMP	t,ki,k		C+E & $\.KEY[$i$].=K$?
%%% possibly optimize by two PBZ PBNZ
	BZ	t,Success	C+E\bg{S} &Exit if $\.KEY[$i$].=K$.
%%%  
	BNZ	ki,L3B		C+E-S\bg{C-1} &To L3 if \.TABLE[$i$]. nonempty.
%%%	
	BN	i,L3		E+1-S\bg{E} &To L3 with $i\is M$ if $i< 0$.
%%%rt  6.4proglsearch.rt & (7C+9E+63)\upsilon +(C+E+2)\mu
%%%
	LDT	t,d,VACANCIES	1-S &\ut  L4. Insert.\\ $\.t.\is \.VACANCIES(D).$.
	BZ	t,Failure	1-S\bg{0} & Exit with overflow if $N=M-1$.
	SUB	t,t,1		1-S & Increase $N$ by 1.
	STT	t,d,VACANCIES	1-S & 
	STO	k,key,i		1-S & $\.KEY[$i$].\is K$.
	POP	0,0		
%%%
Success	ADDU	$0,key,i	S & Return \.LOC(KEY[$i$])..
	POP	1,0		  &
Failure	NEG	$0,1		0 &
	POP	1,0		  &\slug
%%%off
	PREFIX	: