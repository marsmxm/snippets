[[SET Driver

	LOC	Data_Segment
	GREG	@

[[Data]]

	GREG	@
	OCTA	#ABCD00000000EEFF
WW	OCTA	0	

	LOC	#100
Main	LDA	$1,U
	LDA	$2,V
	LDA	$3,WW
	SET	$4,n
	PUSHJ	$0,:Add

	[[INCLUDE OctaEqual.mms W WW (n+1)]]

	SET	$255,0
	TRAP	0,Halt,0	

Error	SET	$255,1
	TRAP	0,Halt,0	


[[INCLUDE progb.mms ]]

]]




[[TEST 1 ]]
[[SET Data
U	OCTA	4,5,6
V	OCTA	1,2,3
W	OCTA	5,7,9,0
n	IS	3
]]

[[Driver]]
[[END 1]]


[[TEST 2 ]]
[[SET Data
U	OCTA	   -1,-1,3
V	OCTA	   -1,-1,3
W	OCTA	   -2,-1,7,0
n	IS	3
]]

[[Driver]]
[[END 2]]


[[TEST 3 ]]
[[SET Data
U	OCTA	   #8000000000000000,#8000000000000000
V	OCTA	   #8000000000000000,#8000000000000000
W	OCTA	   0,1,1
n	IS	2
]]

[[Driver]]
[[END 3]]



[[TEST 4 ]]
[[SET Data
U	OCTA	   -1,-1,-1
V	OCTA	   5,0,0
W	OCTA	   4,0,0,1
n	IS	3
]]

[[Driver]]
[[END 4]]
