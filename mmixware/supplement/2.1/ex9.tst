[[SET Driver


[[INCLUDE ex9.mms]]

Main	  IS	@
	  
	  GETA	$1,First
	  PUSHJ	$0,PrintPile

	  SET	$255,0
	  TRAP	0,Halt,0

Fail	  SET	$255,1
	  TRAP	0,Halt,0
	
	  GREG	@
	  
	  OCTA 0		Alignment
First	  OCTA 2F
	  BYTE #80,1,10," 10 C"
	
2H	  OCTA 3F
	  BYTE #00,4,03,"  3 S"
	 
3H	  OCTA 0
	  BYTE #00,2,02,"  2 D"


]]	

[[TEST	1]]

[[Driver]]

[[END 1]]