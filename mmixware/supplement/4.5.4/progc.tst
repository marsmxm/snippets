[[SET Driver



	LOC	#100
	GREG	@
N	OCTA	[[N]]
u	OCTA	[[u]]


Main	LDOU	$1,N
	PUSHJ	$0,Factor
	LDOU	$1,u
	CMP	$1,$0,$1
	ZSNZ	$255,$1,1
	TRAP	0,Halt,0

[[INCLUDE progc.mms]]

]]

[[TEST 1]]
[[SET N 5*7]]
[[SET u 5]]
[[Driver]]
[[END 1]]

[[TEST 2]]
[[SET N 5*3*17*19]]
[[SET u 3*19]]
[[Driver]]
[[END 2]]


[[TEST 3]]
[[SET N 8616460799]]
[[SET u 89681]]
[[Driver]]
[[END 3]]

	
	