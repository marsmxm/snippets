%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	5.2.2/bubble.mms
%	Author:	M.Ruckert, 26.3.2012
%	Title:	Program B, Bubble Sort
%		5.2.2 Page 107
%%%
key		IS	$0	Array of Records (\.OCTA.s)
n		IS	$1	Number of Records

keyb		IS	$1	Reusing register for $n$
j		IS	$2	scaled
kj		IS	$3
kjj		IS	$4
t		IS	$5	scaled
c		IS	$6
%%%
%%%on
:Sort  		SUB 	n,n,1 		1 &\ut  B1. Initialize \.BOUND..\\ 
		8ADDU 	keyb,n,key		1 &$\.BOUND. \is N$.
		JMP	B2		1 &
B3	    	LDO     kj,keyb,j		A &\subfoolit{j}\ut  B3. Compare/exchange $R$\setfool${}: R$\setfool${}_{{}+1}$.\\ 
B3A	    	ADD	j,j,8		C & $j \is j+1$.
	    	LDO     kjj,keyb,j	C &$\.kjj.\is K_{j+1}$.
	    	CMP	c,kj,kjj	C &$K_j>K_{j+1}$?
	    	BNP	c,0F		C\bg{C-B} & If $K_j>K_{j+1}$,
		STO	kj,keyb,j	B &\quad interchange $R_j \leftrightarrow R_{j+1}$.
	    	SUB     t,j,8		B &$t \is j$.
            	STO     kjj,keyb,t	B &$K_j\is K_{j+1}$.
		PBN	j,B3A		B\bg{D} &
		JMP	1F		D & To B4 (but skip test for termination).
0H		SET	kj,kjj		C-B & $\.kj.\is K_j$.
	    	PBN	j,B3A		C-B\bg{A-D} &
B4		BZ	t,9F		A-D\bg{1} &\ut  B4. Any exchanges?\\ 
1H		ADD	keyb,keyb,t	A-1 &$\.BOUND.\is t$.
B2		SET	t,0		A &\foolit{j}\ut  B2. Loop on \setfool.\\ $t\is 0$.
		SUB	j,key,keyb		A &$j\is 1$.
		PBN	j,B3		A\bg{0} &$1\le j < \.BOUND.$.
9H		POP	0,0		 &\slug	
%%%rt 5.2.2bubble.rt & (4+ 8A + 8C)\upsilon+(A+2B+C)\mu
%%%off