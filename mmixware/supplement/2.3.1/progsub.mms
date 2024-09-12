%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	2.3.1/progsub.mms
%	Author:	M.Ruckert
%	Title:	Program S, Symmetric successor in a threaded binary tree
	PREFIX	:Inorder:
p	IS	$0
visit	IS	$1
rJ	IS	$2
head	IS	$4
t	IS	$5

RLINK	IS	0
LLINK	IS	8
INFO	IS	16

%%%on
:Inorder GET	rJ,:rJ		1		& \ut  S0. Initialize.\\
	SET	head,p		1 		&  Remember \.HEAD..
	JMP	S2		1		& Skip step S1.
%%%
S3	PUSHGO	t,visit,0 	 n		& \ut  S3. Visit \.P..\\^{PUSHGO+<PUSHGO> (push registers and go)}
S1	LDOU    p,p,RLINK	 n		& \utt  S1. {\tt RLINK(P)} a thread?\\
       	BOD     p,1F		 n\bg{a}	& If $\.RTAG(P).=1$, visit \.P.. 
S2      LDOU    t,p,LLINK	 n+1		& \ut  S2. Search to left.\\ 
        CSEV    p,t,t		 n+1		& If $\.LTAG(P).=0$, set $\.P.\is\.LLINK(P).$^{CSEV+<CSEV> (conditional set if even)}
        BEV     t,S2		 n+1\bg{a}	&\qquad and repeat this step.
%%%				 n+1-a		&
1H	ANDN	t+1,p,1		 n+1		&Untag \.P. and prepare to visit \.P..
	CMP	t,t+1,head	 n+1		&Unless $\.P.=\.HEAD.$,
	PBNZ	t,S3		 n+1\bg{1}	&\qquad visit \.P..	
%%%
9H	PUT	:rJ,rJ 	 	 1		&
	POP	0,0		 		&\slug
%%%rt 2.3.1progsub.rt & (11n+4a+12)\upsilon+(2n+1)\mu
%%%off
	PREFIX	:
