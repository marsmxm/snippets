%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	5.2.2/ex55.mms
%	Author:	M.Ruckert
%	Title:	Exercise 55, Quicksort with median of three
%
		PREFIX	:Quicksort:
R	IS	$0	Parameter for QSort
n	IS	$1	

l	IS	$0	Parameter for Step 2 to Step 8
j	IS	$1	scaled

rJ	IS	$2
t	IS	$3	Local variables
r	IS	$4
i	IS	$5	scaled
k	IS	$6	
ki	IS	$7	
kj	IS	$8	
d	IS	$9	
Rn	IS	$10	
%%% not needed in AltOpt Version
Rnn	IS	$11
m	IS	$12
kl	IS	$13
km	IS	$14
kr	IS	$15
kt	IS	$16

M	IS	11

%%%
:Sort	CMP	t,n,M		1 &\ut  Q1. Initialize.\\
	BNP	t,Q9		1\bg{0} & To Q9 if $N\le M$.
	GET	rJ,:rJ		1 &
	SUBU	t+1,R,8		1 & $l\is 0$.
	8ADDU	t+2,n,8		1 & $r\is N+1$.
	PUSHJ	t,Q2		1 &To Q2.
	PUT	:rJ,rJ		1 &
	JMP	Q9		1 &
%%%
%%%on
Q2	LDO	kl,l,8		A& \ut  Q2. Begin new stage.\\
	SUB	r,j,8		A&
	LDO	kr,l,r		A&
	SR	m,r,1		A&
	LDO	k,l,m		A&
	CMP	t,kl,k		A&			
	CSP	kt,t,k		A& Swap $K_m$ and $K_l$ if $K_l>K_m$.
	CSP	k,t,kl		A&
	CSP	kl,t,kt		A&
	CMP	t,k,kr		A&
	BNP	t,0F		A\bg{A/3}& Done if $K\le K_r$.
	STO	k,l,r		2A/3&
	SET	k,kr		2A/3& $K\is K_r$.
	CMP	t,kl,k		2A/3&		
	CSP	k,t,kl		2A/3& Swap $K_r$ and $K_l$ if $K_l>K_r$.
	CSP	kl,t,kr		2A/3&
0H      STO	kl,l,8		A&
	LDO	kt,l,16		A&
	STO	kt,l,m		A&
	STO	k,l,16		A&
	SET	i,24		A&
%%%off
	SET	r,j		A &
	JMP	0F		A &
Q6	STO	ki,l,j		B &\ut  Q6. Exchange.\\ $K_j\is K_i$.
	STO	kj,l,i		B & $K_i\is K_j$.
Q3	ADD	i,i,8		C^\prime-A &\ut  Q3. Compare $K_i:K$.\\ $i\is i+1$.\lineref|5.2.1-Q3|
0H	LDO	ki,l,i		C^\prime & $\.ki.\is K_i$.
	CMP	t,ki,k		C^\prime & If $K_i<K$,
	PBN	t,Q3		C^\prime\bg{A} & \quad repeat this step.\lineref|5.2.1-Q3end|
Q4	SUB	j,j,8		C-C^\prime &\subfoolit{j}\ut  Q4. Compare $K:K$\setfool.\\ $j\is j-1$.\lineref|5.2.1-Q4|
	LDO	kj,l,j		C-C^\prime & $\.kj.\is K_j$.
	CMP	t,k,kj		C-C^\prime & If $K<K_j$,
	PBN	t,Q4		C-C^\prime\bg{B+A} &\quad repeat this step.\lineref|5.2.1-Q4end|
	CMP	t,i,j		B+A &\foolit{j}\ut  Q5. Test $i : {}$\setfool.\\
	PBN	t,Q6		B+A\bg{A} & If $i<j$ go to Q6.
	STO	kj,l,16		A &Interchange $R_l\leftrightarrow R_j$.\lineref|5.2.2-stpivot|
	STO	k,l,j		A &
%%%
	SUB	d,r,j		A &\ut Q7. Put on stack.\\ $\.d.\is r-j$. 
	CMP	t,d,j		A &
	BNN	t,0F		A\bg{A-A^\prime} &Put smaller subfile on stack.
	CMP	t,j,8*M+8	A^\prime & Is left subfile too small?
	BNP	t,Q8		A^\prime\bg{A^\prime-S^\prime-A^{\prime\prime}} &To Q8 if $M+1\ge j> r-j$.
	CMP	t,d,8*M+8	S^\prime+A^{\prime\prime} &  If right subfile is too small,
	PBNP	t,Q2		S^\prime+A^{\prime\prime}\bg{S^\prime} &\quad go to Q2 with $l$ and $j$.
%%%
	GET	rJ,:rJ		S^\prime &Now $ j> r-j>M+1$.
	ADDU	t+1,l,j		S^\prime &To Q2 with $l+j$ 
	SET	t+2,d		S^\prime &\quad and $r-j$.
	PUSHJ	t,Q2		S^\prime & $(l,j)\Rightarrow\hbox{stack}$.
	PUT	:rJ,rJ		S^\prime &
	JMP	Q2		S^\prime &To Q2 with $l$ and $j$.
%%%
0H	CMP	t,d,8*M+8	A-A^\prime & Is right subfile too small?
	BNP	t,Q8		\fmt{\omit\hskip -20pt$}A-A^\prime\bg{A-A^\prime-S+S^\prime-A^{\prime\prime\prime}}\fmt{$} &To Q8 if $M+1\ge r-j\ge j$.
%%%
	CMP	t,j,8*M+8	S-S^\prime+A^{\prime\prime\prime} & Is left subfile too small?
	PBNP	t,0F		S-S^\prime+A^{\prime\prime\prime}\bg{S-S^\prime} &Jump if $r-j>M+1\ge j$
