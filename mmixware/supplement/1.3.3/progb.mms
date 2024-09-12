%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	1.3.3/progb.mms
%	Author:	M.Ruckert
%	Title:	Program B, Multiply permutations in cycle form
%%%on
	LOC	Data_Segment
table	GREG	@-#21				&$\.table. \is \.LOC($T[0]$).$.
	BYTE	0				&Now make a table
	LOC	@+#5F				&\quad for all valid names.
z	IS	$9
%%\mmsskip
%%\mmsskip
%%\omit	&&$\vdots$&&&\omit Same as lines |1.3.3headstart|--|1.3.3headend| of Program A.\hfill\cr
%%\noalign{\global\advance\mmsline by |1.3.3headend|}
%%\noalign{\global\advance\mmsline by -|1.3.3headstart|}
%%\noalign{\global\advance\mmsline by 1}
%%\noalign{\penalty-200}%to help with page breaking in section 1.4.4
%%\mmsskip
%%\mmsskip
%%%off
%%% same as Program A
	GREG  	@
MAXP 	IS	#2000				&Maximum number of permutations
InArg	OCTA	Buffer,MAXP			&The Arguments for \.Fread.
Buffer	BYTE	0				&Place for input and output
left	GREG	'('
right	GREG	')'
%%\mmsskip
	LOC	#100
base	IS	$0				&Base address of permutations
k	IS	$1				&Index into  input
j 	IS	$2				&Index into  output
x	IS	$4				&Some Permutation
current	IS	$5
start	IS	$6
size	IS	$7
t	IS	$8
%%\mmsskip
Main	LDA	$255,InArg			&Prepare for input.
	TRAP	0,Fread,StdIn			&Read Input.^{StdIn+<StdIn> (standard input)}^{Standard input file}
	SET	size,$255			&
	INCL	size,MAXP			&$\.size.\is \$255 + \.MAXP.$.
	BNP	size,Fail			&Check if input was ok.
	LDA	base,Buffer			&
%%%
before	GREG	0				%%hide
	GET	before,rI			%%hide
%%%
%%%on
	SET	k,#21			1	&\ut B1. Initialize.\\ Set \.k. to first valid name.	
0H	STB	k,table,k			A	&$T[k]\is k$.
	ADD	k,k,1			A	&$k\is k+1$.
	CMP	t,k,#80			A	&Loop until $k=\Hex{7F}$.
	PBN	t,0B			A\bg{1}	&
%%%
	SET	k,size			1	&
	JMP	9F			1	&
%%%
2H	LDB	x,base,k		B	&\ut B2. Next element.\\
	CMP	t,x,#20			B	&Skip formatting characters.
	BNP	t,9F			B\bg{0} &
	CMP	t,x,')'			B	&
	BZ	t,0F			B\bg{B-C}	&\lineref|1.3.3Bmoststart|
	CMP	t,x,'('			C	&
	CSZ	x,t,j			C	&\ut B4. Change $T$[$i$].\\
	CSZ	j,z,x			C	&\foolit{j}\ut B3. Change $T$[\setfool].\\ 
	LDB	t,table,x			C	&
	STB	z,table,x			C	&
0H	SET	z,t			D	&If $\.t.=0$, set $Z\is 0$.\lineref|1.3.3Bmostend|
%%%
9H	SUB	k,k,1			E	&
	PBNN	k,2B			E\bg{1}	&Input exhausted.
%%%
Output	ADDU	base,base,size		1	&$\.base.\is\.Buffer.+\.size.$.
	SET	j,0			1	&
	SET	k,#21			1	&Traverse table $T$.
0H	LDB	x,table,k			F	&
	CMP	t,x,k			F	&
	PBZ	t,2F			F\bg{G}	&Skip singleton.
	PBN	x,2F			G\bg{H}	&Skip tagged element.
	STB	left,base,j		H	&Output `{\tt(}'.
	ADD	j,j,1			H	&
	SET	z,k			H	&Loop invariant: $X=T[Z]$.
1H	STB	z,base,j		J	&Output $Z$.
	ADD	j,j,1			J	&
	OR	t,x,#80			J	&
	STBU	t,table,z			J	&Tag $T[Z]$.
	SET	z,x			J	&Advance $Z$.
	LDB	x,table,z			J	&Get successor element
	PBNN	x,1B			J\bg{H}	&\quad and continue, if untagged.
	STB	right,base,j		H	&Otherwise, output `{\tt)}'.
	ADD	j,j,1			H	&
2H	ADD	k,k,1			K	&Advance in table $T$.
	CMP	t,k,#80			K	&
	PBN	t,0B			K\bg{1} &
%%\omit	&&$\vdots$&&&\omit Same as lines |1.3.3outputstart|--|1.3.3outputend| of Program A.\quad\slug\hfill\cr
%%\mmsskip
%%%rt  1.3.3progb.rt & (4A+7B+3C+1D+2E+3F+3G+9H+7J+3K+12)\upsilon
%%%rt  1.3.3progb.mem & (1A+1B+2C+1F+2H+3J)\mu 
%%%off
%%% same as program A
%%%
after	GREG	0				%%hide
	GET	after,rI			%%hide
	SUB	$255,before,after		%%hide
	SUB	$255,$255,1 			%%hide subtract 1 for GET rI
	SET	t,2095				%%hide 2095 for proga.1.in
	CMP	$255,$255,t			%%hide
%%%	BNZ	$255,Fail			%%hide
%%%
Done	BNZ	j,0F				&Is answer the identity permutation?
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
Fail	TRAP	0,Halt,0			&Halt program.^{Halt+<Halt> operation}
%%%off