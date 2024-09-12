%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	1.4.4/ex3.mms
%	Author:	M.Ruckert
%	Title:	Exercise 3
	LOC	Data_Segment
	GREG	@
%%%
S1	OCTA	1,Buffer1,S2	Consumers buffer linked to \.S2..
S2	OCTA	0,Buffer2,S1	Producers buffer linked to \.S1..
	%$\cdots$ 
%%%
SIZE	IS	#1000
Buffer1 OCTA	0		Consumers buffer is empty.
	LOC	Buffer1+SIZE
	GREG	@
Buffer2 OCTA	0
	LOC	Buffer2+SIZE
	GREG	@
InArgs	OCTA	0,SIZE
InFile	IS	3

	LOC	#100

	PREFIX	:Consumer:
buffer	GREG	0	buffer
i	GREG	0	index
s	GREG	0	semaphore
c	GREG	0	look ahead character.
t	IS	$0	temporary

:Consumer	LDA	buffer,:Buffer1	Initialize \.buffer..
		NEG	i,1		Initialize $\.i.\is -1$.
		LDA	s,:S1		Initialize $\.s.\is\.LOC(S1).$.
		PUSHJ	t,:GetByte

		TRAP	0,:Halt,0
%%% End of main program
%%%on
1H		STCO	0,s,0		Release.
		LDO	s,s,16		Switch to next buffer.
2H	 	LDO	t,s,0		Acquire.
	 	BZ	t,2B		Wait.
		LDO	buffer,s,8	Update \.buffer..
		SET	i,0		Initialize $\.i.\is 0$.
		SYNC	2		Synchronize.
		LDB	c,buffer,i	Load first byte.
		BZ	c,1B		If zero, advance to next buffer.
%%%
:GetByte	BZ	c,2B		Jump if look-ahead is zero.
		SET	$0,c		Prepare to return \.c..
		ADD	i,i,1		Advance to next byte.
		LDB	c,buffer,i	Load next byte.
		BNZ	c,0F		Jump if not end of buffer.
		STCO	0,s,0		Release.
0H		POP	1,0		Return byte.\quad\slug
%%%off

	PREFIX	:Producer:
buffer	GREG	0
s	GREG	0
t	IS	$0
%%%
:Producer LDA	s,:S2		Initialize $\.s.\is\.LOC(S2).$.

0H 	 LDO	t,s,0		Acquire.
	 BNZ	t,0B		Wait.
         LDO	buffer,s,16	Update \.buffer..

	 LDA	$255,:InArgs	Load argument for \.Fgets..^{Fgets+<Fgets> operation}
	 STOU	buffer,$255	Point \.InArgs. to the buffer. 
	 TRAP	0,:Fgets,:StdIn Read one line.^{StdIn+<StdIn> (standard input)}^{Standard input file}
	 BN	$255,EOF	Jump if error or end of file.
	 SYNC	1		Synchronize.^{SYNC+<SYNC> (synchronize)}
	 STCO	1,s,0		Release.
 	 LDO	s,s,16		Advance to next buffer.
	 JMP	0B		Repeat.
%%%off
EOF	SET	$255,0
	TRAP	0,:Halt,0

	PREFIX	:

Main	SET	$255,0
	TRAP	0,Halt,0

