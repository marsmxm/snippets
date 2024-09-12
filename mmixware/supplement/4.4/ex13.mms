%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	4.4/ex13.mms
%	Author:	M.Ruckert
%	Title:	Exercise 13, Conversion to string
u	IS	$0	Parameter
m	IS	$1
buffer	IS	$2

i	IS	$3	Local variables.
blocks	IS	$4
lines	IS	$5
k	IS	$6
ui	IS	$7
t	IS	$8
v	GREG	10*10*10*10*10*10*10*10*10

%%%on
ToString	4ADDU	u,m,u		^{4ADDU+<4ADDU> (times 4 and add unsigned)}		
	SET	lines,2
	SET	t,'.'			Start with a decimal point.
1H	STBU	t,buffer; INCL buffer,1
	SET	blocks,7
2H	SL	i,m,2; NEG i,i		$i\is 0$.
%%\mmsskip
	% $\langle\,$\rm  See exercise 4.3.1--13, lines |4.3.1progmson|--|4.3.1progmsoff| with $\.w. = \.u.$.$\,\rangle$
%%%off
	SET	k,0			$k\is 0$.
0H	LDTU	ui,u,i			Load $u_i$.
	MUL	ui,ui,v			$u_i\is u_i\times 10^9$.
	ADD 	ui,ui,k			$u_i\is u_i\times 10^9 + k$.
	STTU	ui,u,i	   		$u_i\is u_i \mod b$.
	SRU 	k,ui,32			$k\is \lfloor u_i/b \rfloor$.
	ADD	i,i,4			$i \is i+1$.
	PBN	i,0B			
%%%on
%%%\mmsskip\noalign{\breakhere}
	SLU     ui,k,32			 
%%%
	ADD     ui,ui,v			
	DIV     ui,ui,v		
	SET	i,8	                &$\smash{\left.\vcenter to 72pt{\vfil}\right\}}$\quad See 4.4--\eq(4${}^\prime$).
0H	4ADDU	ui,ui,ui		^{4ADDU+<4ADDU> (times 4 and add unsigned)}
	SLU 	ui,ui,1		
	SRU	t,ui,32 	
	ADD 	t,t,'0'			Convert to ASCII code.
	STB	t,buffer,0; INCL 	buffer,1 		
	ANDNMH	ui,#FFFF		^{ANDNMH+<ANDNMH> (bitwise and-not medium high wyde)}
	SUB	i,i,1	&$\smash{\left.\vcenter to 24pt{\vfil}\right\}}$\quad See 4.4--\eq(4${}^\prime$).
	PBNN	i,0B		
%%\mmsskip
	SUB	blocks,blocks,1
	SET	t,' '; STBU	t,buffer	Insert a space.
	INCL buffer,1			Advance to next block.
	BP	blocks,2B		
	SET	t,#a;	STBU	t,buffer	Insert a newline.
	INCL buffer,1
	SET	t,' '			Start next line with a space.
	SUB	lines,lines,1		Advance to next line.	
	BP	lines,1B	
%%\mmsskip
	SET 	t,0;	STBU	t,buffer	Terminate with a zero byte.
	POP	0,0			\slug
