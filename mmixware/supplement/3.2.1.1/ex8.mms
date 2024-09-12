%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	3.2.1.1/ex8.mms
%	Author:	M.Ruckert
%	Title:	Exercise 8
q	IS	$0
r	IS	$1
t	IS	$2
%%%on
        MULU	r,a,x; GET q,rH         Compute $q,r$ with $aX = qw+r$.^{rH+rH (himult register)}^{Himult register}
	ADDU	x,q,r			$X\is q+r$.
	CMPU	t,x,q		
	ZSN	t,t,1			$t\is [q+r\ge w]$.
	ADDU	x,x,t			$X\is X+t$.\quad\slug
%%%off

