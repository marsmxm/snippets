%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	3.6/ex1.mms
%	Author:	M.Ruckert
%	Title:	Exercise 1, Subroutine RandInt
	PREFIX	:RandInt:
%%%on
x	GREG			
a	IS      6364136223846793005 See Section 3.3.4, Table 1, line 26.
c	IS	2009		\MMIX/
k	IS	$0		Parameter
t	IS	$1		Temporary variable
%%%
:RandInt SETH	t,(a>>48)&#FFFF	%Load constant $a$.^{SETH+<SETH> (set high wyde)}
	INCMH	t,(a>>32)&#FFFF %^{INCMH+<INCMH> (increase by medium high wyde)}
	INCML	t,(a>>16)&#FFFF %^{INCML+<INCML> (increase by medium low wyde)}
	INCL	t,a&#FFFF 	%^{INCL+<INCL> (increase by low wyde)}
	MULU	x,x,t		$ X \is aX  \mod m$.
	INCL    x,c    		$ X \is (aX + c ) \mod m$.
	MULU	t,x,k		$ (\.rH.,\.t.) \is Xk $.^{rH+rH (himult register)}^{Himult register}
	GET	t,:rH		$\.t. \is \lfloor Xk/m \rfloor$.
	ADD	$0,t,1		Return $\lfloor Xk/m \rfloor+1$.
	POP  1,0		\slug
%%%off