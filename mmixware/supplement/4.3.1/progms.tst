[[SET Driver

	LOC	Data_Segment
	GREG	@

[[Data]]

W	TETRA	7,7,7,7,#DD

	LOC	#100
Main	LDA	$1,U
	LDTU	$2,v
	LDA	$3,W
	SET	$4,m
	PUSHJ	$0,MulS

	[[INCLUDE ByteEqual.mms :W :R m+1]]

	SET	$255,0
	TRAP	0,Halt,0	


[[INCLUDE progms.mms ]]

]]

[[TEST 1 ]]
[[SET Data
m	IS	3
v	TETRA	3
U	TETRA	2,0,1,#FF
R	TETRA	6,0,3,0,#EE
]]

[[Driver]]
[[END 1]]

[[TEST 2 ]]
[[SET Data
m	IS	10
v	TETRA	3
U	TETRA	1,2,3,4,5,6,7,8,9,0,#FF
	TETRA	0
R	TETRA	3,6,18,24,30,36,42,48,54,0,0,#EE
]]

[[Driver]]
[[END 2]]

[[TEST 3 ]]
[[SET Data
m	IS	3
v	TETRA	3
U	TETRA	12345,#FFFFFFFF,2,#FF
	TETRA	0
R	TETRA	3*12345,#FFFFFFFD,7,0,#EE
]]

[[Driver]]
[[END 3]]

