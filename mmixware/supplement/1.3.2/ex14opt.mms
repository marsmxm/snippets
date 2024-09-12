%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	1.3.2/ex14opt.mms
%	Author:	M.Ruckert
%	Title:	Exercise 14, The Date of Easter Sunday
	PREFIX :Easter:
y	IS     $0
g	IS     $1
c	IS     $2
x	IS     $3
z	IS     $4
d	IS     $5
e	IS     $6
n	IS     $7
t	IS     $9

%%%on
1H	GREG	970881267037344822   $2^{64}\!/19+2/19$
:Easter MULU	t,y,1B;	GET	t,:rH	     \ut E1. Golden number.\\^{Golden number}^{rH+rH (himult register)}^{Himult register}
	MUL	t,t,19
	SUB	g,y,t  
	ADD	g,g,1		$G\is Y\mod 19 +1$.
%%%
1H	GREG    184467440737095517   $2^{64}\!/100+84/100$
	MULU	t,y,1B; GET t,:rH		    	\ut E2. Century.\\
	ADD	c,t,1		$C\is \lfloor Y/100\rfloor+1$.
	2ADDU	x,c,c		\ut E3. Corrections.\\^{2ADDU+<2ADDU> (times 2 and add unsigned)}
	SRU	x,x,2		
	SUB	x,x,12		$X\is \lfloor 3C/4\rfloor-12$.
	8ADDU	z,c,5
1H	GREG	737869762948382065   $2^{64}\!/25-9/25$^{GREG+<GREG> (allocate global register)}
	MULU	t,z,1B; GET	z,:rH
	SUB	z,z,5		$Z\is \lfloor (8C+5)/25\rfloor-5$.
	4ADDU	d,y,y		\ut E4. Find Sunday.\\^{4ADDU+<4ADDU> (times 4 and add unsigned)}
	SRU	d,d,2
	SUB	d,d,x
	SUB	d,d,10		$D\is \lfloor 5Y/4\rfloor-X-10$.
	2ADDU	e,g,g		\ut E5. Epact.\\^{2ADDU+<2ADDU> (times 2 and add unsigned)}
	8ADDU	e,g,e
	ADD	e,e,20
	ADD	e,e,z
	SUB	e,e,x
1H	GREG	614891469123651721	$2^{64}\!/30-14/30$	
	MULU	t,e,1B; GET t,:rH
	MUL	t,t,30
	SUB	e,e,t			$E\is (11G+20+Z-X) \mod 30$.
%%%
	CMP	t,e,25
	BNZ	t,1F
	CMP	t,g,11	 
	ZSP	t,t,1		$\.t.\is G>11$. 
	JMP	2F
%%%
1H	CMP	t,e,24
	ZSZ	t,t,1		$\.t.\is E=24$.
2H	ADD	e,e,t		Increase $E$ if needed.
%%%
	NEG	n,44,e		\ut E6. Find full moon.\\ $N\is 44-E$.
	CMP	t,n,21
	ZSN	t,t,30		
	ADD	n,n,t		$N\is N+30$ if $N<21$.
%%%
	ADD	t,d,n		\ut E7. Advance to Sunday.\\
1H	GREG	2635249153387078803	 $2^{64}\!/7+5/7$
	MULU	t+1,t,1B; GET t+1,:rH
	MUL	t+1,t+1,7
	SUB	t,t,t+1
	ADD	n,n,7
	SUB	n,n,t		$N\is N+7-(D+N)\mod 7$.
%%%	
	CMP	t,n,31		\ut E8. Get month.\\
	BNP	t,1F		If $N>31$,
	SUB	$1,n,31		\quad return $N-31$
	SET	$0,4		\quad and April.
	POP	2,0
%%%
1H	SET	$1,n		Else return $N$
	SET	$0,3		\quad and March.
%%%
	POP	2,0		\slug
%%%off
	PREFIX	: