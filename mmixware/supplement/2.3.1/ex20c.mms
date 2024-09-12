%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	2.3.1/ex20c.mms
%	Author:	M. Ruckert
%	Title:	Exercise 20, with a linked stack skiping push(P) if LLINK(P)=0
%%% 
	PREFIX	:Inorder:
P       IS      $0
VISIT	IS	$1
A	IS	$2
S	IS	$3
rJ 	IS	$4
Left	IS	$5
t	IS	$6
%%% 
RLINK   IS      0
LLINK   	IS      8
LINK	IS	0
INFO    IS      8
%%%rton
:Inorder GET	rJ,:rJ		 1   &  \ut  T1. Initialize.\\	
	 BZ	P,1F		 1\bg{0} &  Stop if $P=\Lambda$.
	 SET	S,0		 1   &  Set stack empty.
%%%
T3	LDOU	Left,P,LLINK	 n   &
	PBZ	Left,T5		 n \bg{a-1}& To T5 if $\.LLINK.(P)=\Lambda$.	
	STOU	P,A,INFO	 a-1 & \ut  T3. $\hbox{\rm Stack}\Leftarrow P$.\\
	LDOU	t,A,LINK	 a-1 & Unlink node from \.A. and
	STOU	S,A,LINK 	 a-1 & add to \.S.
	SET	S,A		 a-1 &
	SET	A,t		 a-1 &
	SET	P,Left		 a-1 & $P\is \.LLINK.(P)$.
	JMP	T3		 a-1 & 
T4	LDOU	t,S,LINK	 a-1 & \ut  T4. $P \Leftarrow\hbox{\rm Stack}$.\\
	STOU	A,S,LINK 	 a-1 & Unlink node from \.S. and
	SET	A,S		 a-1 & add to \.A.
	SET	S,t		 a-1 &
	LDOU	P,A,INFO	 a-1 & 
T5	SET	t+1,P		 n   & \ut  T5. Visit $P$.\\
	PUSHGO	t,VISIT,0	 n   &^{PUSHGO+<PUSHGO> (push registers and go)}
	LDOU	P,P,RLINK	 n   & $P\is \.RLINK.(P)$.
	BNZ	P,T3		 n\bg{n-a} & \ut  T2. $P=\Lambda$?\\
	PBNZ	S,T4		 a\bg{1} & Test if the stack is empty.
%%%	
1H	PUT	:rJ,rJ		1 &
	POP	0,0
%%%rt 2.3.1ex20c.rt &  (10n+13a-8)\upsilon +(2n+6a-6)\mu
%%%off
	PREFIX	:
