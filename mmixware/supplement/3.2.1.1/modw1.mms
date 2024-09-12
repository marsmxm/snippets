%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	3.2.1.1/modw1.mms
%	Author:	M.Ruckert
%	Title:	Program (2)
q	IS	$0
r	IS	$1
t	IS	$2
%%%on
        MULU	r,x,a;  GET q,rH       Compute $q,r$ with $aX = qw+r$.^{rH+rH (himult register)}^{Himult register}        
	SUBU	x,r,q                 	$ X \is r-q \mod w$.\lineref|3.2.1.1sub|
        CMPU	t,r,q
	ZSN	t,t,1			Set $t\is [r<q]$.
	ADDU	x,x,t   	      	$ X \is X+ t\mod w$.\quad\slug
%%%off
