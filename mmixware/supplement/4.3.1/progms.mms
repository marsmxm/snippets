%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	4.3.1/progms.mms
%	Author:	M. Ruckert
%	Title:	Exercise 13, Multiplication with a single digit number.

	PREFIX	:Classic:

u	IS	$0	Parameter.
v	IS	$1
w	IS	$2
n	IS	$3

k	IS	$4
wi	IS	$5
i	IS	$6
t	IS	$7
%%%on
:MulS	4ADDU 	u,n,u; 4ADDU w,n,w	 1 &^{4ADDU+<4ADDU> (times 4 and add unsigned)}
	SL	i,n,2; 	NEG	i,i	 1 &$i\is 0$.			 
	SET	k,0			 1 &$k\is 0$.\lineref|4.3.1progmson|
0H	LDTU	wi,u,i			 N &$w_i\is u_i$.
	MUL	wi,wi,v			 N &$w_i\is u_i\times v$.
	ADD 	wi,wi,k			 N &$w_i\is u_i\times v + k$.
	STTU	wi,w,i	   		 N &$w_i\is w_i \mod b$.
	SRU	k,wi,32			 N &$k\is \lfloor w_i/b \rfloor$.
	ADD	i,i,4			 N &$i \is i+1$.
	PBN	i,0B			 N\bg{1} &Loop in $i$.\lineref|4.3.1progmsoff|
	STTU	k,w,0			 1 &$w_n\is k$.
%%%
	POP	0,0			   &\slug
%%%rt 4.3.1progms.rt & (16N +8)\upsilon + (2N+1)\mu
%%%off