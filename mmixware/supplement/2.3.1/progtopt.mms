%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	2.3.1/progtopt.mms
% 		adapted by M. Ruckert from
%	Author: Yuval Yarom <mmixmasters@qw...>
%	Title:	Exercise 20, recursive  
% 2002-06-28 02:24

% --------------------  VERSION 3  -------------------
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
:Inorder BZ	p,T4	         1\bg{0}   & \ut  T2. $\.P.=\Lambda$?\\
0H	GET	rJ,:rJ	  	 a	   & Entry for recursive calls.
T3	LDOU	t+1,p,LLINK	 n 	   & \ut  T3. Stack${}\Leftarrow \.P.$.\\ 
	PBZ	t+1,T5		 n\bg{a-1} & \ut  T2. $\.P.=\Lambda$?\\ \lineref|2.3.1shortcut|
	SET	t+2,visit	 a-1	   &
	PUSHJ	t,0B		 a-1 	   &Call \.Inorder(LLINK(P),Visit)..
T5	SET	t+1,p		 n 	   & \ut  T5. Visit \.P..\\
	PUSHGO	t,visit,0	 n 	   & Call \.Visit(P)..^{PUSHGO+<PUSHGO> (push registers and go)}
	LDOU	p,p,RLINK	 n 	   & $\.P.\is \.RLINK(P).$.
	BNZ	p,T3		 n\bg{n-a} & \ut  T2. $\.P.=\Lambda$?\\
	PUT	:rJ,rJ	 	 a	   &
T4	POP	0,0		 a 	   & \ut  T4. $\.P. \Leftarrow{}$ Stack.\\\quad\slug
%%%rt 2.3.1progtopt.rt & (10n+7a-3)\upsilon + 2n\mu
%%%off
	PREFIX	: