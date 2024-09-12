%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	5.2.5/empty.mms
%	Author:	M.Ruckert
%	Title:	Empty subroutine
	PREFIX	:Empty:
bot	IS	$0	Parameter
i	IS	$1
bi	IS	$2	
top	IS	$3	
P	IS	$4	
M	IS	:M	
LINK	IS	0
%%%on
:Empty	SET	i,M*8		1 &$i \is M$.
	ADDU	top,bot,i	1 &$\.top.\is \.LOC(TOP[$0$]).$.
	SUB	i,i,8		1 &$i\is i-1$.
%%%
0H	ADDU	bi,bot,i		M &$\.bi. \is \.LOC(BOTM[$i$]).$.
	STCO	0,bi,LINK		M &$\.BOTM[$i$]. \is \Lambda$.^{STCO+<STCO> (store constant octabyte)}
	STOU	bi,top,i		M &$\.TOP[$i$]. \is \.LOC(BOTM[$i$]).$.
	SUB	i,i,8			M &$i\is i-1$.
	PBNN	i,0B			M\bg{1} &$0\le i < M$.
	POP	0,0			1 &\slug
%%%off	
	PREFIX	:

