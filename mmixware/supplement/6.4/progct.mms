%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	6.4/progct.mms
%	Author:	M. Ruckert
%	Title:	Program C, Chained hash table search and insertion
%	6.4 Program C using relative Links = Offsets and Keys in TETRAs
%	negative link = empty, odd Link = end of chain R is offset
%       not exactly Don Knuth's version, loading the first link twice
%       see progcto.mms for another version.

	PREFIX	:hash:
d	IS	$0	Tabledefinitionblock: Data, Modul, Free
k	IS	$1	$K$ Key

m	IS	$2	Local variables
i	IS	$3
key	IS	$4	$T_{\tt KEY}$
link	IS	$5	$T_{\tt LINK}$	
p	IS	$6	${\tt i}^\prime$
r	IS	$7
t	IS	$8	$t$


TABLE	IS	0
M	IS	8
R	IS	12
KEY	IS	0
LINK	IS	4

%%%on
:Start	LDT	m,d,M		1 & $M\is \.M(D).$.
	LDOU	key,d,TABLE	1 & $\.key.\is \.TABLE(D).$.
	ADDU	link,key,LINK		1 & $\.link.\is \.TABLE(D).+\.LINK.$.
	DIV	t,k,m		1 & \ut  C1. Hash.\\
	GET	i,:rR		1 & $i\is  h(K) = K \mod M$.^{rR+rR (remainder register)}^{Remainder register}
	SL	i,i,3		1 & Scale \.i.. (Now $0\le \.i. < 8M$.)
	LDT	t,link,i	1 &\ut  C2. Is there a list?\\
        BN	t,C6		1\bg{1-A} & If \.TABLE[$i$]. is empty, go to C6.
%%%
3H	LDT	t,key,i		C & $\.t.\is \.KEY[$i$].$.\lineref|6.4progctstart|
	CMP	t,t,k		C & \ut  C3. Compare.\\
	PBZ	t,Success	C\bg{C-S} & Exit if $K=\.KEY[$i$].$.
	SET	p,i		C-S & Keep previous value of \.i..
	LDT	i,link,i	C-S &\ut  C4. Advance to next.\\
	PBEV	i,3B		C-S\bg{A-S} &To C3 if  \.LINK[$i$]. is even.\lineref|6.4progctend|
%%%rt	6.4progctsearch.rt & (8C-7S+69)\upsilon +(2C-S+3)\mu
%%%
	LDT	r,d,R		A-S & \ut  C5. Find empty node.\\ $R\is \.R(D).$.
5H	SUB	r,r,8		T & $R\is R-1$.
	BN	r,Failure	T\bg{0} & Exit if no empty nodes left.
	LDT	t,link,r	T &$\.t.\is \.LINK[$R$].$.
	BNN	t,5B		T\bg{T-(A-S)} & Repeat until \.TABLE[$R$]. empty.
	STT	r,d,R		A-S &$\.R(D).\is R$.
	STT	r,link,p	A-S &$\.LINK[$i$].\is R$.
	SET	i,r		A-S & $i\is R$.
%%%
C6	SET	t,1		1-S &\ut  C6. Insert new key.\\ \lineref|6.4progctc6|
%%%
	STT	t,link,i	1-S &  $\.LINK[$i$].\is 1$. (End of chain.)
	STT	k,key,i		1-S &  $\.KEY[$i$].\is K$.
	POP	0,0
%%%
Success	ADDU	$0,key,i	S & Return \.LOC(TABLE[$i$])..
	POP	1,0		  &
Failure	NEG	$0,1		0 & Return $-1$.
	POP	1,0		  &\slug
%%%off


Init	LDT	m,d,M	
	SL	i,m,3
	STT	i,d,R
	LDO	key,d,TABLE
	ADDU	link,key,4
	NEG	t,1
1H	SUB	i,i,8
	STT	t,link,i
	BP	i,1B
	POP	0,0

	PREFIX :