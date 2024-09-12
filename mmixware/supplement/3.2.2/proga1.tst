[[TEST 1]]
	LOC	Data_Segment

X	OCTA	1,2,3,4,5,6,7,8,9,10
	OCTA	11,12,13,14,15,16,17,18,19,20
	OCTA	21,22,23,24,25,26,27,28,29,30
	OCTA	31,32,33,34,35,36,37,38,39,40
	OCTA	41,42,43,44,45,46,47,48,49,50
	OCTA	51,52,53,54,55




	LOC	#100

	[[INCLUDE proga1.mms]]


	PREFIX	:
Main	IS	@
	
	PUSHJ	$0,Random

	[[INCLUDE expect.mms "Random" $0 (24+55)]]

	PUSHJ	$0,Random

	[[INCLUDE expect.mms "Random" $0 (23+54)]]
	PUSHJ	$0,Random	22
	PUSHJ	$0,Random	21
	PUSHJ	$0,Random	20
	PUSHJ	$0,Random	19
	PUSHJ	$0,Random	18
	PUSHJ	$0,Random	17
	PUSHJ	$0,Random	16
	PUSHJ	$0,Random	15
	PUSHJ	$0,Random	14
	PUSHJ	$0,Random	13
	PUSHJ	$0,Random	12
	PUSHJ	$0,Random	11


	[[INCLUDE expect.mms "Random" $0 (11+42)]]
	PUSHJ	$0,Random	10
	PUSHJ	$0,Random	9
	PUSHJ	$0,Random	8
	PUSHJ	$0,Random	7
	PUSHJ	$0,Random	6
	PUSHJ	$0,Random	5
	PUSHJ	$0,Random	4
	PUSHJ	$0,Random	3
	PUSHJ	$0,Random	2
	PUSHJ	$0,Random	1

	[[INCLUDE expect.mms "Random" $0 (1+32)]]

	PUSHJ	$0,Random	55

	[[INCLUDE expect.mms "Random" $0 ((24+55)+31)]]




	SET	$255,0
	TRAP	0,Halt,0

[[INCLUDE print.mms]]


[[END 1]]


	