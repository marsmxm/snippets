%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	2.2.3/ex4.mms
%	Author:	M.Ruckert
%	Title:	Exercise 4, Allocate
%%%on
	PREFIX	:Allocate:
%%\mmsskip
x	IS	$0				&The return value
t	IS	$1				&Local variable
%%%
%%\mmsskip
c	IS	16				&The node size
LINK	IS	0				&Offset of the \.LINK. field
%%%
%%\mmsskip
:Allocate	SET	x,:avail		&$\.X.\is\.AVAIL.$.
		BZ	x,1F			&Is $\.AVAIL.=\Lambda$?
		LDOU	:avail,:avail,LINK		&$\.AVAIL.\is \.LINK(AVAIL).$.
0H		POP	1,0			&Return \.X..
1H		SET	x,:poolmax		&$\.X.\is \.POOLMAX.$.
		ADDU	:poolmax,:poolmax,c	&$\.POOLMAX.\is \.X.+c$.
		CMPU	t,:poolmax,:seqmin	&Is $\.POOLMAX.>\.SEQMIN.$?
		PBNP	t,0B			&If not, return \.X..
%\tt Overflow&\dots                           &&&Try to recover; if all fails,
		POP	0,0			&\qquad return zero.\quad\slug\pageref|2.2.3ex4|
%%%

%%%off
		PREFIX	:
	