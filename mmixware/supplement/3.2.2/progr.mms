%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	3.2.2/progr.mms
%	Author:	M.Ruckert
%	Title:	Program (14)
%%%on
	SRU	j,y,53 		$j \is \lfloor 256Y/w\rfloor$, $\.j. \is 8j+\{0,\ldots,7\}$.
	MULU	x,x,a;	ADD	x,x,c		$ X_{n+1} \is (aX_n+c) \mod w$.
	LDOU	y,V,j		$ Y \is V[j] $.
	STOU	x,V,j           $ V[j] \is X_{n+1} $.\quad\slug
%%%off