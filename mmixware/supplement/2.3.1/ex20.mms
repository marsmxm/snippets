%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	2.3.1/ex20.mms
% adapted by M. Ruckert from
%	Author:	M. Ruckert
%	Title:	Exercise 20, Program T with linked stack
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
LINK	IS	0
INFO    IS      8
%%%rton
:Inorder BZ	p,1F		 1\bg{0} &  \ut  T1. Initialize.\\	
	 GET	rJ,:rJ	 	 1 &  Stop if $\.P.=\Lambda$.
	 SET	s,0		 1 &  Set stack empty.
%%%
%%%on	ex20push.tex
T3	STOU	p,a,INFO	 n &\lineref|2.3.1-20pushon|
	LDOU	t,a,LINK	 n &
	STOU	s,a,LINK 	 n &
	SET	s,a		 n &
	SET	a,t		 n &\lineref|2.3.1-20pushoff|
%%%off
%%%rton
	LDOU	p,p,LLINK	 n & $\.P.\is \.LLINK(P).$.
	BNZ	p,T3		 n\bg{a-1} &  \ut  T2. $\.P.=\Lambda$?\\
%%%on	ex20pop.tex
T4	LDOU	t,s,LINK	 n &\lineref|2.3.1-20popon|
	STOU	a,s,LINK 	 n &
	SET	a,s		 n &
	SET	s,t		 n &
	LDOU	p,a,INFO	 n &\lineref|2.3.1-20popoff|
%%%off
%%%rton
T5	SET	t+1,p		 n & \ut  T5. Visit \.P..\\
	PUSHGO	t,visit,0	 n &
	LDOU	p,p,RLINK	 n & $\.P.\is \.RLINK(P).$.
	PBNZ	p,T3		 n\bg{a} & \ut  T2. $\.P.=\Lambda$?\\
	PBNZ	s,T4		 a\bg{1} & Test if the stack is empty.
%%%	
	PUT	:rJ,rJ		 1 &
1H	POP	0,0		   &\slug
%%%rt 2.3.1ex20.rt & (18n+5a+4)\upsilon+8n\mu
%%%off
	PREFIX	: