%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	3.2.2/proga1.mms
%	Author:	M.Ruckert
%	Title:	Program A, Additive number generator
	PREFIX	:Random:
j	GREG	24*8
k	GREG	55*8
y	GREG	:X-8	$\.y. \is \.LOC(Y[$0$]).$.
%%%
t	IS	$1
%%%	
%%%on
:Random	LDOU	$0,y,j		\ut  A1. Add.\\ $\.\$0. \is Y[j]$.
	LDOU	t,y,k		$\.t. \is Y[k]$.
	ADDU	$0,$0,t		$\.\$0. \is Y[j] + Y[k]$.
	STOU	$0,y,k		$Y[k] \is Y[j] + Y[k]$.
	SUB	j,j,8		\ut  A2. Advance.\\ $j \is j-1$.
	SUB	k,k,8		$k \is k-1$.
	SET	t,55*8
	CSNP	j,j,t		If $j \le 0$, set $j \is 55$.
	CSNP	k,k,t		If $k \le 0$, set $k \is 55$.
	POP	1,0		Return \.\$0..\quad\slug
%%%off