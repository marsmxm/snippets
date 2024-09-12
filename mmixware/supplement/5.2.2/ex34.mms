%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	5.2.2/ex34.mms
%	Author:	M. Ruckert
%	Title: Exercise 34, Program R,	Radix Sort 

		PREFIX	:Radixsort:
key	IS	$0	Parameter for RSort
n	IS	$1	

right	IS	$0	shares register with key
rJ	IS	$1	shares register with n
	
b	IS	$2	

left	IS	$3
j	IS	$4
d	IS	$5
ki	IS	$6
kj	IS	$7
i	IS	$8
t	IS	$9

%%%rton
:Sort	SET	left,key		1 &\ut  R1. Initialize.\\ $l\is 1$.
	8ADDU	right,n,left		1 &
	SUBU	right,right,8		1 & $r\is N$.
%%%
R2	SET	j,right		A &\ut  R2. Begin new stage.\\ $j \is r$.
	SUB	d,left,j		A &$i \is l$.
%%%on
	JMP	R3B		A &
%%%
R5	LDO	kj,j,8		C^{\prime\prime}-D^{\prime\prime}-X &\subfoolit{j}\ut  R5. Inspect $K$\setfool${}_{{}+1}$ for 0.\\
	AND	t,kj,b		C^{\prime\prime}-D^{\prime\prime}-X &
	BNZ	t,R6B		C^{\prime\prime}-D^{\prime\prime}-X\bg{C^{\prime\prime}-D^{\prime\prime}-A} &To R6B if it is 1.
%%%
	ADDU	i,j,d		A-X &
R7	STO	ki,j,8		B &\subfoolit{j}\ut  R7. Exchange $R_i$, $R$\setfool${}_{{}+1}$.\\
	STO	kj,i,0		B &
%%%
%%% begin second loop
%%%
R4A	ADD	i,i,8		D^\prime &\ut  R\strich{\sl 4}.~Increase $i$.\\  $i\is i+1$.
%%%
	LDO	ki,i,0		D^\prime &\subfoolit{i}\ut  R\strich{\sl 3}.~Inspect $K$\setfool for 1.\\
	AND	t,ki,b		D^\prime &
	PBZ	t,R4A		D^\prime\bg{B} &To R4A if it is 0.
%%%	
R6A	SUBU	j,j,8		D^{\prime\prime} &\foolit{j}\ut  R\strich{\sl 6}.~Decrease \setfool.\\ $j\is j-1$.
%%
	LDO	kj,j,8		D^{\prime\prime} &\subfoolit{j}\ut  R\strich{\sl 5}.~Inspect $K$\setfool${}_{{}+1}$ for 0.\\
	AND	t,kj,b		D^{\prime\prime} &
	BNZ	t,R6A		D^{\prime\prime}\bg{D^{\prime\prime}-B} & To R6A if it is 1.
%%%
	SUB	d,i,j		B &
	PBNP	d,R7		B\bg{A-X} &To R7 if $i\le j$;
	ADDU	j,j,8		A-X &\quad else adjust $j$
	JMP	R8		A-X &\quad and continue with R8.
%%%
%%% end second loop
%%%
R4B	ADD	d,d,8		C^\prime-D^\prime-A &\ut  R4. Increase $i$.\\
	BP	d,R8		C^\prime-D^\prime-A\bg{X^\prime} &To R8 if $i> j$.
%%%
R3B	LDO	ki,j,d		C^\prime-D^\prime-X^\prime &\ut  R3. Inspect $K_i$ for 1.\\
	AND	t,ki,b		C^\prime-D^\prime-X^\prime &
	PBZ	t,R4B		C^\prime-D^\prime-X^\prime\bg{A-X^\prime} &  To R4B if it is 0.
%%%
R6B	SUBU	j,j,8		C^{\prime\prime}-D^{\prime\prime}-X^\prime &\foolit{j}\ut  R6. Decrease \setfool.\\
	ADD	d,d,8		C^{\prime\prime}-D^{\prime\prime}-X^\prime &
	PBNP	d,R5		C^{\prime\prime}-D^{\prime\prime}-X^\prime\bg{X^{\prime\prime}} &To R8 if $i> j$.\quad\slug
%%%off
%%%rton
%%%	here we get back j and go to 8

%%%
%%%
R8	BOD	b,R10		A\bg{G} &\ut  R8. Test special cases.\\ 
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