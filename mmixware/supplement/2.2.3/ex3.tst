[[SET Driver
	  LOC	Data_Segment
	  GREG	@
List	  OCTA	1F
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

[[INCLUDE ex3.mms]]


Main	  IS	@
	  LDA	avail,Free
	  LDA	$1,List
	  PUSHJ	$0,Delete
	  JMP	Underflow

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