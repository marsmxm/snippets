[[ Joint test for ex27 and ex 28 with findtag.mms ]]

[[SET Driver

	LOC	Data_Segment
	GREG	@
TAGS	OCTA	[[Tags]]
Empty	OCTA	[[Empty]]

m	IS	[[m]]

	LOC	#100
[[INCLUDE ex27.mms]]
[[INCLUDE ex28.mms]]
[[INCLUDE findtag.mms]]

	PREFIX	:
Main	PUSHJ	$255,Init
	
	[[Requests]]

	[[INCLUDE OctaEqual.mms :TAGS :tags ((1<<(:m-4-3))/8+1)]]

	[[Test]]
	
	
	SET	$255,0
	TRAP	0,Halt,0

Error	SET	$255,1
	TRAP	0,Halt,0
	

[[INCLUDE print.mms]]

]]

[[SET m 10]]

[[SET Request
	[[COMMENT register k result]]
	SET	[[1]]+1,[[2]]
	PUSHJ	[[1]],:Allocate
	BZ	[[1]],Error
	SUB	$255,[[1]],:base
	SET	[[1]]+1,[[3]]
	CMP	$255,$255,[[1]]+1
	BNZ	$255,Error
]]

[[SET Free
	[[COMMENT register P k]]
	SET	[[1]]+1,[[2]]
	SET	[[1]]+2,[[3]]
	PUSHJ	[[1]],:Free
]]

[[SET Test 

j	IS	$0
Aj	IS	$1
E	IS	$2
R	IS	$3
L	IS	$4
n	IS	$5
p	IS	$6
t	IS	$7
S	IS	:base

	SET	j,:m-4		Number of lists to test
	NEG	Aj,16		List head
	LDA	E,:Empty	Number of nodes in List
	ADDU	R,:base,4	Right
	ADDU	L,:base,8	Left


1H	LDO	n,E,0		Nodes in this list
	SET	p,Aj
3H	LDT	p,p,R		Next node
	CMP	t,Aj,p		Compare to head
	BZ	t,2F		Done with this list
	SUB	n,n,1
	BN	n,Error		Too many nodes in the list
	LDT	t,p,S		size
	CMP	t,t,Aj		check Size field
	BNZ	t,Error
	SET	t+1,p
	PUSHJ	t,:FindTag	
	AND	t,t,t+1		check tag=1
	BZ	t,Error
	JMP	3B

2H	BP	n,Error		Not enough nodes in the list 
	SUB	j,j,1
	SUB	Aj,Aj,16
	ADD	E,E,8
	BP	j,1B

]]

[[SET Reserved 
	[[COMMENT register value ]]
	SET	[[1]]+1,[[2]]
	PUSHJ	[[1]],:FindTag	
	AND	[[1]],[[1]],[[1]]+1		check tag=0
	BNZ	[[1]],Error
]]

[[SET Requests %]]


[[TEST 1]]
[[SET	Tags #8000000000000000,0]]
[[SET 	Empty	1,0,0,0,0,0 ]]

[[Driver]]
[[END 1]]



[[TEST 2]]
[[SET	Requests
	[[Request $0 10 0]]
]]
[[SET	Tags #0000000000000000,0]]
[[SET 	Empty	0,0,0,0,0,0 ]]

[[Driver]]
[[END 2]]



[[TEST 3]]
[[SET	Requests
	[[Request $0 9 0]]
	[[Reserved $0 0]]
]]
[[SET	Tags #0000000080000000,0]]
[[SET 	Empty	0,1,0,0,0,0 ]]


[[Driver]]
[[END 3]]


[[TEST 4]]
[[SET	Requests
	[[Request $0 9 0]]
	[[Free	$1 $0 9]]
]]
[[SET	Tags #8000000080000000,0]]
[[SET 	Empty	1,0,0,0,0,0 ]]


[[Driver]]
[[END 4]]

[[TEST 5]]
[[SET	Requests
	[[Request $0 9 0]]
	[[Free	$1 $0 9]]
	[[Request $0 10 0]]
	[[Free	$1 $0 10]]
]]
[[SET	Tags #8000000080000000,0]]
[[SET 	Empty	1,0,0,0,0,0 ]]


[[Driver]]
[[END 5]]

[[TEST 6]]
[[SET	Requests
	[[Request $0 9 0]]
	[[Request $1 9 #200]]
	[[Free	$2 $1 9]]
	[[Free	$1 $0 9]]
]]
[[SET	Tags #8000000080000000,0]]
[[SET 	Empty	1,0,0,0,0,0 ]]


[[Driver]]
[[END 6]]

[[TEST 7]]
[[SET	Requests
	[[Request $0 9 0]]
	[[Request $1 8 #200]]
	[[Free	$2 $1 8]]
	[[Free	$1 $0 9]]
]]
[[SET	Tags #8000000080008000,0]]
[[SET 	Empty	1,0,0,0,0,0 ]]


[[Driver]]
[[END 7]]

[[TEST 8]]
[[SET	Requests
	[[Request $0 9 0]]
	[[Request $1 8 #200]]
	[[Reserved $2 0]]
	[[Reserved $2 #200]]

]]
[[SET	Tags #0000000000008000,0]]
[[SET 	Empty	0,0,1,0,0,0 ]]


[[Driver]]
[[END 8]]

[[TEST 9]]
[[SET	Requests
	[[Request $0 9 0]]
	[[Request $1 7 #200]]
	[[Request $2 8 #300]]
	[[Free	$3 $1 7]]
	[[Reserved $3 #0]]
	[[Reserved $3 #300]]
]]
[[SET	Tags #0000000080800000,0]]
[[SET 	Empty	0,0,1,0,0,0 ]]


[[Driver]]
[[END 9]]

