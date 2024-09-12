%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	3.2.2/ex25.mms
%	Author:	M.Ruckert
%	Title:	Exercise25, Random number generator
		PREFIX	:Random55:
y		GREG	:X-8			$Y \is \hbox{Address of} Y[0]$.
x		IS	$0
j		IS	$1
ykj		IS	$2			$Y[k-j]$ 
t		IS	$3
%%%on	
:Random55	SET	j,24*8			$j\is 24$.
		ADD	ykj,y,31*8		$k\is 55$, $\.ykj. \is \hbox{Address of } Y[k-j]$.
1H		LDOU	x,y,j			$X \is Y[j]$.
		LDOU	t,ykj,j			$t \is Y[k-j+j]=Y[k]$.
		ADDU	x,x,t			$X \is Y[j] + Y[k]$.
		STOU	x,ykj,j			$Y[k] \is Y[k] + Y[j]$.
		SUB	j,j,8			$j \is j-1$.
		PBP	j,1B
k		IS	j			Reuse register \.j. for \.k..
		SET	k,31*8			$k\is 31$.
		ADD	ykj,y,24*8		$j\is 55$, $\.ykj. \is \hbox{Address of } Y[j-k]$.
1H		LDOU	x,ykj,k			$X \is Y[j-k+k]=Y[j]$.
		LDOU	t,y,k			$t \is Y[k]$.
		ADDU	x,x,t			$X \is Y[j] + Y[k]$.
		STOU	x,y,k			$Y[k] \is Y[k] + Y[j]$.
		SUB	k,k,8			$k \is k-1$.
		PBP	k,1B
		POP	0,0			\slug
%%%off