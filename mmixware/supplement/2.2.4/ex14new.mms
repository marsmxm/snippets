%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	2.2.4/ex14new.mms
%	Author:	M.Ruckert
%	Title:	Exercise 14, Zero
%%%
	PREFIX	:Zero:
COEF    IS      16               Definition of coefficient field
ABC     IS      8               Definition of ABC exponent field
LINK    IS      0              Definition of link field
p	IS	$0
t	IS	$1
%%%
%%%on
:Zero	SET	p,:avail		$\.P.\Leftarrow \.AVAIL.$.
	LDOU	:avail,:avail,LINK	
	STCO	0,p,COEF		$\.COEF(P).\is 0$.^{STCO+<STCO> (store constant octabyte)}
	NEG	t,1; STO t,p,ABC	$\.ABC(P).\is -1$.
	STOU	p,p,LINK		$\.LINK(P).\is \.P.$.
	POP	1,0			Return \.P..\quad\slug
%%%off