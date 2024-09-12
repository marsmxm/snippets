%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	2.2.3/ex2.mms
%	Author:	M.Ruckert
%	Title:	Exercise 2, Insert
%%%on
	PREFIX	:Insert:
%%\mmsskip
t	IS	$0			\.LOC(T).\hphantom{Pointer to node}\vtop{\hbox{\smash{\lower 4pt \hbox{$\left.\vcenter to 17pt{\vfil}\right\}$\quad Parameters}}}}
y	IS	$1			The \.INFO.
p	IS	$2			Pointer to node\hphantom{\.LOC(T).}\vtop{\hbox{\smash{\lower 4pt \hbox{$\left.\vcenter to 17pt{\vfil}\right\}$\quad Local variables}}}}
x	IS	$3			Temporary variable^{x+<x> (temporary variable)}
%%%
%%\mmsskip
LINK	IS	0			Offset of the \.LINK. field
INFO	IS	8			Offset of the \.INFO. field
%%%
%%\mmsskip
:Insert	SET	p,:avail		$\.P.\is\.AVAIL.$.
	BZ	p,:Overflow		Is $\.AVAIL.=\Lambda$?
	LDOU	:avail,p,LINK		$\.AVAIL.\is \.LINK(P).$.
	STO	y,p,INFO		$\.INFO(P).\is \.Y.$.
	LDOU	x,t			
	STOU	x,p,LINK		$\.LINK(P).\is \.T.$.
	STOU	p,t			$\.T. \is \.P.$.
	POP	0,0			Return.\quad\slug
%%%off
	PREFIX	:
	