%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	2.2.3/ex3.mms
%	Author:	M.Ruckert
%	Title:	Exercise 3, Delete
%%%on
	PREFIX	:Delete:
%%\mmsskip
t	IS	$0			First parameter
p	IS	$1			Local variable
x	IS	$2			Temporary variable^{x+<x> (temporary variable)}
%%%
%%\mmsskip
LINK	IS	0			Offset of the \.LINK. field
INFO	IS	8			Offset of the \.INFO. field
%%%
%%\mmsskip
:Delete	LDOU	p,t			$\.P.\is \.T.$.	
	BZ	p,1F			Is $\.T.=\Lambda$?
	LDOU	x,p,LINK	
	STOU	x,t			$\.T.\is \.LINK(P).$.
	LDO	$0,p,INFO		$\.y.\is \.INFO(P).$.
	STOU	:avail,p,LINK		$\.LINK(P).\is \.AVAIL.$.
	SET	:avail,p			$\.AVAIL.\is \.P.$.
	POP	1,1			Successful (second) exit
1H	POP	0,0			Unsuccessful (first) exit\quad\slug
%%%off
	PREFIX	:
%%% The comparable sequential operation might look like this

%Delete	SET	   x,MAX
%	CMP	   x,avail,x
%	BNN	   x,Underflow
%	LDO	   $0,avail
%	SUB	   avail,avail,8
%	POP	   0,0	