%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	4.2.1/flot.mms
%	Author:	M.Ruckert
%	Title:	Integer to Floating Point Conversion
	PREFIX	:Flot:
w	IS	$0	return value

u	IS	$0	1. parameter
v	IS	$1	2. parameter


s	IS	$2	$w$ unpacked

e	IS	$3

f	IS	$4

fl	IS	$5	The low 64 bits of $f$
carry	IS	$13	The shuttle between $f$ and $f_l$.

su	IS	$6	$u$ unpacked
eu	IS	$7
fu	IS	$8

sv	IS	$9	$v$ unpacked
ev	IS	$10
fv	IS	$11

d	IS	$12	$e_u - e_v$
t	IS	$14

%%%on
:Flot	ZSN	s,u,1		Set sign. 
	SET	f,0; NEG fl,u; CSNN fl,u,u	$(f,f_l) \is \left\vertical u\right\vertical/2^{64}$. 
	SET	e,64+52+1023	Set raw exponent.
	JMP	:Normalize	Normalize, round, and exit.\quad\slug\qquad
%%%off
