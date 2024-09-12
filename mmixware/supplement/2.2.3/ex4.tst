[[SET Driver
	  LOC	Data_Segment
	  GREG	@
List	  OCTA	1F
1H	  OCTA	2F,1
2H	  OCTA	0,2

avail	  GREG	0
Free	  OCTA	1F,0
1H	  OCTA	0,0

poolmax	  GREG	0
seqmin	  GREG	0

Pool	  IS	@
	  LOC	#100


[[INCLUDE ex4.mms]]


Main	  IS	@
	  LDA	poolmax,Pool
	  ADDU	seqmin,poolmax,#80
	  LDA	avail,Free
	  PUSHJ	$0,Allocate
	  BZ	$0,Fail
	  PUSHJ	$0,Allocate
	  BZ	$0,Fail
	  PUSHJ	$0,Allocate
	  BZ	$0,Fail

	  SET	$255,0
	  TRAP	0,Halt,0

Overflow  JMP	Fail
Underflow  JMP	Fail

Fail	  SET	$255,1
	  TRAP	0,Halt,0

]]	

[[TEST	1]]

[[Driver]]

[[END 1]]