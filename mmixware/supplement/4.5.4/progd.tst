[[SET Driver



	LOC	#100
	GREG	@
N	OCTA	[[N]]
u	OCTA	[[u]]

Q	GREG	@
	BYTE	0
	LOC	@+16


Main	LDOU	$1,N
	PUSHJ	$0,MkTables
	LDOU	$1,N
	PUSHJ	$0,Factor
	LDOU	$1,u

[[INCLUDE expect.mms "Factor" $0 [[u]]]]

	SET	$255,0
	TRAP	0,Halt,0

[[INCLUDE progd.mms]]
[[INCLUDE print.mms]]

]]



	
[[TEST 1]]
[[SET N 13*17]]
[[SET u 13]]
[[Driver]]
[[END 1]]





	
[[TEST 2]]
[[SET N 89681*1001]]
[[SET u 1001]]
[[Driver]]
[[END 2]]



	
[[TEST 3]]
[[SET N 2717]]
[[SET u 19]]
[[Driver]]
[[END 3]]

	
	
[[TEST 4]]
[[SET N 391]]
[[SET u 17]]
[[Driver]]
[[END 4]]

	
	
[[TEST 5]]
[[SET N 7*11*13*23]]
[[SET u 11*13]]
[[Driver]]
[[END 5]]

	
[[TEST 6]]
[[SET N 7*11*13*19*17*23]]
[[SET u 19*11*13]]
[[Driver]]
[[END 6]]


[[TEST 7]]
[[SET N 8616460799]]
[[SET u 89681]]
[[Driver]]
[[END 7]]

	
		