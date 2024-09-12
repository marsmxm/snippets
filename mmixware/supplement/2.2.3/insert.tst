[[SET Driver
	  LOC	Data_Segment
	  GREG	@
T	  OCTA	1F
1H	  OCTA	2F,2
2H	  OCTA	0,3

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

[[INCLUDE insert.mms]]


Main	  IS	@
	  LDA	avail,Free
	  SET	$1,1
	  PUSHJ	$0,Insert
	  
	  SET	$255,0
	  TRAP	0,Halt,0

Overflow  JMP	Fail

Fail	  SET	$255,1
	  TRAP	0,Halt,0

]]	

[[TEST	1]]

[[Driver]]

[[END 1]]