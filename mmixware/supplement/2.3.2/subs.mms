%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	2.3.2/subs.mms
%	Author:	M.Ruckert
%	Title:	Subroutines Tree1 and Tree2
%%%
%	return tree with binary operator
	PREFIX	:aux:

u	IS	$0

v	IS	$1	Ignored for Tree1
diff	IS	$2
rJ	IS	$3

r	IS	$4

t	IS	$5


%%%on
:Tree1	SET	v,u		Set $\.V.\is \.U.$ in the unary case.
	JMP	1F
%%%:Tree2	ANDN	v,v,1	$\.RTAG(V).\is 0$. Seems like I dont need this.		
:Tree2	STOU	v,u,:RLINK   	$\.RLINK(U).\is \.V.$.
1H	GET	rJ,:rJ
	PUSHJ	r,:Allocate 	$\.R.\Leftarrow \.AVAIL.$.	
	PUT	:rJ,rJ
	STOU	u,r,:LLINK	$\.LLINK(R).\is \.U.$.
	GETA	t,:Const	^{GETA+<GETA> (get address)}
	SUBU	diff,diff,t	Convert \.diff. to relative address.
	STOU	diff,r,:INFO	$\.INFO(R).\is 0$, $\.DIFF(R).\is \.diff.$.
	OR	t,r,1  		Set tag bit.
	STOU	t,v,:RLINK	$\.RLINK(V).\is \.R.$, $\.RTAG(V).\is 1$.
	SET	$0,r		Return \.R..
	POP	1,0		\slug
%%%off	
	PREFIX	: