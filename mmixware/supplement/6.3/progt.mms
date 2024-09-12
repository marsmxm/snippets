%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	6.3/progt.mms
%	6.3 Program T
%	Author:	M. Ruckert
%	Title:	Program T, Trie search
	PREFIX :ProgT:

p	IS	$0	
K	IS	$1	

k	IS	$2	
s	IS	$3	
t	IS	$4	
x	IS	$5	

	
%%%on
:Start	SLU	s,K,3		1 &	\ut  T1. Initialize.\\ $\.s.\is 8K$.
	JMP	T2		1 &
%%%
T3	SET	p,x		C-1 &   \ut  T3. Advance.\\ $\.P.\is X$.
	SLU	s,s,8		C-1 &   Advance to next character of $K$.
T2	SRU	k,s,64-8	C &	\ut  T2. Branch.\\ Extract  $8k$.
	LDOU	x,p,k		C &	$X\is {}$ table entry number $k$ in \.NODE(P)..
	PBOD	x,T3		C\bg{1} & If $X$ is a link, go to T3.	
	CMP	t,K,x		1 &	\ut  T4. Compare.\\ 
	BNZ	t,Failure	1\bg{1-S} & If $X\ne K$, terminate unsuccessfully; 
	ADDU	$0,p,k		S &\quad else return \.LOC($X$)..
	POP	1,0
Failure	POP	0,0		  &\slug
%%%rt 6.3progt.rt & (5C-S+6)\upsilon+C\mu
%%%off
	PREFIX	:
