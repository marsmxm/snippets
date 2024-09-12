[[SET Driver

	LOC	Data_Segment
	GREG	@
Dir	TETRA	0
	LOC	Dir+#1000
	TETRA	20,#1024,#100c|1			0,1,2
	TETRA	30,#1048|1			3,4
	TETRA	200,#1034,#1000,#102C|1		5,6,7,8
	TETRA	100,#1014|1			9,A
	TETRA	60,#1000|1			B,C
	TETRA	200,#0000,#1024,#100C,#102C|1	D,E,F,10,11
	TETRA	20,#102C|1			12,13
	GREG	@

Start	TETRA	#100c

Solution TETRA	2400,#100C
	TETRA	2430,#1048
	TETRA	2450,#102C
	TETRA	2510,#1000
	TETRA	2530,#1014
	TETRA	2730,#0000

Stack	OCTA	#1014
	OCTA	#1048



	LOC	#100

Main	LDA	$1,Dir
	LDA	$2,Stack
	SET	$3,[[n]]
	SET	$4,[[mloc]]
	LDTU	$5,Start

	PUSHJ	$0,Ex27

	[[INCLUDE TetraEqual.mms :Stack :Solution 12]]]

	SET	$255,0; TRAP 0,Halt,0

[[INCLUDE ex27.mms]]

]]

[[SET n 2]]
[[SET mloc 2400]]

[[TEST 1]]
[[Driver]]
[[END 1]]
	