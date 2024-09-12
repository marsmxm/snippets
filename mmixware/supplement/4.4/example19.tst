[[SET Driver

	LOC	Data_Segment
	GREG	@
[[Data]]
	LOC	#100
Main	IS	@
%%tex	u	$u$
u	IS	$0
%%tex	t	$t$
t	IS	$1


[[INCLUDE example19.mms ]]

	LDO	t,Binary
	CMP	t,t,u
	BNZ	t,Error

	SET	$255,0
	TRAP	0,Halt,0

Error	SET	$255,1
	TRAP	0,Halt,0

]]


[[TEST 1 ]]
[[SET Data
str	BYTE	"12345678"
Binary	OCTA	12345678
]]
[[Driver]]
[[END 1]]


[[TEST 2 ]]
[[SET Data
str	BYTE	"90900101"
Binary	OCTA	 90900101
]]
[[Driver]]
[[END 2]]

