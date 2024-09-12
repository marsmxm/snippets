%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	2.3.1/progt.mms
% adapted by M. Ruckert from
%	Author: Yuval Yarom <mmixmasters@qw...>
% 2002-06-28 02:24
%	Title:	Program T, Traverse binary tree inorder
%%%
	PREFIX	:Inorder:
%%%
p       IS      $0
visit	IS	$1
rJ	IS	$2
t	IS	$3
%%% 
RLINK   IS      0
LLINK   	IS      8
INFO    IS      16
%%%on
:Inorder PBZ	p,T4	         n+1\bg{a} & \ut  T2. $\.P.=\Lambda$?\\
	GET	rJ,:rJ	  	 a	   & ^{rJ+rJ (return-jump register)}
T3	LDOU	t+1,p,LLINK	 n 	   & \ut  T3. Stack${}\Leftarrow \.P.$.\\ 
	SET	t+2,visit	 n	   &
	PUSHJ	t,:Inorder	 n 	   & Call \.Inorder(LLINK(P),Visit)..
T5	SET	t+1,p		 n 	   & \ut  T5. Visit \.P..\\
	PUSHGO	t,visit,0	 n 	   & Call \.Visit(P)..^{PUSHGO+<PUSHGO> (push registers and go)}
	LDOU	p,p,RLINK	 n 	   & $\.P.\is \.RLINK(P).$.
	BNZ	p,T3		 n\bg{n-a} & \ut  T2. $\.P.=\Lambda$?\\
	PUT	:rJ,rJ	 	 a	   &
T4	POP	0,0		 n+1 	   & \ut  T4. $\.P. \Leftarrow{}$ Stack.\\\quad\slug
%%%rt 2.3.1progt.rt & (15n+2a+4)\upsilon + 2n\mu
%%%off
	PREFIX	: