%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	1.4.4/ex15.mms
%	Author:	M.Ruckert
%	Title:	Exercise 15

		LOC	Data_Segment
		GREG	@
S1		OCTA	0,Buffer1,S2	Consumers buffer linked to \.S2..
S2		OCTA	0,Buffer2,S1	Producers buffer linked to \.S1..
		%$\cdots$ 
NEXTG		OCTA	S1  
NEXTR		OCTA	S1
GS		OCTA	0		Green semaphore.
RS		OCTA	0		Red semaphore.
%%%
SIZE	IS	#1000
Buffer1 OCTA	0		Empty buffer.
	LOC	Buffer1+SIZE
	GREG	@		%%%hide
Buffer2 OCTA	0		
	LOC	Buffer2+SIZE
	%\dots
	LOC	#100		%%%hide
%%%
		LOC	#100
Red		IS	0
Green		IS	1
Yellow		IS	2

		PREFIX	:Acquire:
%%%on
s		GREG	0			Pointer to current color, buffer, and link
t		IS	$0			Temporary variable
:Acquire	LDOU	s,:NEXTG		Load address of next green buffer.
		LDO	t,s,0			Load buffer color.
		CMP	t,t,:Green		Is it green?
		BNZ	t,:Acquire		Jump if it's not green.
		PUT	:rP,0			Expect $\.GS.= 0$.^{rP+rP (prediction register)}^{Prediction register}
		SET	t,1			Intend to set $\.GS.\is 1$.
		CSWAP	t,:GS			Acquire green semaphore.^{CSWAP+<CSWAP> (compare and swap)}
		BZ	t,:Acquire		Start over if swap failed.
		STCO	:Yellow,s,0		Color buffer yellow.
		%\dots  &&& (Lines |1.4.4yellow|--|1.4.4acquireend| remain as before.)\quad\slug
%%%off
		LDOU	t,s,16			Load link.
		STOU	t,:NEXTG		Advance \.NEXTG.
		LDO	$0,s,8			Load buffer address.
		SYNC	1			Synchronize.^{SYNC+<SYNC> (synchronize)}
		STCO	0,:GS			Release green semaphore.
		POP	1,0			Return buffer address.\quad\slug

		PREFIX	:

Main		SET	$255,0
		TRAP	0,Halt,0

