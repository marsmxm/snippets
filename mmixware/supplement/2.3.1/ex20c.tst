[[SET Driver
	LOC	Data_Segment
	GREG	@
Top	[[Tree]]

INFO	IS	16
Stack	OCTA	1F,0
1H	OCTA	1F,0
1H	OCTA	1F,0
1H	OCTA	1F,0
1H	OCTA	1F,0
1H	OCTA	1F,0
1H	OCTA	1F,0
1H	OCTA	1F,0
1H	OCTA	1F,0
1H	OCTA	1F,0
1H	OCTA	1F,0
1H	OCTA	1F,0
1H	OCTA	0,0

	LOC	#100

[[INCLUDE ex20c.mms]]

Main	SET	$255,1

	LDOU	$1,Top
	GETA	$2,V
	LDA	$3,Stack
	PUSHJ	$0,Inorder


	SET	$255,0
	TRAP	0,Halt,0

Overflow JMP	Fail
Fail	SET	$255,1
	TRAP	0,Halt,0

[[INCLUDE print.mms]]

V	GET	$1,rJ	
	LDO	$255,$0,INFO; PUSHJ $255,print:int; PUSHJ $255,print:space
	PUT	rJ,$1
	POP	0,0	%Visit Node P



]]


[[TEST	1]]

[[SET Tree 
	OCTA	0	empty tree
]]

[[Driver]]

[[END 1]]


[[TEST	2]]
[[COMMENT empty tree]]
[[SET Tree 
	OCTA	1F
1H	OCTA	0,0,1	single node


]]

[[Driver]]

[[END 2]]


[[TEST	3]]
[[COMMENT empty tree]]
[[SET Tree 
	OCTA	1F
1H	OCTA	1F,0,2	top node
1H	OCTA	0,0,1	left node


]]

[[Driver]]

[[END 3]]

[[TEST	4]]
[[COMMENT empty tree]]
[[SET Tree 
	OCTA	1F
1H	OCTA	0,1F,1	top node
1H	OCTA	0,0,2	right node
]]
[[Driver]]
[[END 4]]

[[TEST	5]]
[[COMMENT empty tree]]
[[SET Tree 
	OCTA	1F
1H	OCTA	1F,2F,2	top node
1H	OCTA	0,0,1	left node
2H	OCTA	0,0,3	right node
]]
[[Driver]]
[[END 5]]

[[TEST	6]]
[[COMMENT empty tree]]
[[SET Tree 
	OCTA	0F
0H	OCTA	1F,2F,3	top node
1H	OCTA	3F,0,2	topleft node
2H	OCTA	4F,5F,5	topright node
3H	OCTA	0,0,1	topleftleft node
4H	OCTA	0,0,4	toprightleft node
5H	OCTA	6F,0,7	toprightright node
6H	OCTA	0,0,6	toprightrightleft node


]]
[[Driver]]
[[END 6]]