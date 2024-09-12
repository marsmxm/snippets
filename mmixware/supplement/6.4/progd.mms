%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	6.4/progd.mms
%	Author:	M. Ruckert
%	Title:	Program D, Open addressing with double hashing

	PREFIX	:hash:
d	IS	$0	Tabledefinitionblock: Table, M, Vacancies
k	IS	$1	$K$ Key

m	IS	$2	$m$ Local variables
i	IS	$3	scaled
key	IS	$4	$T$
ki	IS	$5	$k_i$
t	IS	$6	$t$
c	IS	$7	scaled
q	IS	$8	$q$


TABLE	IS	0
M	IS	8
VACANCIES	IS	12

%%%on
:Start	LDT	m,d,M		1 & $M\is \.M(D).$.
	LDOU	key,d,TABLE	1 & $\.key.\is \.TABLE(D).$.
	DIV	q,k,m		1 & \ut  D1. First hash.\\
	GET	i,:rR		1 & $i\is h_1(K)=K \mod M$.^{rR+rR (remainder register)}^{Remainder register}
	SL	i,i,3		1 & $\.i.\is 8i$.
%%%
	LDO	ki,key,i		1 & \ut  D2. First probe.\\
	CMP	t,ki,k		1 & $\.KEY[$i$].=K$?
	PBZ	t,Success	1\bg{1-S_1} & Exit if $\.KEY[$i$].=K$.
	PBZ	ki,D6		1-S_1\bg{A-S_1} &To D6 if  \.TABLE[$i$]. is empty.
	SUB	t,m,2		A-S_1 & \ut  D3. Second hash.\\\lineref|6.3-progdsecond|
	DIV	t,k,t		A-S_1 & 
%%% except for test case 10, dividing k is better than dividing q (as in Knuth's program D)
	GET	c,:rR		A-S_1 & $c\is K \mod (M-2)$.
	8ADDU	c,c,8		A-S_1 & $c\is 1+(K \mod (M-2))$.\lineref|6.3-progdsecondend|
D4	SUB	i,i,c		C-1 & \ut  D4. Advance to next.\\ $i\is i-c$.
	8ADDU	t,m,i		C-1 & $\.t.\is \.i.+8M$.
	CSN	i,i,t		C-1 & If $i<0$, then $i\is i+M$.
	LDO	ki,key,i		C-1 & \ut  D5. Compare.\\
	CMP	t,ki,k		C-1 & $\.KEY[$i$].=K$?
	PBZ	t,Success	C-1\bg{C-1-S_2} &Exit if $\.KEY[$i$].=K$.
%%%				C-1-S_2   from above
	BNZ	ki,D4		C-1-S_2\bg{C-1-A+S_1}\kern -2em &\kern 3em To D4 if nonempty.
%%%rt  6.4progdsearch.rt & (11C+63A-3S_2-66S_1+59)\upsilon
%%%				(A-S) from above
%%%                             (1-A) from D2  	
D6	LDT	t,d,VACANCIES	1-S &\ut  D6. Insert.\\ $\.t.\is \.VACANCIES(D).$.
	BZ	t,Failure	1-S\bg{0} & Overflow if $N=M-1$.
	SUB	t,t,1		1-S & Increase $N$ by 1.
	STT	t,d,VACANCIES	1-S & $\.VACANCIES(D).\is M-1-N$.
	STO	k,key,i		1-S & $\.KEY[$i$].\is K$.
	POP	0,0		
%%%
Success	ADDU	$0,key,i	S & Return \.LOC(KEY[$i$])..
	POP	1,0		  &
Failure	NEG	$0,1		0 &  Return $-1$.
	POP	1,0		  &\slug
%%%off
	PREFIX	: