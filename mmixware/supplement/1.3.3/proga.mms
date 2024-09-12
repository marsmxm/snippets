%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	1.3.3/proga.mms
%	Author:	M.Ruckert
%	Title: Program A, Multiply permutations in cycle form
%	Bug Fix: setting first to current if first is not zero, and reseting to zero after '('.
%%%on
%%%
	LOC	Data_Segment
	GREG	@				&\lineref|1.3.3headstart|
MAXP 	IS	#2000				&Maximum number of permutations
InArg	OCTA	Buffer,MAXP			&The arguments for \.Fread.
Buffer	BYTE	0				&Place for input and output
left	GREG	'('
right	GREG	')'
%%\mmsskip
	LOC	#100
base	IS	$0				&Base address of permutations
k	IS	$1				&Index into  input
j 	IS	$2				&Index into  output
x	IS	$4				&Some permutation
current	IS	$5
start	IS	$6
size	IS	$7
t	IS	$8
%%\mmsskip
Main	LDA	$255,InArg			&Prepare for input.\lineref|1.3.3inputstart|
	TRAP	0,Fread,StdIn			&Read input.^{StdIn+<StdIn> (standard input)}^{Standard input file}
	SET	size,$255			&
	INCL	size,MAXP			&$\.size.\is \$255 + \.MAXP.$.
	BNP	size,Fail			&Check if input was OK.
	LDA	base,Buffer			&\lineref|1.3.3headend|
	ADDU	base,base,size			&$\.base.\is\.Buffer.+\.size.$.\lineref|1.3.3inputend|
%%%
before	GREG	0				%%hide
	GET	before,rI			%%hide
%%%
	NEG	k,size			1	&\ut A1. First pass.\\\lineref|1.3.3A1start|\lineref|1.3.3size1|\lineref|1.3.3KA0|
2H	LDBU	current,k,base		A	&Get next element of input.\lineref|1.3.3KA1|
	CMP	t,current,#20 		A	&
	CSNP 	current,t,0		A	&Set format characters to zero.
	STB	current,k,base 		A	&
	CSZ	start,start,current	A	&Remember first nonformat symbol.
	CMP	t,current,'('		A	&Is it `{\tt (}'?
	PBNZ	t,1F			A\bg{B}	&
	ORL	current,#80		B	&If so, tag it.\lineref|1.3.3open|
	STBU	current,k,base		B	&\lineref|1.3.3tag1|
	SET	start,0			B	&Reset first nonformat symbol.\lineref|1.3.3freq|
	JMP	0F			B	&\lineref|1.3.3KC1|
1H	CMP	t,current,')'		A-B	&Is it `{\tt )}'?
	PBNZ	t,0F			A-B\bg{D}	&\lineref|1.3.3KC2|
	ORL	start,#80		D	&Tag  first nonformat symbol\lineref|1.3.3close|
	STBU	start,k,base		D	&\qquad and replace `{\tt )}' by it.\lineref|1.3.3tag2|\lineref|1.3.3KC3|
0H	ADD	k,k,1			C	&\lineref|1.3.3size3|\lineref|1.3.3KC4|
	PBN	k,2B			C\bg{1}	&Have all elements been processed?\lineref|1.3.3A1end|\lineref|1.3.3KA2|
%%%
	SET	j,0			1	&\lineref|1.3.3mainstart1|\lineref|1.3.3KE0|\sourcenext
Open	NEG	k,size			E	&\ut A2. Open.\\\lineref|1.3.3KE1|\lineref|1.3.3scan1|\lineref|1.3.3KF0|
1H	LDB	x,k,base		F	&Look for untagged element.\lineref|1.3.3KF1|
	PBP	x,Go			F\bg{G}	&\lineref|1.3.3KH1|
	ADD	k,k,1			G	&\lineref|1.3.3scan5|
	PBN	k,1B			G\bg{1}	&\lineref|1.3.3mainend1|\lineref|1.3.3KF2|
%%%
after	GREG	0				%%hide
	GET	after,rI			%%hide
	SUB	$255,before,after		%%hide
	SUB	$255,$255,1 			%%hide subtract 1 for GET rI
	SET	t,2164				%%hide 2164 for proga.1.in
	CMP	$255,$255,t			%%hide
%%%	BNZ	$255,Fail			%%hide
%%%
Done	BNZ	j,0F				&Is answer the identity permutation?\lineref|1.3.3outputstart|\lineref|1.3.3scan3|
	STB 	left,base,0			&If so, change to `{\tt()}'.
	STB 	right,base,1			&
	SET	j,2
0H	SET	t,#0a				&Add a newline.
 	STB	t,base,j 
	ADD	j,j,1
	SET	t,0				&Terminate the string.
	STB	t,base,j
	SET	$255,base
	TRAP	0,Fputs,StdOut			&Print the answer.^{StdOut+<StdOut> (standard output)}^{Standard output file}
	SET	$255,0
Fail	TRAP	0,Halt,0			&Halt program.\lineref|1.3.3KH2|\lineref|1.3.3outputend|^{Halt+<Halt> operation}
%%%
Go	STB	left,base,j		H	&Output `{\tt (}'.\lineref|1.3.3mainstart2|\lineref|1.3.3KH3|\lineref|1.3.3go|
	ADD	j,j,1			H	&
	STBU	x,base,j		H	&Output \.X..\lineref|1.3.3out1|
	ADD	j,j,1			H	&
	SET	start,x			H	&\lineref|1.3.3KJ0|
Succ	ORL	x,#80			J	&\lineref|1.3.3KJ1|
	STBU	x,k,base		J	&Tag \.X..\lineref|1.3.3tag3|
%%%
3H	ADD	k,k,1			J	&\ut A3. Set {\tt CURRENT}.\\\lineref|1.3.3scan6|
	LDBU	current,k,base		J	&
	ANDNL	current,#80		J	&Untag.
	PBNZ	current,1F		J\bg{0}	&Skip past blanks.\lineref|1.3.3KJ2|
	JMP	3B			0	&\lineref|1.3.3noexec|\lineref|1.3.3KR0|
%%%
5H	STBU	current,base,j		Q	&Output \.CURRENT..\lineref|1.3.3KR1|\lineref|1.3.3out2|
	ADD	j,j,1			Q	&
	NEG	k,size			Q	&Scan formula again.\lineref|1.3.3scan2|\lineref|1.3.3KK0|
%%%
4H	LDBU	x,k,base		K	&\ut A4. Scan formula.\\\lineref|1.3.3KK1|
	ANDNL	x,#80			K	&Untag.	
	CMP	t,x,current		K	&
	BZ	t,Succ			K\bg{K+J-L}	&\lineref|1.3.3KJ3|
%%%
1H	ADD	k,k,1			L	&Move to right.\lineref|1.3.3scan7|
	PBN	k,4B			L\bg{P}	&End of formula?\lineref|1.3.3KK2|
%%%
	CMP	t,start,current		P	&\ut A5. $\.CURRENT.\ne\.START.$.\\\lineref|1.3.3out3|\lineref|1.3.3scan4|
	PBNZ	t,5B			P\bg{R}	&\lineref|1.3.3KR2|
%%%
	STBU	right,base,j		R	&\ut A6. Close.\\\lineref|1.3.3suppress|
	SUB	j,j,2			R	&Suppress singleton cycles.
	LDB	t,base,j		R	&
	CMP	t,t,'('			R	&
	BZ	t,Open			R\bg{R-S}&\lineref|1.3.3KE2|
	ADD	j,j,3			S	&
	JMP	Open			S	&\slug\lineref|1.3.3mainend2|\lineref|1.3.3KE3|
%%%rt  1.3.3proga.rt & (6+9A+4B+2C+4D+E+2F+4G+5H+8J+3Q+6K+4P+9R)\upsilon
%%%rt  1.3.3proga.mem & (2A+1B+1D+1F+2H+2J+1Q+1K+2R)\mu
%%%off