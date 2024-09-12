%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	5.2.2/batcher.mms
%	Author:	M.Ruckert, 16.5.2012
%	Title:	Exercise 12, Batcher's  Merge Exchange Sort
%		5.2.2 Page 111

key		IS	$0	Array of Records (\.OCTA.s).
n		IS	$1	Number of Records.	
p		IS	$2
q		IS	$3
i		IS	$4
k		IS	$5	
kd		IS	$6	
d		IS	$7	
keyn		IS	$8	
t		IS	$9	
r		IS	$10
c		IS	$11	
%%%on

:Sort		FLOTU	t,ROUND_UP,n	1 &\foolit{p} \ut  M1. Initialize \setfool.\\^{FLOTU+<FLOTU> (convert fixed to floating unsigned)}
		SETH	c,#FFF0		1 &
		NOR	c,c,c		1 &^{NOR+<NOR> (bitwise not-or)}
		ADDU	t,t,c		1 &Round $N$ up to $2^t$.
		SRU	t,t,52		1 &Extract $t$.
		ANDNL	t,#400		1 &$t\is \lceil \lg N \rceil-1$.
		8ADDU	keyn,n,key	1 & $\.keyn.\is \.LOC($K_{N+1}$).$.
		SET	p,8		1 &$p\is 1$.
		SLU	p,p,t		1 &$p\is p\cdot 2^t$.
%%%
M2		SET	q,8		T &\foolit{q} \ut  M2. Initialize \setfool, $r$, $d$.\\
		SL	q,q,t		T & $q\is 2^t$.
		SET	r,0		T &$r\is 0$.
		ADDU	d,p,key		T &$d\is p$.
		JMP	M3		T &
%%%
M5		ADDU	d,key,d		A-T &\foolit{q}\ut  M5. Loop on \setfool.\\
		SR	q,q,1		A-T & $q\is q/2$.
		ANDNL 	q,7 		A-T & $q\is 8\cdot\lfloor q/8 \rfloor$.
		SET	r,p		A-T &$r\is p$.
%%%
M3		SUB	i,keyn,d		A &  \ut  M3. Loop on $i$.\\ $i\is N+1-d$.
		JMP	0F		A &
%%%
1H		AND	c,i,p		AN-D &
		CMP	c,c,r		AN-D & If $i \band p = r$,
		BNZ	c,0F		AN-D\bg{AN-D-C} & \quad go to M4.
%%%
		LDO	k,key,i		C &  \ut  M4. Compare/exchange\\
		LDO	kd,d,i		C &\hfill\ut $R_{i+1}: R_{i+d+1}$.\\
		CMP	c,k,kd 	C &
		PBNP	c,0F		C\bg{B} & If $K_i+1 > K_{i+d+1}$,
%%%	
		STO	k,d,i		B &\quad interchange $R_{i+d+1}$
		STO	kd,key,i		B &\quad and $R_{i+1}$.
%%%
0H		SUB	i,i,8		AN+A-D & $i\is i-1$.
		PBNN	i,1B		AN+A-D\bg{A} & $0\le i < N-d$.
%%%
		SUB	d,q,p		A &\foolit{q}\ut  M5. Loop on \setfool.\\ $d\is q-p$.
		PBNZ	d,M5		A\bg{T} &
%%%
		SR	p,p,1		T &\foolit{p}\ut  M6. Loop on \setfool.\\ $p\is p/2$.
		ANDNL 	p,7		T &$p\is 8\cdot\lfloor p/8 \rfloor$.
		PBP	p,M2		T\bg{1} &
%%%
		POP	0,0			&\slug
%%%off