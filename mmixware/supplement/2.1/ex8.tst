[[SET Driver

	  LOC	Data_Segment
	  GREG	@
TOP	  OCTA	0F
0H	  OCTA	1F,1
1H	  OCTA	2F,2
2H	  OCTA	0,3

	  LOC	#100

NEXT	  IS 	0
x	  IS	$0
n	  IS	$1
t	  IS	$2


Main	  IS	@

[[INCLUDE ex8.mms]]
	  
	  CMP	t,n,3
	  BNZ	t,Fail

	  SET	$255,0
	  TRAP	0,Halt,0

Fail	  SET	$255,1
	  TRAP	0,Halt,0
	

]]	

[[TEST	1]]

[[Driver]]

[[END 1]]