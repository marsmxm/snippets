%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	1.4.4/bufferswap.mms
%	Author:	M.Ruckert
%	Title:	Program (4), exercise 2, and exercise 6
	LOC	Data_Segment
	GREG	@
%%%on
S1	OCTA	1,Buffer1,S2	Consumers buffer linked to \.S2..
S2	OCTA	0,Buffer2,S1	Producers buffer linked to \.S1..
%%&&\mmsvdots&\cr
%%%off
SIZE	IS	#1000
InArgs	OCTA	0,SIZE		
InFile	IS	3
%%%on ex6.tex
Buffer1 OCTA	0		Empty buffer.
	LOC	Buffer1+SIZE
	GREG	@		%%%hide
Buffer2 OCTA	0		
	LOC	Buffer2+SIZE
	%\dots
	LOC	#100		%%%hide
%%%
	PREFIX	:Consumer:
buffer	GREG	0
i	GREG	0
s	GREG	0
t	IS	$0

:Consumer	LDA	s,:S1		Initialize $\.s.\is\.LOC(S1).$.
		LDOU	buffer,s,8	Initialize \.buffer..
		NEG	i,1		Initialize $\.i.\is -1$.
		PUSHJ	t,:GetByte
		%\dots
%%%off
		TRAP	0,:Halt,0
%%% End of main program
%%%on
1H		STCO	0,s,0		Release.^{STCO+<STCO> (store constant octabyte)}
		LDO	s,s,16		Switch to next buffer.
0H	 	LDO	t,s,0		Acquire.
	 	BZ	t,0B		Wait.
		SYNC	2		Synchronize.
		LDO	buffer,s,8	Update \.buffer..
		NEG	i,1		Initialize $\.i.\is-1$.
%%%
:GetByte	ADD	i,i,1		Advance to next byte.
		LDBU	$0,buffer,i	Load one byte.
		BZ	$0,1B		Jump if end of buffer.
		POP	1,0		Otherwise return a byte.\quad\slug
%%%off
%%%
	PREFIX	:Producer:
buffer	GREG	0
s	GREG	0
t	IS	$0
%%%on ex2.tex
:Producer LDA	s,:S2		Initialize $\.s.\is\.LOC(S2).$.

0H 	 LDO	t,s,0		Acquire.
	 BNZ	t,0B		Wait.
         LDO	buffer,s,16	Update \.buffer..

	 LDA	$255,:InArgs	Load argument for \.Fgets..^{Fgets+<Fgets> operation}
	 STOU	buffer,$255	Point \.InArgs. to the buffer. 
	 TRAP	0,:Fgets,:StdIn Read one line.^{StdIn+<StdIn> (standard input)}^{Standard input file}
	 BN	$255,EOF	Jump if error or end of file.
	 SYNC	1		Synchronize.^{SYNC+<SYNC> (synchronize)}
	 STCO	1,s,0		Release.^{STCO+<STCO> (store constant octabyte)}
 	 LDO	s,s,16		Advance to next buffer.
	 JMP	0B		Repeat.
%%%off
EOF	SET	$255,0
	TRAP	0,:Halt,0

	PREFIX	:

Main	SET	$255,0
	TRAP	0,Halt,0

