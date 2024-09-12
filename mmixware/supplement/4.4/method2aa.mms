%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	4.4/method2aa.mms
%	Author:	M. Ruckert
%	Title:	Program (4')
ten9	GREG	10*10*10*10*10*10*10*10*10 $B^n$
n	IS	9
%%%on
	SLU u,u,32
	ADD u,u,ten9
	DIV x,u,ten9			$x\is\lfloor (wu+10^n)/10^n\rfloor$. 
	SET	j,n-1			$j\is n-1$.
0H	4ADDU	x,x,x			^{4ADDU+<4ADDU> (times 4 and add unsigned)}
	SLU x,x,1   			$x \is 10x$.
	SRU	t,x,32
	STBU t,u10,j		 	$U_j \is \lfloor 10x \rfloor $.
	ANDNMH	x,#FFFF			$x\is x \mod w$.^{ANDNMH+<ANDNMH> (bitwise and-not medium high wyde)}
	SUB	j,j,1			$j \is j-1$.
	PBNN	j,0B			Repeat for $n>j\ge0$.\quad\slug
%%%off
