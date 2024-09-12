%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	4.5.3/euclidunit.mms
%	Author:	M.Ruckert
% 		Knuth's MIX code rewritten:
%	Title:	Exercise 1
   	PREFIX :
u	IS	$0			Parameter
v	IS 	$1
r	IS	$2 
t	IS	$3			Local variable


%%%on
0H	SUB	r,u,v	 	$r\is u-v$.
	SET	u,v		$u\is v$.
	NEG	v,r; CSN v,v,r	$v\is \abs{r}$.
	CMP	t,r,u	 
	BN	t,Gcd	 	$r<u$ ?
	DIV	t,v,u; GET v,:rR	$v\is u \mod v$.^{rR+rR (remainder register)}^{Remainder register}
Gcd	PBNZ	v,0B
%%%
	POP	1,0		\slug
%%%off

%%% Time: T(0.6*68+0.4*9)+3 = 44,4T +3
%%% for faster versions see below:
%% 
   	PREFIX :two:
u	IS	$0			Parameter
v	IS 	$1
r	IS	$2 
t	IS	$3			Local variable


%%%
0H	SUB	r,u,v	 	$r\is u-v$.
	CMP	t,r,v	 
	BN	t,1F	 	$u-v<v$ ?
	DIV	t,u,v
	SET	u,v		$u\is v$.
	GET	v,:rR		$v\is u \mod v$.
Gcd	PBNZ	v,0B
	POP	1,0
%%%
1H	SET	u,v		$u\is v$.
	NEG	v,r	
	CSN	v,v,r		$v\is \left\vertical r \right\vertical$.
	PBNZ	v,0B
	POP	1,0
%%%off

%%% Time: T(0.6*66+0.4*9)+3 = 43.2T +3
%%% the following alternative is even faster for  large T.
%%% Time T(0.6*66+0.4*8)+8 = 42.8T +8
 	 PREFIX :three:
u	IS	$0			Parameter
v	IS 	$1
r	IS	$2 
t	IS	$3			Local variable


%%
Gcd	SUB	r,u,v		Swap $u$ and $v$ if $u<v$.
	BNN	r,2F
	ADD	v,r,v
	SUB	u,v,r
	BZ	v,3F
0H	SUB	r,u,v	 	$r\is u-v$.
	SET	u,v		$u\is v$.
	CMP	t,r,v	 
	BN	t,1F	 	$u-v<v$ ?
	DIV	t,r,v
	GET	v,:rR		$v\is u \mod v$.^{rR+rR (remainder register)}^{Remainder register}
2H	PBNZ	v,0B
3H	POP	1,0
%%%
1H	SET	v,r
	PBNZ	v,0B
	POP	1,0
