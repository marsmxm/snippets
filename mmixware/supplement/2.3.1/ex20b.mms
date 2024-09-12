%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	2.3.1/ex20b.mms
%	Author:	M. Ruckert
%	Title:	Exercise 20, skiping push(P) if LLINK(P)=0
%%% 
	PREFIX	:Inorder:
p       IS      $0
visit	IS	$1
a	IS	$2
s	IS	$3
rJ 	IS	$4
left	IS	$5
t	IS	$6
%%% 
RLINK   IS      0
LLINK   IS      8


%%%
%%%rton
:Inorder GET	rJ,:rJ		 1 &  \ut  T1. Initialize.\\
	 BZ	p,1F		 1\bg{0} &  Stop if $\.P.=\Lambda$.
	 SET	s,0		 1 &  Set stack empty.
%%%on
T3	LDOU	left,p,LLINK	 n &
	PBZ	left,T5		 n \bg{a-1}& To T5 if $\.LLINK(P).=\Lambda$.	
	STOU	p,a,s		 a-1 & \ut  T3. $\hbox{\rm Stack}\Leftarrow \.P.$.\\ 
	ADD	s,s,8		 a-1 & 
	SET	p,left		 a-1 & $\.P.\is \.LLINK(P).$.
	JMP	T3		 a-1 & 
%%%off
%%%rton
T4	SUB	s,s,8		 a-1 &\ut  T4. $\.P. \Leftarrow\hbox{\rm Stack}$.\\ 
	LDOU	p,a,s		 a-1 &
T5	SET	t+1,p		 n & \ut  T5. Visit \.P..\\
	PUSHGO	t,visit,0	 n &^{PUSHGO+<PUSHGO> (push registers and go)}
	LDOU	p,p,RLINK	 n & $\.P.\is \.RLINK(P).$.
	PBNZ	p,T3		 n\bg{a} & \ut  T2. $\.P.=\Lambda$?\\
	PBP	s,T4		 a\bg{1} & Test if the stack is empty.
%%%	
1H	PUT	:rJ,rJ		 1 &
	POP	0,0		   &\slug
%%%rt 2.3.1ex20b.rt & (8n+11a-2)\upsilon +(2n+2a-2)\mu
	PREFIX	: