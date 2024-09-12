[[SET Driver
	LOC	Data_Segment
	GREG	@
Top	IS	@
[[Tree]]

	LOC	#100

[[INCLUDE progsu.mms]]

Main	SET	$255,1

	LDA	$1,Top
	GETA	$2,V
	PUSHJ	$0,Inorder


	SET	$255,0
	TRAP	0,Halt,0

Fail	SET	$255,1
	TRAP	0,Halt,0

[[INCLUDE print.mms]]

V	GET	$1,rJ	
	LDO	$255,$0,Info; PUSHJ $255,print:int; PUSHJ $255,print:space
	PUT	rJ,$1
	POP	0,0	%Visit Node P



]]


[[TEST	1]]
[[SET Tree 
	OCTA	@|0,@|1,0	empty tree
]]
[[Driver]]
[[END 1]]

[[TEST	2]]
[[SET Tree 
0H	OCTA	@|0,1F,0
1H	OCTA	0B|1,0B|1,1	single node
]]
[[Driver]]
[[END 2]]

[[TEST	3]]
[[SET Tree 
0H	OCTA	@|0,1F,0
1H	OCTA	0B|1,2F,2	top node
2H	OCTA	1B|1,0B|1,1	left node
]]
[[Driver]]
[[END 3]]

[[TEST	4]]
[[SET Tree 
0H	OCTA	@|0,1F,0
1H	OCTA	2F,0B|1,1	top node
2H	OCTA	0B|1,1B|1,2	right node
]]
[[Driver]]
[[END 4]]

[[TEST	5]]
[[SET Tree 
0H	OCTA	@|0,1F,0
1H	OCTA	3F,2F,2	top node
2H	OCTA	1B|1,0B|1,1	left node
3H	OCTA	0B|1,1B|1,3	right node
]]
[[Driver]]
[[END 5]]

[[TEST	6]]
[[COMMENT empty tree]]
[[SET Tree 
9H	OCTA	@|0,0F,0
0H	OCTA	2F,1F,3	top node
1H	OCTA	0B|1,3F,2	topleft node
2H	OCTA	5F,4F,5	topright node
3H	OCTA	1B|1,9B|1,1	topleftleft node
4H	OCTA	2B|1,0B|1,4	toprightleft node
5H	OCTA	9B|1,6F,7	toprightright node
6H	OCTA	5B|1,2B|1,6	toprightrightleft node
]]
[[Driver]]
[[END 6]]
