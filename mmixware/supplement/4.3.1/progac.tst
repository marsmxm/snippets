[[SET Driver

	LOC	Data_Segment
	GREG	@
[[Data]]

	LOC	#100
Main	LDA	$1,U
	SET	$2,m
	LDA	$3,W
	SET	$4,n
	PUSHJ	$0,AddC

	[[INCLUDE OctaEqual.mms :W :R n+1]]
	
	TRAP	0,Halt,0	

[[INCLUDE progac.mms ]]
]]

[[TEST 1 ]]
[[SET Data
U	OCTA	1,2,3
	OCTA	4,5,6
m	IS	2
W	OCTA	5,7,9,10
n	IS	3
R	OCTA	5,7,9,0
]]
[[Driver]]
[[END 1]]


[[TEST 2 ]]
[[SET Data
U	OCTA	1,2,-1
	OCTA	4,5,-1
m	IS	2
W	OCTA	5,7,9,10
n	IS	3
R	OCTA	5,7,-2,1
]]
[[Driver]]
[[END 2]]



[[TEST 3 ]]
[[SET Data
U	OCTA	1,2,3
	OCTA	4,5,6
	OCTA	7,8,9
	OCTA	0,1,2
m	IS	4
W	OCTA	5,7,9,10
n	IS	3
R	OCTA	12,16,20,0
]]
[[Driver]]
[[END 3]]



[[TEST 4 ]]
[[SET Data
U	OCTA	1,0,1
	OCTA	4,-2,1
	OCTA	7,-2,1
	OCTA	0,1,1
m	IS	4
W	OCTA	5,7,9,10
n	IS	3
R	OCTA	12,-3,5,0
]]
[[Driver]]
[[END 4]]






[[TEST 5 ]]
[[SET Data
U	OCTA	-1,-1,3
	OCTA	1,-1,3
m	IS	2
W	OCTA	0,0,0,0
n	IS	3
R	OCTA	0,-1,7,0
]]
[[Driver]]
[[END 5]]