%%%
	GET	rJ,:rJ		S-S^\prime &Now $ r-j\ge j>M+1$.
	SET	t+1,l		S-S^\prime &Continue with $l$ 
	SET	t+2,j		S-S^\prime &\quad and $j$.
	ADD	l,l,j		S-S^\prime & $\l\is l+j$.
	SET	j,d		S-S^\prime & $j\is r-j$.
	PUSHJ	t,Q2		S-S^\prime & $(l+j,r-j)\Rightarrow\hbox{stack}$.
	PUT	:rJ,rJ		S-S^\prime &
	JMP	Q2		S-S^\prime &To Q2 with $l+j$ and $r-j$.
0H	ADD	l,l,j		A^{\prime\prime\prime} &Now $r-j>M\ge j-0$
	SET	j,d		A^{\prime\prime\prime} &
	JMP	Q2		A^{\prime\prime\prime} &To Q2 with $l+j$ and $r-j$.
%%%
Q8	POP	0,0		S &\ut  Q8. Take off stack.\\
%%\mmsskip
%%%off


%%%	%	&		1 &\ut  Q9. Straight insertion sort.\\
%%%	460 on Table 1, 1996246 on r1000
	NEG	j,1,n
	SL	j,j,3		
	SUB	Rn,R,j
	ADD	Rnn,Rn,8
2H	LDO	ki,Rn,j
	ADD	j,j,8
	LDO	kj,Rn,j
	CMP	t,kj,ki
	PBNN	t,6F
	SUB	i,j,8
4H	LDO	ki,Rn,i
	STO	ki,Rnn,i
	SUB	i,i,8
	LDO	ki,Rn,i
	CMP	t,kj,ki
	BN	t,4B
	STO	kj,Rnn,i
6H	PBN	j,2B
	POP	0,0
%%%off
%%%     Optimizing	about 1000 cycles shorter on r1000

%%%	%	&		1 &\ut  Q9. Straight insertion sort.\\
%%%	460 on Table 1, 1996246 on r1000
Opt	IS	@
	NEG	j,1,n
	SL	j,j,3		In this loop 
	SUB	Rn,R,j
	ADD	Rnn,Rn,8
	LDO	ki,Rn,j
2H	ADD	j,j,8
	LDO	kj,Rn,j
	CMP	t,kj,ki
	PBNN	t,6F
	STO	ki,Rn,j
	SUB	i,j,16
	LDO	ki,Rn,i
	CMP	t,kj,ki
	BNN	t,5F
4H	LDO	ki,Rn,i
	STO	ki,Rnn,i
	SUB	i,i,8
	LDO	ki,Rn,i
	CMP	t,kj,ki
	PBN	t,4B
5H	STO	kj,Rnn,i
	LDO	kj,Rn,j
6H	BNN	j,7F
%%% second loop
	ADD	j,j,8
	LDO	ki,Rn,j
	CMP	t,ki,kj
	PBNN	t,6F
	STO	kj,Rn,j
	SUB	i,j,16
	LDO	kj,Rn,i
	CMP	t,ki,kj
	BNN	t,5F
4H	LDO	kj,Rn,i
	STO	kj,Rnn,i
	SUB	i,i,8
	LDO	kj,Rn,i
	CMP	t,ki,kj
	PBN	t,4B
5H	STO	ki,Rnn,i
	LDO	ki,Rn,j
6H	PBN	j,2B

7H	POP	0,0





%%%off Alternative from exercise 5.2.1-33 388 on Table 1, 1253662 on r1000
	%	&		1 &\ut  Q9. Straight insertion sort\\
Alt	IS	@
	SL	j,n,3		1 & Loop on $j$.
	SUBU	Rnn,R,8		1 & Address of $R_{-1}$
	SUB	j,j,16		1 & 
	JMP	0F		1 & 
%%%
2H	ADD	i,j,8		N-1 & Set up  $j$, $K$, $R$.
	LDO	kj,R,j		N-1 &
	JMP	3F		N-1 &
%%%
4H	STO	ki,Rnn,i	B & Move $R_i$, increase $i$.
	ADD	i,i,8		B &
3H	LDO	ki,R,i		B+N-1 & Compare $K : K_i$.
	CMP	t,kj,ki	B+N-1 &
	PBP	t,4B		B+3(N-1) &
	STO	kj,Rnn,i		N-1 & $R$ into $R_{i+1}$.
%%%
	SUB	j,j,8		N-1 &
0H	PBNN	j,2B		N+2 &
%%%
	POP	0,0

%%%off Alternative from exercise 5.2.1-33 
%%% applying optimization of exercise 5.2.1-10
%%% 388 on Table 1, 1253662 on r1000
	%	&		1 &\ut  Q9. Straight insertion sort\\
AltOpt	IS	@
%%%
Q9	SL	j,n,3		1 & Loop on $j$.
	SUBU	Rn,R,8		1 & Address of $R_{-1}$
	SUB	j,j,8		1 & 
	JMP	0F		1 & 
%%%
2H	LDO	ki,R,j		N-1 & Compare $K : K_i$.
	SUB	j,j,8		N-1 &
	LDO	kj,R,j		N-1 &
	CMP	t,kj,ki		N-1 &
	PBNP	t,0F		N-1+2D &
%%%
	ADD	i,j,8		D &
4H	STO	ki,Rn,i		E & Move $R_i$, increase $i$.
	ADD	i,i,8		E &
	LDO	ki,R,i		E & Compare $K : K_i$.
	CMP	t,kj,ki		E &
	PBP	t,4B		E+2D &
	STO	kj,Rn,i		D & $R$ into $R_{i+1}$.
%%%
0H	PBP	j,2B		N+2 &
%%%
	POP	0,0		&\slug
%%%off