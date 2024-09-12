%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	5.2.2/radixq.mms
%	Author:	M.Ruckert
%	Title:	Exercise 34, recursive radix sort
		PREFIX	:Radixsort:
%	This is a direct adaptation of quicksort to radix sort.
%       The calling convention was changed to have 
%	l point directly before the array, and l+j to the last element
key	IS	$0	Parameter for RSort
n	IS	$1	

l	IS	$0	Parameter for Recursion Step 2 to Step 8
j	IS	$1

b	IS	$2	$2^{b-1}, the most significant bit.

rJ	IS	$3
t	IS	$4	Local variables
i	IS	$5
ki	IS	$6	
kj	IS	$7	

r	IS	$8	Local in radix sort only
d	IS	$9

key0	IS	$8	Local in insertion sort only

M	IS	12	Threshold for Insertion sort


%%%on
:Sort	CMP	t,n,M		 1 & \ut  R1. Initialize.\\
	BNP	t,S1		 1 & To straight insertion sort, if $N\le M$.
	GET	rJ,:rJ	 1 &
	SUBU	t+1,key,8		 1 & $l\is 0$.
	8ADDU	t+2,n,0		 1 & $j\is N+1$.
	SET	t+3,b		 1 & $b\is b$.
	PUSHJ	t,R2		 1 & To radix exchange sort.
	PUT	:rJ,rJ	 1 &
	JMP	S1		 1 & To straight insertion sort.
%%%
R2	SET	i,0		 A & \ut  R2. Begin new stage.\\ $i\is l$.
	SET	r,j		 A &  $r\is j$.
	JMP	0F		 A &
R7	STO	ki,l,j		 B &\foolit{{}_j} \ut R7. Exchange $K_i$, $K$\setfool.\\
	STO	kj,l,i		 B &
R6	SUB	j,j,8		 C^{\prime\prime}-A &\foolit{j} \ut  R6. Decrease \setfool.\\ $j\is j-1$.
0H	LDO	kj,l,j		 C^{\prime\prime} &\foolit{{}_j} \ut  R5. Inspect $K$\setfool~for 0.\\
	AND	t,kj,b		 C^{\prime\prime} & 
	PBNZ	t,R6		 C^{\prime\prime}\bg{A+B} & To R4 if it is 0.
R4	ADD	i,i,8		 C^\prime &\ut  R4. Increase $i$.\\ $i\is i+1$.
	LDO	ki,l,i		 C^\prime &\ut  R3. Inspect $K_i$ for 1.\\
	AND	t,ki,b		 C^\prime &
	PBZ	t,R4		 C^\prime\bg{A+B} & To R8 if it is 1.
	CMP	t,i,j		 A+B &\ut  R8. Test special cases.\\
	PBN	t,R7		 A+B\bg{A} & To R7 if $i<j$.
%%%
	BOD	b,R10		 A\bg{G} & To R10 if $m\le 0$.
	SR	b,b,1		 A-G & $m\is m-1$.
	SUB	d,r,j		 A-G & $d\is r-j$.
	CMP	t,j,8*M		 A-G & 
	BNP	t,0F		 A-G\bg{R} & Jump if left subfile is too small.
%%%
	CMP	t,d,8*M		 A-G-R &
	BNP	t,R2		 A-G-R\bg{L} & Jump if right subfile is too small.
	GET	rJ,:rJ	 S & Now $ j> r-j>M+1$.
	ADDU	t+1,l,j		 S & \ut R9. Put on stack.\\ To R2 with 
	SET	t+2,d		 S & \qquad $l\is l+j$, $j\is r-j$,
	SET	t+3,b		 S & \qquad $2^{b-1}$,
	PUSHJ	t,R2		 S & \qquad and  $(l,j,\.rJ.)\Rightarrow\hbox{stack}$.
	PUT	:rJ,rJ	 S &
	JMP	R2		 S &To R2 with $l$ and $j$.
%%%
0H	CMP	t,d,8*M+8	 R & 
	PBNP	t,R10		 R\bg{R-K} & Jump if right subfile is too small.
%%%
	ADD	l,l,j		 R-K &Now $r-j>M\ge j-0$.
	SET	j,d		 R-K &
	JMP	R2		 R-K &To R2 with $l+j$ and $r-j$.
%%%
R10	POP	0,0		 S &\ut  R10. Take off stack.\\
%%%off


%%% Alternative from exercise 5.2.1-33 
%%% applying optimizations of exercise 5.2.1-10
%%% 388 on Table 1, 1253662 on r1000
	%	&		 1 &\ut Straight insertion sort\\
%%%on
S1	SL	j,n,3		 1 &\foolit{j} \ut S1. Loop on \setfool.\\
	SUBU	key0,key,8		 1 & $\.key0.\is\.LOC($K_0$).$.
	SUB	j,j,8		 1 & $j\is j-1$.
	JMP	0F		 1 & 
%%%
S3	LDO	ki,key,j		 N-1 & \ut S3.\\ $k_i\is K_j$.
	SUB	j,j,8		 N-1 & $j\is j-1$.	
	LDO	kj,key,j		 N-1 & $k_j\is K_j$.
	CMP	t,kj,ki		 N-1 & Compare $K_j : K_i$.
	BNP	t,0F		 N-1\bg{N-1-D} & Done if $K_{j}\le K_{j+1}$.
%%%
	ADD	i,j,8		 D & $i\is j+1$.
S4	STO	ki,key0,i		 E & \ut S4.\\ Move $K_i$.
	ADD	i,i,8		 E & Increase $i$.
	LDO	ki,key,i		 E & $k_i\is K_i$.
	CMP	t,kj,ki		 E & Compare $K_j : K_i$.
	PBP	t,S4		 E\bg{D} & Loop while  $K_j > K_i$.
	STO	kj,key0,i		 D & \ut S5.\\ $K_{i+1}\is K_j$.
%%%
0H	PBP	j,S3		 N\bg{1} & Continue while $j>0$.\quad\slug
%%%off
	POP	0,0
%%%