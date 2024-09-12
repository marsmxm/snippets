%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	4.2.3/dnormalize.mms
%	Author:	M.Ruckert
%	Title:	Program A, Double-precision Normalization
%%%on	
:DNormalize  SRU	t,wm,49			1        &\foolit{f}\ut  N1. Test \setxfool.\\
	   BOD  t,N4	 			1\bg{R}  &If $w\ge 2$, scale right.\lineref|4.2.3scaleright|
	   OR	t,wm,wl; BZ t,:Zero		1-R\bg{0} &\lineref|4.2.3zero|
%%%
N2	   SRU	t,wm,48; PBOD	t,6F		N+1-R\bg{1-R} &\ut  N2. Is $w$ normalized?\\
%%%
	   ZSN	carry,wl,1; SLU	wl,wl,1		N & \ut  N3. Scale left.\\ \lineref|4.2.3ex5scaleleft|
	   SLU	wm,wm,1				N &
	   ADDU wm,wm,carry			N &
	   SUB	e,e,1				N &
	   JMP N2		  		N &
%%%
N4	   SLU	carry,wm,63			R &\ut  N4. Scale right.\\ \lineref|4.2.3ex5scaleright|
	   SRU	wl,wl,1				R &
	   ADDU wl,wl,carry			R &
	   SRU	wm,wm,1				R &
	   ADD	e,e,1				R &
%%%						R &\ut  N5. Round.\\ omitted
6H	   SET	t,#7FFE; CMP	t,e,t   	1 &\ut  N6. Check $e$.\\ \lineref|4.2.3ex5round|
	   BP	t,:Error			1\bg{0} & Overflow.
	   BNP	e,:Error			1\bg{0}	& Underflow.
%%%
	   SLU	s,s,63				1 &\ut  N7. Pack.\\
	   SLU	e,e,48				1 &
	   ANDNH wm,#FFFF			1 &Remove hidden bit.\lineref|4.2.3wmclear|
	   OR 	 wm,wm,s; OR wm,wm,e		1 &
%%%
	   SET	$0,wl				1 &
	   SET	$1,wm				1 &
	   POP	2,0				  & Return $w$.
:Zero	   POP	0,0				  & Return zero. \quad\slug
%%%off

	   