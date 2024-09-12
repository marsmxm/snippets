%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	2.1/alga.mms
%	Author:	M.Ruckert
%	Title:	Program (5), Algorithm A
%%%on
%%%	 2.1-\eq(5) Used as example in frontmatter

	LOC	Data_Segment
	GREG	@
TOP	OCTA	1F	Link variable; points to top card on pile.
NEWCARD OCTA    2F      Link variable; points to a new card.
%%\mmsskip
NEXT	IS	0	Definition of \.NEXT. 
TAG	IS	8	\qquad and \.TAG. offsets for the assembler
%%%off
SUIT	IS	9
RANK	IS	10
TITLE	IS	11
%%%on
FACEUP	IS	0
%%\mmsskip
top	IS	$0	Register for \.TOP.
new	IS	$1	Register for \.NEWCARD.
t	IS	$2	Temporary variable
%%%off

1H	  OCTA 3F			pile
	  BYTE #00,4,03,"  3 S"
	 
3H	  OCTA 0
	  BYTE #00,2,02,"  2 D"

2H	  OCTA 0			new card
	  BYTE #80,1,10," 10 C"

%%%on
	  %\dots
%%\mmsskip
	  LOC	#100
Main	  IS	@		%%hide
%%&\.Main.&\dots\cr
%%\mmsskip
	LDOU	new,NEWCARD	\ut  A1.\\ $\.new. \is \.NEWCARD.$.
	LDOU	top,TOP		$\.top. \is \.TOP.$.
	STOU	top,new,NEXT	$\.NEXT(NEWCARD).\is \.TOP.$.
	STOU	new,TOP	        \ut  A2.\\ $\.TOP.\is \.NEWCARD.$.
	SET	t,FACEUP	\ut  A3.\\ 
	STBU	t,new,TAG	$\.TAG(TOP).\is \.FACEUP.$.		
%%\mmsskip
	%\dots  &           &   &\slug
%%%off
	SET	$255,0
	TRAP	0,Halt,0


