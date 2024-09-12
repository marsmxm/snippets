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
	SET	$4,m
	SET	$5,n
	PUSHJ	$0,:Mul

	[[INCLUDE OctaEqual.mms W WW (n+m)]]

	SET	$255,0
	TRAP	0,Halt,0	

Error	SET	$255,1
	TRAP	0,Halt,0	


[[INCLUDE progm.mms ]]

]]




[[TEST 1 ]]
[[SET Data

U	OCTA	2,0,3,#FF00FF
m	IS	3
V	OCTA	1,0,0,0,1,#DD00DD
n	IS	5
W	OCTA	2,0,3,0,2,0,3,0,#CC00CC
]]

[[Driver]]
[[END 1]]


[[TEST 2 ]]
[[SET Data

U	OCTA	2,0,3,#FF00FF
m	IS	3
V	OCTA	5,0,0,0,7,#DD00DD
n	IS	5
W	OCTA	10,0,15,0,14,0,21,0,#CC00CC
]]

[[Driver]]
[[END 2]]


[[TEST 3 ]]
[[SET Data

U	OCTA	2,0,3,0,1,#FF00FF
m	IS	5
V	OCTA	5,0,0,0,7,#DD00DD
n	IS	5
W	OCTA	10,0,15,0,5+14,0,21,0,7,0,#CC00CC
]]

[[Driver]]
[[END 3]]


[[TEST 4 ]]
[[SET Data

U	OCTA	1<<63,0,1,#FF00FF
m	IS	3
V	OCTA	2,0,3,#DD00DD
n	IS	3
W	OCTA	0,1,2+(1<<63),1,3,0,#CC00CC
]]

[[Driver]]
[[END 4]]


[[TEST 5 ]]
[[SET Data

U	OCTA	4,4,4,#FF00FF
m	IS	3
V	OCTA	-1,-1,-1,#DD00DD
n	IS	3
W	OCTA	-4,-5,-5,3,4,4,#CC00CC
]]

[[Driver]]
[[END 5]]