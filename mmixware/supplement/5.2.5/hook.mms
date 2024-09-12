%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	5.2.5/hook.mms
%	Author:	M.Ruckert
%	Title:	Hook subroutine
	PREFIX	:Hook:
bot	IS	$0	
i	IS	$1	scaled	
bi	IS	$2	
top	IS	$3	
P	IS	$4	
M	IS	:M	
LINK	IS	0
%%%on
:Hook	SET	i,M*8		1 & \ut H1. Initialize.\\ $i\is 0$.
	ADDU	bot,bot,i	1 & $\.bot.\is \.LOC(BOTM[$M+1$]).$.
	ADDU	top,bot,i	1 & $\.top.\is \.LOC(TOP[$M+1$]).$.
	NEG	i,i		1 & Now $\.bot.+\.i.= \.LOC(BOTM[$i$]).$
	JMP	H2		1 & \quad and  $\.top.+\.i.= \.LOC(TOP[$i$]).$.
%%%
0H	LDOU	bi,bot,i	M-1 &$\.bi. \is \.BOTM[$i$].$.
	BZ	bi,H3		M-1\bg{E^\prime} &\ut H4. Is pile empty?\\
	STOU	bi,P,LINK	M-1-E^\prime &\ut H5. Tie piles together.\\
H2	LDOU	P,top,i		M-E^\prime &\ut H2. Point to top of pile.\\
H3	ADD	i,i,8		M &\ut H3. Next pile.\\
	PBN	i,0B		M\bg{1} &
	STCO	0,P,LINK	1 &Terminate list.^{STCO+<STCO> (store constant octabyte)}
	POP	0,0		1 &\slug
%%%off	
	PREFIX	:

