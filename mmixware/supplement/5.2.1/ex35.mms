%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	5.2.1/ex35.mms
%	Author:	Martin Ruckert
%	Title:	Exercise 35, List concatenation	
		PREFIX	:ListCat:
head	IS	$0	Parameter
m	IS	$1	
link	IS	$2

j	IS	$3	Local variables
p	IS	$4	
q	IS	$5	
hj	IS	$6
tail	IS	$7


%%%on
:ListCat	SL	j,m,3; SUB j,j,8 1 &$j\is M$.
		LDOU	tail,head,j	1 & Initialize \.tail..
		JMP	0F		1 &
%%%
1H		LDOU	hj,head,j	M-1 &$\.hj.\is\.LOC($H_j$).$.
		BZ	hj,0F		M-1\bg{E} & Skip empty heads. 
		SET	q,hj		M-1-E &
%%%
2H		SET	p,q		N-L & Bump $p$ and $q$.
		LDOU	q,link,p		N-L &
		PBNZ	q,2B		N-L\bg{M-1-E} &
%%%
		STOU	tail,link,p	M-1-E & Concatenate lists.
		SET	tail,hj		M-1-E &  Advance to the next list.
0H		SUB	j,j,8		M & $j\is j-1$.
		PBNN	j,1B		M\bg{1} & Loop on $j$.
		STOU	hj,head,0	1 &
%%%rt 5.2.1ex35.rt & (3N-3L+9M-3E)\upsilon+ (N-L+2M-E)\mu
		POP	0,0		  &\slug
%%%off
		PREFIX	:
