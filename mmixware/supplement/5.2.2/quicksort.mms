%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	5.2.2/quicksort.mms
%	Author:	M.Ruckert
%	Title:	Program Q, Quicksort
		PREFIX	:Quicksort:
key	IS	$0	Parameter for QSort
n	IS	$1	

left	IS	$0	Parameter for Step 2 to Step 8
j	IS	$1	scaled

rJ	IS	$2
t	IS	$3	Local variables
r	IS	$4
i	IS	$5	scaled
k	IS	$6	
ki	IS	$7	
kj	IS	$8	
d	IS	$9	
key0	IS	$10	
%%% not needed in AltOpt Version
key1	IS	$11

M	IS	12

%%%on
:Sort	CMP	t,n,M		1 &\ut  Q1. Initialize.\\
	BNP	t,Q9		1\bg{0} & To Q9 if $N\le M$.
	GET	rJ,:rJ		1 &
	SUBU	t+1,key,8		1 & $l\is 0$.
	8ADDU	t+2,n,8		1 & $r\is N+1$.
	PUSHJ	t,Q2		1 &To Q2.
	PUT	:rJ,rJ		1 &
	JMP	Q9		1 &
%%%
Q2	SET	i,16		A &\ut  Q2. Begin new stage.\\ $i\is l+1$.\lineref|5.2.2-pivotstart|
	LDO	k,left,8		A &$\.k.\is K_l$.\lineref|5.2.2-pivotend|
	SET	r,j		A & $r\is j$.
	JMP	0F		A &
Q6	STO	ki,left,j		B &\ut  Q6. Exchange.\\ $K_j\is K_i$.
	STO	kj,left,i		B & $K_i\is K_j$.
Q3	ADD	i,i,8		C^\prime-A &\ut  Q3. Compare $K_i:K$.\\ $i\is i+1$.\lineref|5.2.1-Q3|
0H	LDO	ki,left,i		C^\prime & $\.ki.\is K_i$.
	CMP	t,ki,k		C^\prime & If $K_i<K$,
	PBN	t,Q3		C^\prime\bg{A} & \quad repeat this step.\lineref|5.2.1-Q3end|
Q4	SUB	j,j,8		C-C^\prime &\subfoolit{j}\ut  Q4. Compare $K:K$\setfool.\\ $j\is j-1$.\lineref|5.2.1-Q4|
	LDO	kj,left,j		C-C^\prime & $\.kj.\is K_j$.
	CMP	t,k,kj		C-C^\prime & If $K<K_j$,
	PBN	t,Q4		C-C^\prime\bg{B+A} &\quad repeat this step.\lineref|5.2.1-Q4end|
	CMP	t,i,j		B+A &\foolit{j}\ut  Q5. Test $i : {}$\setfool.\\
	PBN	t,Q6		B+A\bg{A} & If $i<j$ go to Q6.
	STO	kj,left,8		A &Interchange $R_l\leftrightarrow R_j$.\lineref|5.2.2-stpivot|
	STO	k,left,j		A &
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
	ADDU	t+1,left,j		S^\prime &To Q2 with $l+j$ 
	SET	t+2,d		S^\prime &\quad and $r-j$.
	PUSHJ	t,Q2		S^\prime & $(l,j)\Rightarrow\hbox{stack}$.
	PUT	:rJ,rJ		S^\prime &
	JMP	Q2		S^\prime &To Q2 with $l$ and $j$.^{Optimization:! tail recursion}
%%%
0H	CMP	t,d,8*M+8	A-A^\prime & Is right subfile too small?
	BNP	t,Q8		\fmt{\omit\hskip -20pt$}A-A^\prime\bg{A-A^\prime-S+S^\prime-A^{\prime\prime\prime}}\fmt{$} &To Q8 if $M+1\ge r-j\ge j$.
%%%
	CMP	t,j,8*M+8	S-S^\prime+A^{\prime\prime\prime} & Is left subfile too small?
	PBNP	t,0F		S-S^\prime+A^{\prime\prime\prime}\bg{S-S^\prime} &Jump if $r-j>M+1\ge j$
%%%
	GET	rJ,:rJ		S-S^\prime &Now $ r-j\ge j>M+1$.
	SET	t+1,left		S-S^\prime &Continue with $l$ 
	SET	t+2,j		S-S^\prime &\quad and $j$.
	ADD	left,left,j		S-S^\prime & $\l\is l+j$.
	SET	j,d		S-S^\prime & $j\is r-j$.
	PUSHJ	t,Q2		S-S^\prime & $(l+j,r-j)\Rightarrow\hbox{stack}$.
	PUT	:rJ,rJ		S-S^\prime &
	JMP	Q2		S-S^\prime &To Q2 with $l+j$ and $r-j$.
0H	ADD	left,left,j		A^{\prime\prime\prime} &Now $r-j>M\ge j-0$.
	SET	j,d		A^{\prime\prime\prime} &
	JMP	Q2		A^{\prime\prime\prime} &To Q2 with $l+j$ and $r-j$.
%%%
Q8	POP	0,0		S &\ut  Q8. Take off stack.\\
%%\mmsskip
%%%off
%%%rtoff

%%%	%	&		1 &\ut  Q9. Straight insertion sort.\\
%%%	460 on Table 1, 1996246 on r1000
	NEG	j,1,n
	SL	j,j,3		
	SUB	key0,key,j
	ADD	key1,key0,8
2H	LDO	ki,key0,j
	ADD	j,j,8
	LDO	kj,key0,j
	CMP	t,kj,ki
	PBNN	t,6F
	SUB	i,j,8
4H	LDO	ki,key0,i
	STO	ki,key1,i
	SUB	i,i,8
	LDO	ki,key0,i
	CMP	t,kj,ki
	BN	t,4B
	STO	kj,key1,i
6H	PBN	j,2B
	POP	0,0
%%%off
%%%     Optimizing	about 1000 cycles shorter on r1000

%%%	%	&		1 &\ut  Q9. Straight insertion sort.\\
%%%	460 on Table 1, 1996246 on r1000
Opt	IS	@
	NEG	j,1,n
	SL	j,j,3		In this loop 
	SUB	key0,key,j
	ADD	key1,key0,8
	LDO	ki,key0,j
2H	ADD	j,j,8
	LDO	kj,key0,j
	CMP	t,kj,ki
	PBNN	t,6F
	STO	ki,key0,j
	SUB	i,j,16
	LDO	ki,key0,i
	CMP	t,kj,ki
	BNN	t,5F
4H	LDO	ki,key0,i
	STO	ki,key1,i
	SUB	i,i,8
	LDO	ki,key0,i
	CMP	t,kj,ki
	PBN	t,4B
5H	STO	kj,key1,i
	LDO	kj,key0,j
6H	BNN	j,7F
%%% second loop
	ADD	j,j,8
	LDO	ki,key0,j
	CMP	t,ki,kj
	PBNN	t,6F
	STO	kj,key0,j
	SUB	i,j,16
	LDO	kj,key0,i
	CMP	t,ki,kj
	BNN	t,5F
4H	LDO	kj,key0,i
	STO	kj,key1,i
	SUB	i,i,8
	LDO	kj,key0,i
	CMP	t,ki,kj
	PBN	t,4B
5H	STO	ki,key1,i
	LDO	ki,key0,j
6H	PBN	j,2B

7H	POP	0,0





%%%off Alternative from exercise 5.2.1-33 388 on Table 1, 1253662 on r1000
	%	&		1 &\ut  Q9. Straight insertion sort\\
Alt	IS	@
	SL	j,n,3		1 & Loop on $j$.
	SUBU	key1,key,8		1 & $\.key1.\is \.LOC($R_{-1}$).$.
	SUB	j,j,16		1 & 
	JMP	0F		1 & 
%%%
2H	ADD	i,j,8		N-1 & Set up  $j$, $K$, $R$.
	LDO	kj,key,j		N-1 &
	JMP	3F		N-1 &
%%%
4H	STO	ki,key1,i	B & Move $R_i$, increase $i$.
	ADD	i,i,8		B &
3H	LDO	ki,key,i		B+N-1 & Compare $K : K_i$.
	CMP	t,kj,ki	B+N-1 &
	PBP	t,4B		B+3(N-1) &
	STO	kj,key1,i		N-1 & $R$ into $R_{i+1}$.
%%%
	SUB	j,j,8		N-1 &
0H	PBNN	j,2B		N+2 &
%%%
	POP	0,0

%%%off Alternative from exercise 5.2.1-33 
%%% applying optimization of exercise 5.2.1-10
%%% 388 on Table 1, 1253662 on r1000
	%	&		1 &\ut  Q9. Straight insertion sort\\
ISort	IS	@
%%%rton
%%%on
Q9	SL	j,n,3		1 & \ut  Q9. Straight insertion sort.\\
	SUB	j,j,8		1 & $j\is N-1$.
	SUBU	key0,key,8		1 & $\.key0.\is \.LOC($K_0$).$.
	JMP	S1		1 &
%%%
S2	LDO	ki,key,j		N-1 &\foolit{j}\ut S2. Set up \setfool, $K$, $R$.\\
	SUB	j,j,8		N-1 &
	LDO	kj,key,j		N-1 &
	CMP	t,kj,ki		N-1 &\ut S3. Compare $K : K_i$.\\
	PBNP	t,S1		N-1\bg{D} &
%%%
	ADD	i,j,8		D &
S4	STO	ki,key0,i		E & \ut S4. Move $R_i$, increase $i$.\\
	ADD	i,i,8		E &
	LDO	ki,key,i		E & \ut S3. Compare $K : K_i$.\\
	CMP	t,kj,ki		E &
	PBP	t,S4		E\bg{D} &
	STO	kj,key0,i		D & $R_{i+1}\is R_j$.
%%%
S1	PBP	j,S2		N\bg{1} & \foolit{j}\ut S1. Loop on \setfool.\\\quad\slug
%%%off
	POP	0,0		&
%%%off
%%%rtoff