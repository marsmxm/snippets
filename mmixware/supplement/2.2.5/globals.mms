%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	2.2.5/globals.mms
%	Author:	M.Ruckert
%	Title:	Global registers
%%%on
callup	 	GREG	0
calldown 	GREG	0
callcar	 	GREG	0
off		IS	0
on		GREG	1
%%%
floor		GREG	0	
d1		GREG	0	Indicates doors open, activity
d2		GREG	0	Indicates no prolonged standstill
d3		GREG	0	Indicates doors open, inactivity
state		GREG	0       $-1$ going down, 0 neutral, $+1$ going up
%%%
dt		GREG	0		Hold time 
fi		GREG	0		Floor \.IN.
fo		GREG	0		Floor \.OUT.
tg		GREG	0		Give-up time\quad\slug
%%%off