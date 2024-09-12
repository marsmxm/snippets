%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	4.4/method1a.mms
%	Author:	M. Ruckert
%	Title:	Program (1)
%%%on
	SET	j,0		 Set $j\is 0$.
	PUT	rD,0		 Prepare for \.DIVU..^{rD+rD (dividend register)}
1H	DIVU	u,u,10		 $u\is\lfloor u/10\rfloor$ and $\.rR.\is u \mod 10$. 
	GET     t,rR; STBU t,u10,j $U_j\is u \mod 10$^{rR+rR (remainder register)}^{Remainder register}.
	ADD	j,j,1	 	 $j \is j+1$.
	PBP	u,1B		 Repeat until result is zero.\quad\slug
%%%off
