%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	5.2.2/panny.mms
%	Author:	M.Ruckert, 16.5.2012
%	Title:	Exercise 12, sorting using Pannys method
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
s		IS	$12
w		IS	$13

%%%on
:Sort		FLOTU	t,ROUND_UP,n	1 &\foolit{p} \ut  M1. Initialize \setfool.\\^{FLOTU+<FLOTU> (convert fixed to floating unsigned)}
		SETH	c,#FFF0	 	1 &
		NOR	c,c,c	 	1 &^{NOR+<NOR> (bitwise not-or)}
		ADDU	t,t,c		 1 &Round $N$ up to $2^t$.
		SRU	t,t,52		 1 &Extract $t$.
		ANDNL	t,#400		 1 &$t\is \lceil \lg N \rceil-1$.
		8ADDU	keyn,n,key	1 & $\.keyn.\is \.LOC($K_{N+1}$).$.
		SET	w,8		 1 &$w\is 1$.
		SLU	p,w,t		 1 &$p\is 2^t$.
		SL	n,n,3		 1 &Scale \.n..
%%%
M2		SL	q,w,t		 T & \foolit{q}\ut  M2. Initialize \setfool, $r$, $d$.\\ $q\is 2^t$.
		ADD	r,p,0		 T & $r\is 0$.
		SUBU	d,keyn,p		 T & $d\is p$.
%%%
3H		SUB	i,r,n		 A & $i\is r$.
%%%
8H		SUB	s,p,w		 D+E &$s\is 0$.
%%%
M4		LDO	k,d,i		 C & \ut  M4. Compare/exchange.\\
		LDO	kd,keyn,i		 C &\hfill\ut $R_{i+1}: R_{i+d+1}$.\\
		CMP	c,k,kd 	 C &
		PBNP	c,0F		 C\bg{B} & If $K_i+1 > K_{i+d+1}$,
%%%	
		STO	kd,d,i		 B &\quad interchange $R_{i+d+1}$
		STO	k,keyn,i		 B &\quad and $R_{i+1}$.
%%%
0H		PBNP	s,7F		 C\bg{C-D} & Jump if $s=p-1$.
		ADD	i,i,w		 C-D & $i\is i+1$.
		SUB	s,s,w		 C-D & $s\is s-1$.
		PBN	i,M4		 C-D\bg{E} & Repeat loop if $i+d < N$.
		JMP	5F		 E & Otherwise, go to M5.
%%%
7H		ADD	i,i,p		 D & 
		ADD	i,i,w		 D & $i\is i+p+1$.
		PBN	i,8B		 D\bg{A-E} & Repeat loop if $i+d<N$.
%%%
5H		SUB	d,q,p		 A &
		BZ	d,M6		 A\bg{T} &
%%%
		ADD	r,d,p		 A-T &\foolit{q}\ut  M5. Loop on \setfool.\\ $r\is p$.
		SUBU	d,keyn,d		 A-T &
		SR	q,q,1		 A-T & $q\is q/2$.
		ANDNL 	q,7		 A-T & $q\is 8\cdot\lfloor q/8 \rfloor$.
		JMP	3B		 A-T &
%%%
M6		SR	p,p,1		 T &\foolit{p}\ut  M6. Loop on \setfool.\\ $p\is p/2$.
		ANDNL 	p,7		 T & $p\is 8\cdot\lfloor p/8 \rfloor$.
		PBP	p,M2		 T\bg{1} &\slug
%%%rt 5.2.2panny.rt & (10A+4B+10C-D+2E+3T+15)\upsilon+(2B+2C)\mu
%%%off
		POP	0,0
%%%