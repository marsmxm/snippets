[[SET Driver
	LOC	Data_Segment
	GREG	@
Top	[[Tree]]
	GREG
Sorted	[[Sorted]]

	GREG	@
Out	OCTA	0

	LOC	#100

[[INCLUDE ex22.mms]]

	PREFIX	:
Main	SET	$255,1

	[[mkTree]]

	LDOU	$1,Top
	GETA	$2,V
	PUSHJ	$0,Inorder

	[[INCLUDE OctaEqual.mms Sorted Out [[n]] ]]

	SET	$255,0
	TRAP	0,Halt,0

Overflow JMP	Fail
Fail	SET	$255,1
	TRAP	0,Halt,0

[[INCLUDE print.mms]]

INFO	IS	16
V	IS	@
%	GET	$1,rJ	
%	LDO	$255,$0,INFO; PUSHJ $255,print:int; PUSHJ $255,print:space
%	PUT	rJ,$1

n	GREG	0
	LDO	$1,$0,INFO
	LDA	$2,Out
	STO	$1,$2,n
	ADD	n,n,8

	POP	0,0	%Visit Node P

	PREFIX	:Insert:

P	IS	$0	pointer to pointer to root node
x	IS	$1	number to insert
Q	IS	$2	
rJ	IS	$3
y	IS	$4
t	IS	$5

RLINK   IS      0
LLINK   	IS      8
INFO    IS      16

:Insert GET	rJ,:rJ
	JMP	0F
%%%
2H	LDO	y,Q,INFO
	CMP	t,x,y
	ZSN	t,t,LLINK  t\is RLINK or LLINK
	ADDU	P,Q,t     P is address of RLINK(Q) or LLINK(Q)
%%%
0H	LDO	Q,P
	BNZ	Q,2B	Add new node if $Q=\Lambda$.
%%%
	PUSHJ	t,:Allocate  Insert new node at P.
	STCO	0,t,RLINK
	STCO	0,t,LLINK
	STO	x,t,INFO
	STOU	t,P
%%%
	PUT	:rJ,rJ
	POP	0,0

	PREFIX	:Allocate:
Free	GREG	0

:Allocate  SETH	$0,(:Pool_Segment>>(64-16))
	   ADDU	$0,$0,Free
	   ADDU Free,Free,24
	   POP	1,0
	   
	   PREFIX :

]]

[[SET mkTree % ]]

[[TEST	1]]

[[SET Tree 
	OCTA	0	empty tree
]]

[[SET n 0]]
[[SET Sorted OCTA	0 ]]
[[Driver]]

[[END 1]]


[[TEST	2]]
[[COMMENT empty tree]]
[[SET Tree 
	OCTA	1F
1H	OCTA	0,0,1	single node


]]
[[SET n 1]]
[[SET Sorted OCTA	1 ]]

[[Driver]]

[[END 2]]


[[TEST	3]]
[[COMMENT empty tree]]
[[SET Tree 
	OCTA	1F
1H	OCTA	0,1F,2	top node
1H	OCTA	0,0,1	left node


]]
[[SET n 2]]
[[SET Sorted OCTA	1,2 ]]

[[Driver]]

[[END 3]]

[[TEST	4]]
[[COMMENT empty tree]]
[[SET Tree 
	OCTA	1F
1H	OCTA	1F,0,1	top node
1H	OCTA	0,0,2	right node
]]
[[SET n 2]]
[[SET Sorted OCTA	1,2 ]]

[[Driver]]
[[END 4]]

[[TEST	5]]
[[COMMENT empty tree]]
[[SET Tree 
	OCTA	1F
1H	OCTA	2F,1F,2	top node
1H	OCTA	0,0,1	left node
2H	OCTA	0,0,3	right node
]]
[[SET n 3]]
[[SET Sorted OCTA	1,2,3 ]]

[[Driver]]
[[END 5]]

[[TEST	6]]
[[COMMENT empty tree]]
[[SET Tree 
	OCTA	0F
0H	OCTA	2F,1F,3	top node
1H	OCTA	0,3F,2	topleft node
2H	OCTA	5F,4F,5	topright node
3H	OCTA	0,0,1	topleftleft node
4H	OCTA	0,0,4	toprightleft node
5H	OCTA	0,6F,7	toprightright node
6H	OCTA	0,0,6	toprightrightleft node


]]
[[SET n 7]]
[[SET Sorted OCTA	1,2,3,4,5,6,7 ]]

[[Driver]]
[[END 6]]

[[TEST 7]]

[[SET Tree 
      OCTA	0 
]]

[[SET mkTree

      GETA	$0,1F
      SET	$1,1000*8
2H    SUB	$1,$1,8
      
      LDA	$3,Top
      LDO	$4,$0,$1      
      PUSHJ	$2,:Insert
      BP	$1,2B
      JMP	3F

      OCTA	0	align to octa
1H    IS	@
      [[INCLUDE	r1000.mms]]
3H    IS	@

]]
[[SET n 1000]]
[[SET Sorted  [[INCLUDE	r1000s.mms]]
]]

[[Driver]]

[[END 7]]