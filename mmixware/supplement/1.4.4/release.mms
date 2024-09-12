%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	1.4.4/release.mms
%	Author:	M.Ruckert
%	Title:	Program R, Release for multiple consumers
		LOC	#100
Red		IS	0
Green		IS	1
Yellow		IS	2
s		GREG	0
%%%on
:Release	STCO	:Red,s,0	Turn buffer red.\quad\slug^{STCO+<STCO> (store constant octabyte)}
%%%off
		POP	0,0

Main		SET	$255,0
		TRAP	0,Halt,0
