[[SET Driver
       LOC	Data_Segment
       GREG	@
X      OCTA	[[x]]
N      OCTA	[[n]]



	LOC	#100
Main	LDO	$1,X
	LDO	$2,N
	PUSHJ	$0,A1

[[INCLUDE expect.mms "x^n" $0 [[xn]]]]

	SET	$255,0
	TRAP	0,Halt,0


[[INCLUDE xnmodws.mms ]]

[[INCLUDE print.mms]]

]]


[[TEST 1 ]]
[[SET x 3]]
[[SET n 2]]
[[SET xn 9]]

[[Driver]]
[[END 1]]


[[TEST 2 ]]
[[SET x 17]]
[[SET n 5]]
[[SET xn 17*17*17*17*17]]

[[Driver]]
[[END 2]]


[[TEST 3 ]]
[[SET x -17]]
[[SET n 5]]
[[SET xn -17*17*17*17*17]]

[[Driver]]
[[END 3]]


[[TEST 4 ]]
[[SET x -17]]
[[SET n 4]]
[[SET xn 17*17*17*17]]

[[Driver]]
[[END 4]]

