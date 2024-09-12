[[TEST 1]]
	LOC	Data_Segment

X	OCTA	1,2,3,4,5,6,7,8,9,10
	OCTA	11,12,13,14,15,16,17,18,19,20
	OCTA	21,22,23,24,25,26,27,28,29,30
	OCTA	31,32,33,34,35,36,37,38,39,40
	OCTA	41,42,43,44,45,46,47,48,49,50
	OCTA	51,52,53,54,55


y	GREG	X-8

	LOC	#100

	[[INCLUDE ex25.mms]]

[[SET RANDOM 
	SUB	j,j,8
	PBP	j,1F
	PUSHJ	j+1,Random55
	SET	j,55*8
1H	LDOU	$0,y,j
]]

	PREFIX	:
j	IS	$1

Main	IS	@
	SET	j,0
	
	[[RANDOM]]

	[[INCLUDE expect.mms "Random" $0 (24+55)]]

	[[RANDOM]]

	[[INCLUDE expect.mms "Random" $0 (23+54)]]
	[[RANDOM]]	%22
	[[RANDOM]]	%21
	[[RANDOM]]	%20
	[[RANDOM]]	%19
	[[RANDOM]]	%18
	[[RANDOM]]	%17
	[[RANDOM]]	%16
	[[RANDOM]]	%15
	[[RANDOM]]	%14
	[[RANDOM]]	%13
	[[RANDOM]]	%12
	[[RANDOM]]	%11


	[[INCLUDE expect.mms "Random" $0 (11+42)]]
	[[RANDOM]]	%10
	[[RANDOM]]	%9
	[[RANDOM]]	%8
	[[RANDOM]]	%7
	[[RANDOM]]	%6
	[[RANDOM]]	%5
	[[RANDOM]]	%4
	[[RANDOM]]	%3
	[[RANDOM]]	%2
	[[RANDOM]]	%1

	[[INCLUDE expect.mms "Random" $0 (1+32)]]

	[[RANDOM]]	%55

	[[INCLUDE expect.mms "Random" $0 ((24+55)+31)]]


	SET	$255,0
	TRAP	0,Halt,0

[[INCLUDE print.mms]]


[[END 1]]


	