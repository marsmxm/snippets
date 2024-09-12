%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	6.4/progl.mms
%	Author:	M. Ruckert
%	Title:	Program L, Linear probing and insertion

	PREFIX	:hash:
d	IS	$0	Tabledefinitionblock: Table, M, Vacancies
k	IS	$1	$K$ Key

m	IS	$2	$m$ Local variables
i	IS	$3	scaled
key	IS	$4	$T$
ki	IS	$5	$k_i$
t	IS	$6	$t$

TABLE	IS	0
M	IS	8
VACANCIES	IS	12

%%%on
:Start	LDT	m,d,M		1 & $M\is \.M(D).$.
	LDOU	key,d,TABLE	1 & $\.key.\is \.TABLE(D).$.
	DIV	t,k,m		1 & \ut  L1. Hash.\\\lineref|6.4proglhstart|
	GET	i,:rR		1 & $i\is K \mod M$.\lineref|6.4proglhend|
	SL	i,i,3		1 & $\.i.\is 8i$.
%%%
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
Failure	NEG	$0,1		0 & Return $-1$.
	POP	1,0		  &\slug
%%%off
	PREFIX	: