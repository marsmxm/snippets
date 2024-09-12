%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	2.2.3/delete.mms			
%	Author:	M.Ruckert
%	Title:	Program (11), Stack deletion
y	IS	$0			
p	IS	$1			
t	IS	$2			
%%%
LINK	IS	0			Offset for the \.LINK. field.
INFO	IS	8			Offset for the \.INFO. field.
Delete	IS	@
%%%on
	LDOU	p,:T			$\.P.\is \.T.$.	
	BZ	p,:Underflow		Is $\.T.=\Lambda$?
	LDOU	t,p,LINK	
	STOU	t,:T			$\.T.\is \.LINK(P).$.
	LDO	y,p,INFO		$\.Y.\is \.INFO(P).$.
	STOU	:avail,p,LINK		$\.LINK(P).\is \.AVAIL.$.
	SET	:avail,p		$\.AVAIL.\is \.P.$.\quad\slug
%%%off
	POP	1,0
%%% The comparable sequential operation might look like this

%	SET	   t,MAX
%	CMP	   t,:avail,t
%	BNN	   t,:Underflow
%	LDO	   y,:avail
%	SUB	   :avail,:avail,8
%	POP	   0,0	