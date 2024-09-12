%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	4.4/method1b.mms
%	Author:	M.Ruckert
%	Title:	Program (6), Method 1b
%%%on
	SET	j,m-1		 $j\is m-1$.
	LDBU	u,u10,m		 $U\is u_m$.
1H	MULU	u,u,10		 
	LDBU	t,u10,j; ADDU u,u,t	$U\is 10U+u_j$.
	SUB	j,j,1  	    	 $j\is j-1$.
	PBNN	j,1B		 Repeat for $m>j\ge 0$.\quad\slug
%%%off
