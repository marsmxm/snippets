%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	5.3.1/ex28a.mms
%	Author:	M. Ruckert
%	Title:	Exercise 28, long version
% Following the text page 183 to 184
% using the sequence: load, test and branch, store

K	IS	$0	Parameter, Address of five octabytes
a	IS	$1	
b	IS	$2	
c	IS	$3	
d	IS	$4	
e	IS	$5	
t	IS	$6	

%%%on
:Sort	LDB	a,K,0		 1 &
	LDB	b,K,1		 1 &
	LDB	c,K,2		 1 &
	LDB	d,K,3		 1 &
	LDB	e,K,4		 1 &
	CMP	t,a,b		 1 &
	BP	t,0F		 1\bg{0.5} &	$a<b$
	CMP	t,c,d		 1 &
	BP	t,1F		 1\bg{0.5} & $a<b, c<d$
	CMP	t,b,d		 1 &
	BP	t,2F		 1\bg{0.5} & $a<b<d, c<d$
%	& $\cdots$
%\.2H.	& $\cdots$ &		&	      & $a<b, c<d<b$
%	& $\cdots$
1H	CMP	t,b,c		 1 	      &	$a<b, d<c$
	BP	t,2F		 1\bg{0.5} &	$a<b<c, d<c$
%	& $\cdots$
%\.2H.	& $\cdots$ &		&	      &	$a<b, d<c<b$
%	& $\cdots$
0H	CMP	t,c,d		 1 & 	$b<a$
	BP	t,1F		 1\bg{0.5} &	$b<a, c<d$
	CMP	t,a,d		 1 &
	BP	t,2F		 1\bg{0.5} &	$b<a<d, c<d$
%	& $\cdots$
%\.2H.	& $\cdots$ &		&	      &	$b<a, c<d<a$
%	& $\cdots$
1H	CMP	t,a,c		 1 	      &	$b<a, d<c$
	BP	t,2F		 1\bg{0.5} &	$b<a<c, d<c$
%	& $\cdots$
%\.2H.	& $\cdots$ &		&	      &	$b<a, d<c<a$
%	& $\cdots$
2H	SWYM			% %%hide
%%\mmsskip
	%	\rm $\langle\,$Using \.3H. and \.4H. to insert \.e.,
	%	\rm \hphantom{$\langle\,$}using \.5H. and \.6H. to insert the last element \.c.,
	%	\rm \hphantom{$\langle\,$}and finishing with 120 variations of \.7H..$\,\rangle$
%%\mmsskip
7H	STB	a,K,0		 1 &
	STB	b,K,1		 1 &
	STB	c,K,2		 1 &
	STB	d,K,3		 1 &
	STB	e,K,4		 1 &
	POP	0,0 		   &\slug
%%%off
%	Statistics
%	external nodes 120
%	internal nodes 1+2+4+8+16+32+56= 119  (56*2 + 8 = 120)
%	Lines of code: 5 LDO + 120*5 STO + 120 POP + 119 CMP + 119 BP
%	Total 963 lines/instructions
%	Times not counting the final POP
%	Maximum Time (assuming that 7 branches go in the wrong direction)
%	$38\upsilon+10\mu$
%	Miminum Time (assuming that 6 branches go in the right direction)
%	$22\upsilon+10\mu$
%	Average Time (8*6 Branches 112*7Branches = 832 Branches
%	times 3 cycles on average for CMP and BP = 2496 cycles / 120 = 20,8
%	$30,8\upsilon+10\mu$





