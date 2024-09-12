[[SET Driver

	LOC	#100
[[INCLUDE print.mms]]
	PREFIX	:
e	IS	$0
u	IS	$1
v	IS	$2
c	IS	$3
test	IS	$4
i	IS	$5
d	IS	$6
t	IS	$7
signbit	GREG	(1<<63)

Main	IS	@

	[[seteps]]
	PUT	rE,e

	[[setd]]
	[[seti]]
	[[setu]]
	[[setv]]

Loop	BZ	u,Skip
	BZ	v,Skip
	FCMPE	c,u,v
%%%	[[printi :c]]
%%%	[[printsp]]
	SET	t+1,u
	SET	t+2,v
	PUSHJ	t,Fcmpe
	CMPU	test,t,c
	BNZ	test,Error

	XOR	u,u,signbit
	FCMPE	c,u,v
	SET	t+1,u
	SET	t+2,v
	PUSHJ	t,Fcmpe
	CMPU	test,t,c
	BNZ	test,Error

	XOR	v,v,signbit
	FCMPE	c,u,v
	SET	t+1,u
	SET	t+2,v
	PUSHJ	t,Fcmpe
	CMPU	test,t,c
	BNZ	test,Error

	XOR	u,u,signbit
	FCMPE	c,u,v
	SET	t+1,u
	SET	t+2,v
	PUSHJ	t,Fcmpe
	CMPU	test,t,c
	BNZ	test,Error

	XOR	v,v,signbit
Skip	FADD	v,v,d
	SUB	i,i,1
	BP	i,Loop

	BN	d,OK	
	[[setv]]
	SET	t,0
	FSUB	d,t,d	negate d
	[[seti]]
	JMP	Loop



OK	SET	$255,0
	TRAP	0,Halt,0

Error	SET	$255,1
	TRAP	0,Halt,0


[[INCLUDE fcmpe.mms]]


]]



[[SET seteps	FLOT	e,1; FLOT t,2; FDIV e,e,t  eps=1/2]] 

[[SET setu 	FLOT	u,4 ]]
[[SET setv	FLOT	v,4 ]]



[[TEST 1   ]]
[[SET setd FLOT d,1; FLOT t,4; FDIV d,d,t ]]
[[SET seti SET i,40]]
[[Driver]]
[[END 1]]


[[TEST 2   ]]
[[SET setd FLOT d,3; FLOT t,17; FDIV d,d,t ]]
[[SET seti SET i,50]]
[[Driver]]
[[END 2]]

