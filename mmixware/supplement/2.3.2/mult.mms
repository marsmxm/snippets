%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	2.3.2/mult.mms
%	Author:	M.Ruckert
%	Title:	Subroutine Mult
	PREFIX	:Mult:

u	IS	$0		1. Parameter

v	IS	$1		2. Parameter
info	IS	$2		Local variables
rJ	IS	$3

t	IS	$4

%%%on	
:Mult	GET	rJ,:rJ
	SETMH	info,1			The constant ``1'' has $\.INFO.=1$ and $\.DIFF.=0$.
	LDO	t,u,:INFO
	CMP	t,info,t		Test if \.U. is the constant ``1''.
	BZ	t,1F			Jump if so.
	LDO	t,v,:INFO		Otherwise,
	CMP	t,info,t		\quad test if \.V. is the constant ``1'',
	GETA	v+1,:Mul			\quad prepare third parameter,^{GETA+<GETA> (get address)} 
	BNZ	t,:Tree2		\quad and if not so, return \.Tree2(U,V,.``$\times$''\.).;^{Optimization:! tail call}
	SET	t+1,v			\quad else, pass \.V. to \.Free..
	JMP	2F
%%%
1H	SET	t+1,u			Pass \.U. to \.Free..
	SET	u,v			$\.U.\is \.V.$.
2H	PUSHJ	t,:Free			Free one parameter
	PUT	:rJ,rJ		        \quad and return \.U..
	POP	1,0			\slug
%%%off
	PREFIX	:
