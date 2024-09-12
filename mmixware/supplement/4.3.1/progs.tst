[[SET Driver

	LOC	Data_Segment
	GREG	@

[[Data]]

	GREG	@
WW	OCTA	0	

	LOC	#100
Main	LDA	$1,U
	LDA	$2,V
	LDA	$3,WW
	SET	$4,n
	PUSHJ	$0,:Sub

	[[INCLUDE OctaEqual.mms W WW n]]

	SET	$255,0
	TRAP	0,Halt,0	

Error	SET	$255,1
	TRAP	0,Halt,0	


[[INCLUDE progs.mms ]]

]]




[[TEST 1 ]]
[[SET Data
U	OCTA	4,5,6
V	OCTA	1,2,3
W	OCTA	3,3,3
n	IS	3
]]

[[Driver]]
[[END 1]]


[[TEST 2 ]]
[[SET Data
U	OCTA	   0,0,0,17
V	OCTA	   0,1,0,0
W	OCTA	   0,-1,-1,16
n	IS	4
]]

[[Driver]]
[[END 2]]


[[TEST 3 ]]
[[SET Data
U	OCTA	   0,6,19
V	OCTA	   1,0,0
W	OCTA	   -1,5,19
n	IS	3
]]

[[Driver]]
[[END 3]]



[[TEST 4 ]]
[[SET Data
U	OCTA	   -1,-1,-1
V	OCTA	   5,0,0
W	OCTA	   -6,-1,-1
n	IS	3
]]

[[Driver]]
[[END 4]]
