%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	4.4/method2a.mms
%	Author:	M. Ruckert
%	Title:	Program (4)

n	IS	19
ten19	GREG	10*10*10*10*10*10*10*10*10*10*10*10*10*10*10*10*10*10*10

%%%on
	PUT	rD,u			^{rD+rD (dividend register)}
	DIVU 	x,ten19,ten19		$x\is\lfloor (wu+10^n)/10^n\rfloor$.
	SET	j,n-1			$j\is n-1$.
0H	MULU	x,x,10			$(\.rH.,x) \is 10x$.^{rH+rH (himult register)}^{Himult register}
	GET	t,rH; STB t,u10,j 	$U_j \is \lfloor 10x \rfloor $.
	SUB	j,j,1			$j \is j-1$.
	PBNN	j,0B			Repeat for $n>j\ge0$.\quad\slug
%%%off
