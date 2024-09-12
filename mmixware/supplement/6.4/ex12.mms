%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	6.4/ex12.mms
%	Author:	M. Ruckert
%	Title:	Exercise 12, Program C improved
%	6.4 Program C using relative Links = Offsets and Keys in TETRAs
%	negative link = empty, odd Link = end of chain R is offset
%       not exactly Don Knuth's version, loading the first link twice
%       see progcto.mms for another version.

	PREFIX	:hash:
d	IS	$0	$D$ Tabledefinitionblock: Data, Modul, Free
k	IS	$1	$k$ Key

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

%%%rton
:Start	LDT	m,d,M		1 & $M\is \.M(D).$.
	LDOU	key,d,TABLE	1 & $\.key.\is \.TABLE(D).$.
	ADDU	link,key,LINK		1 & $\.link.\is \.TABLE(D).+\.LINK.$.
	DIV	t,k,m		1 & \ut  C1. Hash.\\
	GET	i,:rR		1 & $i\is  h(K) = K \mod M$.
	SL	i,i,3		1 & Scale \.i.. (Now $0\le \.i. < 8M$.)
	LDT	t,link,i	1 &\ut  C2. Is there a list?\\
        BN	t,C6		1\bg{1-A} & If \.TABLE[$i$]. is empty, go to C6.
%%%on
	SL	t,m,3		A & 
	STT	k,key,t		A & $\.KEY[$M$].\is K$.
	JMP	3F		A &
%%%
0H	SET	p,i		C-A&  Keep previous value of \.i..
	LDT	i,link,i	C-A &\ut  C4. Advance to next.\\
3H	LDT	t,key,i		C & $\.t.\is \.KEY[$i$].$.
	CMP	t,t,k		C & \ut  C3. Compare.\\
	BNZ	t,0B		C\bg{C-A} & Jump if $\.KEY[$i$].\ne K$.
	PBEV	i,Success	A\bg{A-S} & Exit unless \.i. is odd.
%%%rt	6.4progctsearch.rt & (7C-2S+69)\upsilon +(2C+3)\mu
%%%off
	LDT	r,d,R		A-S & \ut  C5. Find empty node.\\ $\.r.\is \.R(H).$.
5H	SUB	r,r,8		T & $R\is R-1$.
	BN	r,Failure	T\bg{0} & Exit if no empty nodes left.
	LDT	t,link,r	T &$\.t.\is \.LINK[$R$].$.
	BNN	t,5B		T\bg{T-(A-S)} & Repeat until \.TABLE[$R$]. empty.
	STT	r,d,R		A-S &$\.R(D).\is R$.
	STT	r,link,p	A-S &$\.LINK[$i$].\is R$.
	SET	i,r		A-S & $i\is R$.
%%%on ex12insert.tex
C6	8ADDU	t,m,1		1-S &\ut  C6. Insert new key.\\ 
%%%off
	STT	t,link,i	1-S &  $\.LINK[$i$].\is M$. (nonempty).
	STT	k,key,i		1-S &  $\.KEY[$i$].\is K$.
	POP	0,0
%%%
Success	ADDU	$0,key,i	S & Return \.LOC(TABLE[$i$])..
	POP	1,0		  &
Failure	NEG	$0,1		0 &
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