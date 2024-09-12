%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	4.5.2/euclidb.mms
%	Author:	M.Ruckert
%	Title:	Program B, Binary gcd Algorithm
u	IS	$0			Parameter
v	IS 	$1 
k	IS	$2			Local variable
t	IS	$3

%%%on
Gcd	SET	k,0		 1 &	\ut  B1. Find powers of 2.\\ \lineref|4.5.2kstart|
0H	OR	t,u,v		 A+1 &
	PBOD 	t,B2  		 A+1 \bg{A} &		Both even?
	SR	u,u,1; SR v,v,1	 A &		$u\is u/2$ and $v\is v/2$.
	ADD	k,k,1		 A &	$k \is k+1$.
	JMP	0B		 A &	\lineref|4.5.2kend|
B2	NEG	t,v		 1 &	\ut  B2. Initialize.\\
	PBOD	u,B4		 1\bg{B} &
	SET	t,u		 B &		
B3	SR	t,t,1		 D &	\ut  B3. Halve $t$.\\
B4	PBEV	t,B3		 1-B+D \bg{C} &	\ut  B4. Is $t$ even?\\
	CSP	u,t,t		 C &   \ut B5. Reset max($u$,$v$).\\
	NEG	t,t; CSNN v,t,t	 C &
	SUB	t,u,v		 C &	\ut  B6. Subtract.\\
	PBNZ	t,B3		 C\bg{1} &
	SL	u,u,k		 1 &
	POP	1,0		   &	Return $2^k\cdot u$.\quad\slug
%%%rt 4.5.2euclidb.rt & (8A +2B+7C+2D+9)\upsilon
%%%off