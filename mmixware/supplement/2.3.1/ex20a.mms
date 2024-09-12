%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	2.3.1/ex20a.mms
%	Author:	M. Ruckert
%	Title:	Exercise 20, Program T with stack in consecutive memory locations
%%% 
	PREFIX	:Inorder:
p       IS      $0
visit	IS	$1
a	IS	$2
s	IS	$3
rJ 	IS	$4
t	IS	$5
%%% 
RLINK   IS      0
LLINK   	IS      8


%%%on
:Inorder BZ	p,1F		 1\bg{0} &  \ut  T1. Initialize.\\	
	 GET	rJ,:rJ	 	 1 &  Stop if $\.P.=\Lambda$.
	 SET	s,0		 1 &  Set stack empty.
%%%
T3	STOU	p,a,s		 n & \ut  T3. $\hbox{\rm Stack}\Leftarrow \.P.$.\\ \lineref|2.3.1-20apushon|
	ADD	s,s,8		 n & \lineref|2.3.1-20apushoff|
	LDOU	p,p,LLINK	 n & $\.P.\is \.LLINK(P).$.
	BNZ	p,T3		 n\bg{a-1} &  \ut  T2. $\.P.=\Lambda$?\\
T4	SUB	s,s,8		 n &\ut  T4. $\.P. \Leftarrow\hbox{\rm Stack}$.\\ \lineref|2.3.1-20apopon| 
	LDOU	p,a,s		 n & \lineref|2.3.1-20apopoff|
T5	SET	t+1,p		 n & \ut  T5. Visit \.P..\\
	PUSHGO	t,visit,0	 n &^{PUSHGO+<PUSHGO> (push registers and go)}
	LDOU	p,p,RLINK	 n & $\.P.\is \.RLINK(P).$.
	PBNZ	p,T3		 n\bg{a} & \ut  T2. $\.P.=\Lambda$?\\
	PBP	s,T4		 a\bg{1} & Test if the stack is empty.
%%%	
	PUT	:rJ,rJ		 1 &
1H	POP	0,0		   &\slug
%%%rt 2.3.1ex20a.rt & (12n+5a+4)\upsilon+4n\mu
%%%off
	PREFIX	: