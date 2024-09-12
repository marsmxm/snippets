[[SET Driver
RLINK	IS 0
LLINK    IS 8
INFO	IS 16

	LOC	Data_Segment
	GREG	@
Tree	IS	@
[[Tree]]



	LOC	#100
Main	SET	$255,1
	LDA	$2,Tree
	PUSHJ	$1,Copy
	LDA	$2,Tree
	PUSHJ	$0,TreeEqual


OK	SET	$255,0; TRAP 0,Halt,0
Fail	SET	$255,1; TRAP 0,Halt,0

[[INCLUDE treeequal.mms]]
[[INCLUDE allocate.mms]]
[[INCLUDE ex13.mms]]

]]

[[TEST 1]]
[[SET Tree
0H	OCTA	@,0,12345	empty tree
]]
[[Driver]]
[[END 1]]

[[TEST 2]]
[[SET Tree
0H	OCTA	@,1F,12345	root
1H	OCTA	0B|1,0,56789    one node
]]
[[Driver]]
[[END 2]]

[[TEST 3]]
[[SET Tree
0H	OCTA	@,1F,12345	root
1H	OCTA	2F,0,56789      node
2H	OCTA	0B|1,0,345	right node
]]
[[Driver]]
[[END 3]]

[[TEST 4]]
[[SET Tree
0H	OCTA	@,1F,12345	root
1H	OCTA	2F,3F,56789     node
2H	OCTA	0B|1,0,345	right node
3H	OCTA	1B|1,0,345	left node
]]
[[Driver]]
[[END 4]]

[[TEST 5]]
[[SET Tree
0H	OCTA	@,1F,12345	root
1H	OCTA	2F,3F,56789     node
2H	OCTA	0B|1,0,2	right node
3H	OCTA	1B|1,4F,3	left node
4H	OCTA	3B|1,0,4	left left node
]]
[[Driver]]
[[END 5]]

[[TEST 6]]
[[SET Tree
0H	OCTA	@,1F,12345	root
1H	OCTA	2F,3F,56789     node
2H	OCTA	0B|1,0,2	right node
3H	OCTA	1B|1,4F,3	left node
4H	OCTA	5F,0,4	        left left node
5H	OCTA	3B|1,0,4	left left right node
]]
[[Driver]]
[[END 6]]

[[TEST 7]]
[[SET Tree
0H	OCTA	@,1F,12345	root
1H	OCTA	2F,3F,56789     node
2H	OCTA	0B|1,0,2	right node
3H	OCTA	1B|1,4F,3	left node
4H	OCTA	5F,0,4	        left left node
5H	OCTA	6F,0,4	left left right node
6H	OCTA	3B|1,0,4	left left right right node
]]
[[Driver]]
[[END 7]]

[[TEST 8]]
[[SET Tree
0H	OCTA	@,1F,12345	root
1H	OCTA	2F,3F,56789     node
2H	OCTA	0B|1,0,2	right node
3H	OCTA	1B|1,4F,3	left node
4H	OCTA	5F,0,4	        left left node
5H	OCTA	6F,0,5  	left left right node
6H	OCTA	3B|1,7F,6	left left right right node
7H	OCTA	6B|1,0,7	left left right right node
]]
[[Driver]]
[[END 8]]



