%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	2.2.3/ex27.mms
%	Author:	M.Ruckert
%	Title:	Exercise 27
	PREFIX	:Ex27:
LINK	IS	4
SUB	IS	4

dir	IS	$0
x	IS	$1
n	IS	$2	
mloc	IS	$3
first	IS	$4
link	IS	$5
sub	IS	$6
s	IS	$7
i	IS	$8
p	IS	$9	$P$
q	IS	$10	$Q$
space	IS	dir
base	IS	x
%%%
%%%on
:Ex27	ADDU	link,dir,LINK
	ADDU	sub,x,SUB
	SL	n,n,3		Scale \.N..
%%%
	SET	i,n		\ut A0.\\  $i\is \.N.$.
	BNP 	i,A1		Loop on $i$ for $\.N. > i \ge 0$. 
%%%
0H	SUB	i,i,8		$i\is i-1$.
	LDTU	p,sub,i		$\.P.\is \.SUB[$i$].$.
	LDT	s,space,p	$\.s.\is \.SPACE(P).$.
	NEG	s,s		Negate \.s..
	STT	s,space,p	$\.SPACE(SUB[$i$]).\is -\.SPACE(SUB[$i$]).$.
	PBP	i,0B		Continue while $i>0$.
	JMP	A1
%%%
A3	ADDU	p,p,4		\ut A3.\\ $i\is i+1$.
	LDTU	q,link,p	$\.Q.\is \.LINK._i\.(SUB[N]).$.
	LDT	s,space,q	 
	BN	s,A2		If $\.SPACE(Q).\ge 0$,
	NEG	s,s
	STT	s,space,q	\qquad $\.SPACE(Q).\is - \.SPACE(Q).$, 
	STT	q,sub,n		\qquad $\.SUB[N].\is Q$, and
	ADD	n,n,8		\qquad $\.N.\is \.N.+1$.
%%%
A2	PBEV	q,A3		\ut A2.\\ If $Q$ is odd, go to A1; else to A3.
%%%
A1	BZ	n,B1		\ut A1.\\ If $\.N.= 0$, go to phase 2.
	SUB	n,n,8		$\.N. \is \.N.-1$.
	LDTU	p,sub,n		$P\is \.SUB[N].$, $i\is 0$.
	LDTU	q,link,p	 $Q\is \.LINK._i(\.SUB[N].)$.
	JMP	A2
%%%
B1	SET	p,first		\ut B1.\\ $\.P.\is\.FIRST.$.
	JMP	B2
%%%
B4	LDT 	p,link,p	\ut B4.\\  $\.P.\is \.LINK(P).$.
B2	BZ	p,0F		\ut B2.\\
%%%
	LDT	s,space,p	\ut B3.\\
	PBNN	s,B4		To B4 if  $\.SPACE(P).\ge 0$.
0H	STT	mloc,base,n	\ut B2/B3.\\ $\.BASE[N].\is \.MLOC.$.
	ANDN	p,p,1		Remove tag bit.
	STTU	p,sub,n		$\.SUB[N].\is \.P.$.
	NEG	s,s		
	STT	s,space,p	$\.SPACE(P).\is -\.SPACE(P).$.
	ADD	mloc,mloc,s	$\.MLOC.\is \.MLOC. + \.SPACE(P).$. 
	ADD	n,n,8		$\.N.\is \.N.+1$.
%%%
	PBNZ	p,B4		If $\.P.=0$, terminate. 
%%%
  	POP	0,0		Done.\quad\slug
%%%off
	PREFIX	: