%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	5.2.2/radixand.mms
%	Author:	M. Ruckert
%	Title:	Program R, Radix exchange sort

		PREFIX	:Radixsort:
key	IS	$0	 Parameter for RSort
n	IS	$1	

right	IS	$0	shares register with key
rJ	IS	$1	shares register with n
	
b	IS	$2	

left	IS	$3	\.LOC($K_l$).
j	IS	$4	\.LOC($K_j$).
d	IS	$5	$8(i-j)$
ki	IS	$6	
kj	IS	$7	
t	IS	$8	

%%%on
:Sort	SET	left,key		1 &\ut  R1. Initialize.\\ $l\is 1$.
	8ADDU	right,n,left		1 &
	SUBU	right,right,8		1 & $r\is N$.
%%%
R2	SET	j,right		A &\ut  R2. Begin new stage.\\ $j \is r$.
	SUB	d,left,j		A &$i \is l$.
%%%
R3	LDO	ki,j,d		C^\prime &\ut  R3. Inspect $K_i$ for 1.\\ \lineref|5.2.2.radixR3|
	AND	t,ki,b		C^\prime &
	PBZ	t,R4		C^\prime\bg{B+X} & To R4 if it is 0.
%%%
R6	SUBU	j,j,8		C^{\prime\prime}+X &\foolit{j}\ut  R6. Decrease \setfool.\\ $j\is j-1$.
	BNN	d,R8		C^{\prime\prime}+X\bg{X} &To R8 if  $j<i$.
	ADD	d,d,8		C^{\prime\prime} & $j\is j-1$.
%%%
	LDO	kj,j,8		C^{\prime\prime} &\subfoolit{j}\ut  R5. Inspect $K$\setfool${}_{{}+1}$ for 0.\\
	AND	t,kj,b		C^{\prime\prime} &
	BNZ	t,R6		C^{\prime\prime}\bg{C^{\prime\prime}-B} & To R6 if it is 1.
%%%
	STO	ki,j,8		B &\subfoolit{j}\ut  R7. Exchange $R_i$, $R$\setfool${}_{{}+1}$.\\
	STO	kj,j,d	B &
%%%
R4	ADD	d,d,8		C^\prime-X &\ut  R4. Increase $i$.\\ $i\is i+1$.
	PBNP	d,R3		C^\prime-X\bg{A-X} &To R3 if $i\le j$.
%%%
R8	BOD	b,R10		A\bg{G} &\ut  R8. Test special cases.\\\lineref|5.2.2.radixR8|
	SRU	b,b,1		A-G & $b\is b+1$.
	CMPU	t,j,right		A-G &
	BNN	t,R2		A-G\bg{R} &To R2 if $j=r$.
	CMPU	t,j,left		A-G-R &
	BN	t,R2		A-G-R\bg{L} &To R2 if $j<l$.
	BZ	t,0F		A-G-R-L\bg{K+1} &To R9 if $j\ne l$.
	SET	left+3,b		S &\ut  R9. Put on stack.\\
	SET	left+4,left		S &
	GET	rJ,:rJ	S &
	PUSHJ	left,R2		S & Call R2 with $(K_j,{}\cdot{}, b, K_l)$. 
	PUT	:rJ,rJ	S &
0H	ADDU	left,left,8		S+K+1 & $l\is \hbox{return value} + 1$.
	CMP	t,left,right		S+K+1 &\ut  R2. Begin new stage.\\
	BN	t,R2		S+K+1\bg{K+G} & To R2 if $l<r$.
%%%	
R10	POP	1,0		S+1 &\ut  R10. Take off stack.\\\quad\slug
%%%off