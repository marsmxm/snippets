[[SET Driver
	  LOC	Data_Segment
	  GREG	@
T	  OCTA	1F
1H	  OCTA	2F,1
2H	  OCTA	0,2

avail	  GREG	0
Free	  OCTA	1F,0
1H	  OCTA	1F,0
1H	  OCTA	1F,0
1H	  OCTA	1F,0
1H	  OCTA	1F,0
1H	  OCTA	1F,0
1H	  OCTA	1F,0
1H	  OCTA	1F,0
1H	  OCTA	0,0

	  LOC	#100

[[INCLUDE delete.mms]]


Main	  IS	@
	  LDA	avail,Free
	  PUSHJ	$0,Delete
	  CMP	$1,$0,1
	  BNZ	$1,Fail
	  
	  SET	$255,0
	  TRAP	0,Halt,0

Overflow   JMP	Fail
Underflow  JMP	Fail

Fail	  SET	$255,1
	  TRAP	0,Halt,0

]]	

[[TEST	1]]

[[Driver]]

[[END 1]]