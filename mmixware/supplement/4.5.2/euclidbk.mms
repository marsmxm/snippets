%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	4.5.2/euclidbk.mms
%	Author:	M.Ruckert
%	Title:	Exercise 43
u	IS	$0			Parameter
v	IS 	$1 
k	IS	$2			Local variable
t	IS	$3
%%%on
:Gcd	OR	t,u,v			\ut B1. Find powers of 2.\\
	SUBU 	k,t,1; SADD k,k,t	^{SADD+<SADD> (sideways add)}^{Sideways addition}
	SR	u,u,k; SR v,v,k		$u\is u/2^k$ and $v\is v/2^k$.\quad\slug
%%%off
2H	NEG	t,v			\ut B2. Initialize.\\
	PBOD	u,4F		
	SET	t,u				
3H	SR	t,t,1			\ut B3. Halve $t$.\\
4H	PBEV	t,3B			\ut B4. Is $t$ even?\\
	CSP	u,t,t			\ut B5. Reset $\max(u,v)$.\\
	NEG	t,t; CSNN v,t,t
	SUB	t,u,v			\ut B6. Subtract.\\
	PBNZ	t,3B
	SL	u,u,k
	POP	1,0			Return $2^k\cdot u$. 
%%%off
