%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	4.4/example8.mms
%	Author:	M.Ruckert
%	Title:	Exercise 8, Multiplication instead of division
%%%on
x	GREG	1+(1<<63)/5	 $\.x. \is \lceil 2^{64}\times 1/10\rceil$.
	SET	j,0		 $j\is 0$.
Loop	MULU	t,u,x; GET	ux,rH	 	 $\.ux.\is \lfloor ux \rfloor$.
	4ADDU	t,ux,ux; SLU t,t,1  $t \is 10\lfloor ux\rfloor$.^{4ADDU+<4ADDU> (times 4 and add unsigned)}
	SUBU	r,u,t   	 $r \is u -10\lfloor ux\rfloor$.
	PBNN	r,0F		
	SUBU	ux,ux,1	 	 (Can occur only on first iteration,
	ADD	r,r,10		 \qquad     by exercise 7.)
0H	STBU 	r,U,j 		 $U_j\is r = u \mod 10$.
	SET	u,ux
	ADD	j,j,1	 	 $j \is j+1$.
	PBP	u,Loop		 Repeat until result is zero.\quad\slug
%%%off
