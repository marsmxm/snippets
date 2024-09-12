%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	4.5.2/euclid.mms
%	Author:	M.Ruckert
%	Title:	Program A, Euclid's Algorithm
u	IS	$0			Parameter
v	IS 	$1 
t	IS	$2			Local variable
%%%on
0H	DIV	t,u,v			\ut A2. Take $u\mod v$.\\
	SET	u,v			$u\is v$.
	GET	v,rR			$v\is u\mod v$.^{rR+rR (remainder register)}^{Remainder register}
Gcd	PBNZ	v,0B			\ut A1. $v=0$?\\ Done if $v=0$.
	POP	1,0			 Return $u$.\quad\slug
%%%off
