%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	2.2.6/ex15.mms
%	Author:	Martin Ruckert
%	Title:	Exercise 15, Pivot step
  	 PREFIX	:PStep:
LEFT	IS	0
UP	IS	8
ROW	IS	16
COL	IS	20
VAL	IS	24


pivot	IS	$0
baserow	IS	$1
basecol	IS	$2
ptr	IS	$3

rJ	IS	$4
v	IS	$5
alpha	IS	$6
malpha	IS	$7
i0	IS	$8
p0	IS	$9
p1	IS	$10
pj	IS	$11
qj	IS	$12
J0	IS	$13
q0	IS	$14
i	IS	$15
J	IS	$16
j	IS	$17		$j$ scaled: $8j$
w	IS	$18
p	IS	$19
x	IS	$20
t	IS	$21
%%%on
:PStep	GET	rJ,:rJ		\ut S1. Initialize.\\ 
	LDO	v,pivot,VAL		$v\is \.VAL(PIVOT).$.
	SETH	t,#3FF0		$\.t.\is 1.0$.
	STO	t,pivot,VAL		$\.VAL(PIVOT).\is 1.0$.
	FDIV	alpha,t,v	$\.ALPHA.\is 1.0/\.VAL(P).$.^{FDIV+<FDIV> (floating divide)}
	SETH	t,#8000		The sign bit
	XOR	malpha,t,alpha	Precompute $\.malpha.\is -\.ALPHA.$.
	LDT	i0,pivot,ROW	$\.I0.\is \.ROW(PIVOT).$.
	8ADDU	p0,i0,baserow	$\.P0.\is \.LOC(BASEROW[I0]).$.
	LDT	J0,pivot,COL	$\.J0.\is \.COL(PIVOT).$.
	8ADDU	q0,J0,basecol	$\.Q0.\is \.LOC(BASECOL[J0]).$.
	JMP	S2
%%%
2H	LDT	J,p0,COL	$\.J.\is \.COL(P0).$.	
	SL	j,J,3		Scale \.J..
	ADDU	t,basecol,j	
	STOU	t,ptr,j		$\.PTR[J].\is \.LOC(BASECOL[J]).$.
	LDO	t,p0,VAL	
	FMUL	t,alpha,t	^{FMUL+<FMUL> (floating multiply)}
	STO	t,p0,VAL	$\.VAL(P0).\is\.ALPHA.\times\.VAL(P0).$.
%%%
S2	LDOU	p0,p0,LEFT	\ut S2. Process pivot row.\\ $\.P0.\is \.LEFT(P0).$.
	BEV	p0,2B		If \.P0. is even, process \.P0..
S3	LDOU	q0,q0,UP	\ut S3. Find new row.\\ $\.Q0.\is \.UP(Q0).$.\pageref|2.2.6s|	
	BOD	q0,9F		Exit if \.Q0. is odd.
	LDT	i,q0,ROW	$\.I.\is \.ROW(Q0).$.
	CMP	t,i,i0		
	BZ	t,S3		If $\.I.=\.I0.$, repeat.
	8ADDU	p,i,baserow		$\.P.\is\.LOC(BASEROW[I]).$.
S4A	LDOU	p1,p,LEFT	$\.P1.\is \.LEFT(P).$.	
%%%
S4	LDOU	p0,p0,LEFT	\ut S4. Find new column.\\ $\.P0.\is \.LEFT(P0).$.	
	BOD	p0,1F
%%%
	LDT	J,p0,COL	$\.J.\is \.COL(P0).$.
	CMP	t,J,J0
	BNZ	t,S5		If $\.J.=\.J0.$, 
	JMP	S4		\qquad repeat step S4.
%%%
1H	LDO	t,q0,VAL	If \.P0. is odd,
	FMUL	t,malpha,t	^{FMUL+<FMUL> (floating multiply)}
	STO	t,q0,VAL	\qquad $\.VAL(Q0).\is -\.ALPHA.\times\.VAL(Q0).$,
	JMP	S3		\qquad and return to S3.
%%%
1H	SET	p,p1		$\.P.\is \.P1.$.
	LDOU	p1,p,LEFT	$\.P1.\is \.LEFT(P).$.	
%%%
S5	BOD	p1,S6		\ut S5. Find \.I., \.J. element.\\
	LDT	t,p1,COL	$\.t.\is \.COL(P1).$.
	CMP	t,t,J		
	BP	t,1B		Loop until $\.COL(P1).\le \.J.$.
	BZ	t,S7		If $\.COL(P1).= \.J.$, go right to S7.
S6	SL	t,J,3		\ut S6. Insert \.I., \.J. element.\\
	LDOU	pj,ptr,t	$\.pj.\is \.PTR[J].$.
2H	SET	qj,pj		$\.qj.\is \.pj.$.	
	LDOU	pj,qj,UP	$\.pj. \is \.UP(PTR[J]).$.
	BOD	pj,0F		Jump if $\.pj.$ is odd.
	LDT	t,pj,ROW	
	CMP	t,t,i
	BP	t,2B		Loop until $\.ROW(UP(PTR[J])).\le \.I.$.
%%%0H	SET	x+1,5		Needed only if using exercise 2.5-27
0H	PUSHJ	x,:Allocate	$\.X.\Leftarrow\.AVAIL.$.\lineref|2.2.6X|
	STCO	0,x,VAL		$\.VAL(X).\is 0.0$.
	STT	i,x,ROW		$\.ROW(X).\is \.I.$.
	STT	J,x,COL		$\.COL(X).\is \.J.$.
	STOU	p1,x,LEFT	$\.LEFT(X).\is \.P1.$.
	STOU	pj,x,UP		$\.UP(X).\is \.UP(PTR[J]).$.
	STOU	x,p,LEFT	$\.LEFT(P).\is \.X.$.
	STOU	x,qj,UP	        $\.UP(PTR[J]).\is \.X.$.
	SET	p1,x		$\.P1.\is \.X.$.
%%%
S7	LDO	v,q0,VAL	\ut S7. Pivot.\\ $v\is\.VAL(Q0).$.
	LDO	t,p0,VAL	$\.t.\is\.VAL(P0).$.
	FMUL	v,v,t		$v\is\.VAL(Q0).\times\.VAL(P0).$.^{FMUL+<FMUL> (floating multiply)}
	LDO	w,p1,VAL	$w\is\.VAL(P1).$.
	FEQLE	t,w,v		\lineref|2.2.6rE|^{FEQLE+<FEQLE> (floating equivalent with respect to epsilon)}
	BNZ	t,S8		If $w\approx v \; (\epsilon)$, go to S8.	
	FSUB	v,w,v		
	STO	v,p1,VAL	$\.VAL(P1).\is\.VAL(P1).-\.VAL(Q0).\times\.VAL(P0).$. 
	SL	t,J,3	
	STOU	p1,ptr,t	$\.PTR[J].\is \.P1.$.
	SET	p,p1		$\.P.\is \.P1.$.
	JMP	S4A
%%%
S8	SL	t,J,3	\ut S8. Delete \.I., \.J. element.\\
	LDOU	pj,ptr,t    	$\.pj.\is \.PTR[J].$.
1H	SET	qj,pj		$\.qj.\is \.pj.$.
	LDOU	pj,qj,UP	$\.pj.\is\.UP(qj).$.
	CMP	t,pj,p1
	BNZ	t,1B		Repeat if $\.UP(PTR[J]).\ne \.P1.$.
	LDOU	t,p1,UP
	STOU	t,qj,UP		$\.UP(PTR[J]).\is \.UP(P1).$.	
	LDOU	t,p1,LEFT	
	STOU	t,p,LEFT	$\.LEFT(P).\is\.LEFT(P1).$.
	SET	t+1,p1
%%%	SET	t+2,5		Only needed if using exercise 2.5-28
	PUSHJ	t,:Free		$\.AVAIL.\Leftarrow \.P1.$.
	JMP	S4A
%%%
9H	PUT	:rJ,rJ
	POP	0,0		\slug
%%%off