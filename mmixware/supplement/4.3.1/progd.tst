[[SET Driver

	PREFIX	:
	GREG	@
W	OCTA	0


	LOC	#100
Main	LDA	$0,Base
	SET	$1,k
	
1H	ADDU	$3,$0,U
	ADDU	$4,$0,V
	LDA	$5,W
	SET	$6,m+n
	SET	$7,n
	PUSHJ	$2,:Div

	SET	$3,$0
	PUSHJ	$2,:Check
	
	ADDU	$0,$0,size
	SUB	$1,$1,1
	BP	$1,1B
	SET	$255,0
	TRAP	0,Halt,0	

	PREFIX	:Check:

:Check	IS	@
	SET	$255,$0
	[[INCLUDE OctaEqual.mms :W      $255,:Q :m+1]]
	[[INCLUDE OctaEqual.mms $255,:U $255,:R :m+:n]]
	POP	0,0


	PREFIX :LeadingZeros:
	% Count leading zeros see exercise 43. in Section $1.3.1^\prime$ 
x	IS     $0	Parameter
magic	IS     $1	Local Variables
xm1	IS     $2

:LeadingZeros	SETL    magic,#4080
	INCML	magic,#1020
	INCMH	magic,#0408
	INCH	magic,#0102
	MOR	x,x,magic; MOR x,magic,x	Reverse $x$.
	SUBU	xm1,x,1; SADD $0,xm1,x   Count trailing zeros.
	POP	1,0

[[INCLUDE shiftleft.mms]]
[[INCLUDE shiftright.mms]]

[[INCLUDE progd.mms]]
]]


[[TEST 1]]
	LOC	Data_Segment
	GREG	@

[[INCLUDE progd.a.mms]]

[[Driver]]

[[END 1]]
 
[[TEST 2]]
	LOC	Data_Segment
	GREG	@

[[INCLUDE progd.b.mms]]

[[Driver]]

[[END 2]]

[[TEST 3]]
	LOC	Data_Segment
	GREG	@

[[INCLUDE progd.d.mms]]

[[Driver]]

[[END 3]]

[[TEST 7]]
	LOC	Data_Segment
	GREG	@

[[INCLUDE progd.data.mms]]

[[Driver]]

[[END 7]]