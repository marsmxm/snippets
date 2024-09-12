%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	2.1/ex8.mms
%	Author:	M.Ruckert
%	Title:	Exercise 8
%%%on
	SET	n,0; LDOU x,TOP		\ut  B1.\\ $\.N.\is 0$,  $\.X.\is \.TOP.$.
	JMP	B2
B3	ADD	n,n,1; LDOU x,x,NEXT	\ut  B3.\\ $\.N.\is \.N.+1$, $\.X.\is \.NEXT(X).$.
B2	PBNZ	x,B3			\ut  B2.\\ If $\.X.=\Lambda$, stop.\quad\slug
%%%off