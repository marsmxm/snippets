%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	4.4/example19.mms
%	Author:	M. Ruckert
%	Title:	Exercise 19, Conversion von ASCII to binary
%%%
%%%on
ascii	GREG	#3030303030303030	\."00000000".
m1	GREG	#FF00FF00FF00FF00
m2	GREG	#FFFF0000FFFF0000
m3	GREG	#FFFFFFFF00000000
%%\mmsskip
	LDO	u,str
	SUBU	u,u,ascii
	AND	t,u,m1
	SUBU	u,u,t
	4ADDU	t,t,t; SRU t,t,8-1	$\.t.\is\.t.\times 10/2^8$.^{4ADDU+<4ADDU> (times 4 and add unsigned)}
	ADD	u,u,t
%%\mmsskip
	AND	t,u,m2
	SUBU	u,u,t
	4ADDU	t,t,t;	4ADDU	t,t,t; SRU t,t,16-2 	$\.t.\is\.t.\times 100/2^{16}$.
	ADD	u,u,t
%%\mmsskip	
	AND	t,u,m3
	SUBU	u,u,t
	4ADDU	t,t,t; 4ADDU t,t,t; 4ADDU t,t,t
	4ADDU	t,t,t; SRU	t,t,32-4	$\.t.\is\.t.\times 10000/2^{32}$.
	ADD	u,u,t  				\slug
%%%off

