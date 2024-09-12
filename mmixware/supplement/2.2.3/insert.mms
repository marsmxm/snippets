%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	2.2.3/insert.mms
%	Author:	M.Ruckert
%	Title:	Program (10), Stack insertion
y	IS	$0					
p	IS	$1		
t	IS	$2			
%%%on
LINK	IS	0			Offset of the \.LINK. field
INFO	IS	8			Offset of the \.INFO. field
%%%off
:Insert	IS	@
%%%on
	SET	p,:avail			$\.P.\is\.AVAIL.$.
	BZ	p,:Overflow		Is $\.AVAIL.=\Lambda$?
	LDOU	:avail,p,LINK		$\.AVAIL.\is \.LINK(P).$.
	STO	y,p,INFO		$\.INFO(P).\is \.Y.$.
	LDOU	t,:T			
	STOU	t,p,LINK		$\.LINK(P).\is \.T.$.
	STOU	p,:T			$\.T.\is \.P.$.\quad\slug
%%%off	
	POP	0,0