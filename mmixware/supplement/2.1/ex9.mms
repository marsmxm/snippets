%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	2.1/ex9.mms
%	Author:	M.Ruckert
%	Title:	Exercise 9, Print pile of cards
%%%on
		LOC	Data_Segment
		GREG	@
String		OCTA	0			&8-byte string
		BYTE	0			&\qquad with a terminating zero byte
%%%
		LOC	#100
%%%
		PREFIX	:PrintPile:
x		IS	$0			&The parameter
card		IS	$1			
down		IS	$2			
up		IS	$3			&$\smash{\left.\vcenter to 48pt{\vfil}\right\}}$\quad Local variables
title		IS	$4
t		IS	$5
NL		IS	#0a			&The ASCII newline character
NEXT		IS	0			&Offset of \.NEXT.
CARD		IS	8			&Offset of \.TAG., \.SUIT., \.RANK., and \.TITLE.
%%%
:PrintPile	SETH	t,#FF00			
		ORL	t,#FFFF			&$\.t.\is \Hex{FF0000000000FFFF}$.
		PUT	:rM,t			&Move \.t. to the mask register.^{rM+rM (multiplex mask register)}
		SETH	down,'('<<8		
		ORL	down,(')'<<8)+NL	&$\.down.\is \.'(',0,0,0,0,0,')',NL.$.
		SETH	up,' '<<8	
		ORL	up,NL<<8		&$\.up.\is \.' ',0,0,0,0,0,NL,0.$.
		JMP	2F			&Start the loop.
1H		LDOU	card,x,CARD		&Load \.TAG., \.SUIT., \.RANK., and \.TITLE..
		SLU	title,card,16		&Position $\.TITLE(X).$ after \.'('. or \.'\ '..
		SET	t,up			&Assume face \.up..
		CSN	t,card,down		&If sign bit in \.TAG. is set, it's face \.down..
		MUX	title,t,title		&Combine \.up. or \.down. with \.title..^{MUX+<MUX> (multiplex)}
		LDA	$255,:String		&Get address of \.String..
		STOU	title,$255		&Store \.title. in \.String..
		TRAP	0,:Fputs,:StdOut	&Print it.^{StdOut+<StdOut> (standard output)}^{Standard output file}
		LDOU	x,x,NEXT		&Set $\.X.\is \.NEXT(X).$.
2H		PBNZ	x,1B			&Continue until reaching the end.
		POP	0,0			&Return from subroutine.\quad\slug
%%%off	
		PREFIX	: