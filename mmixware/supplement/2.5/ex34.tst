[[SET Driver

avail	GREG	0
base	GREG	0
limit	GREG	0
use	GREG	0

Range	IS	#4000

	LOC	#100

Main	SETH	$0,#4000
	LDOU	base,$0,0	first octa of available space
	SET	limit,base
	INCL	limit,Range&#FFFF
	INCML	limit,(Range>>16)&#FFFF
	SET	use,0
	ADDU	base,base,16
	SET	avail,base

	[[Requests]]

	PUSHJ	$255,:GC

	[[Test]]
	
	SET	$255,0
	TRAP	0,Halt,0

Error	SET	$255,1
	TRAP	0,Halt,0
	

[[INCLUDE ex34.mms]]
[[INCLUDE print.mms]]

]]

[[SET Request
	[[COMMENT register size k]]
	SET	[[1]]+1,[[2]]
	SET	[[1]]+2,[[3]]
	PUSHJ	[[1]],:Allocate
]]

[[SET Test %]]
[[SET Requests %]]

[[TEST 1]]
[[SET Test
	[[INCLUDE expect.mms "USE" :use 0]]
	[[INCLUDE RegisterEqual.mms :avail :base]]
]]

[[Driver]]
[[END 1]]

[[TEST 2]]
[[SET	Requests
	[[Request $0 20 0]]
	SET	:use,$0
]]

[[SET Test
	[[INCLUDE RegisterEqual.mms :use $0]]
	ADDU	$1,:base,24+16	
	[[INCLUDE RegisterEqual.mms :avail $1]]
]]

[[Driver]]
[[END 2]]

[[TEST 3]]
[[SET	Requests
	[[Request $0 20 0]]
	[[Request $1 20 0]]
	SET	:use,$0
]]

[[SET Test
	[[INCLUDE RegisterEqual.mms :use :base]]
	ADDU	$2,:base,24+16	
	[[INCLUDE RegisterEqual.mms :avail $2]]
]]

[[Driver]]
[[END 3]]

[[TEST 4]]
[[SET	Requests
	[[Request $0 20 0]]
	[[Request $1 20 0]]
	SET	:use,$1
]]

[[SET Test
	[[INCLUDE RegisterEqual.mms :use :base]]
	ADDU	$2,:base,24+16	
	[[INCLUDE RegisterEqual.mms :avail $2]]
]]

[[Driver]]
[[END 4]]

[[TEST 5]]
[[SET	Requests
	[[Request $0 30 0]]
	[[Request $1 20 0]]
	[[Request $2 40 0]]
	SET	:use,$1
]]

[[SET Test
	[[INCLUDE RegisterEqual.mms :use :base]]
	ADDU	$3,:base,24+16	
	[[INCLUDE RegisterEqual.mms :avail $3]]
]]

[[Driver]]
[[END 5]]

[[TEST 6  testing NULL Links]]
[[SET	Requests
	[[Request $0 30 16]]
	[[Request $1 20 8]]
	[[Request $2 40 32]]
	SET	:use,$1
]]

[[SET Test
	[[INCLUDE RegisterEqual.mms :use :base]]
	ADDU	$3,:base,24+16	
	[[INCLUDE RegisterEqual.mms :avail $3]]
]]

[[Driver]]
[[END 6]]


[[TEST 7  collapsing two unused nodes]]
[[SET	Requests
	[[Request $0 30 16]]
	[[Request $1 40 32]]
	[[Request $2 20 8]]
	SET	:use,$2
]]

[[SET Test
	[[INCLUDE RegisterEqual.mms :use :base]]
	ADDU	$3,:base,24+16	
	[[INCLUDE RegisterEqual.mms :avail $3]]
]]

[[Driver]]
[[END 7]]

[[TEST 8  collapsing two unused nodes removing third]]
[[SET	Requests
	[[Request $0 30 16]]
	[[Request $1 40 32]]
	[[Request $2 20 8]]
	[[Request $3 10 8]]
	SET	:use,$2
]]

[[SET Test
	[[INCLUDE RegisterEqual.mms :use :base]]
	ADDU	$4,:base,24+16	
	[[INCLUDE RegisterEqual.mms :avail $4]]
]]

[[Driver]]
[[END 8]]

[[TEST 9  keeping two nodes]]
[[SET	Requests
	[[Request $0 20 16]]
	[[Request $1 40 32]]
	[[Request $2 20 8]]
	[[Request $3 10 8]]
	SET	:use,$2
	STOU	$0,:use,0	link node 0 to node 2
]]

[[SET Test
	ADDU	$4,:base,24+16	
	[[INCLUDE RegisterEqual.mms :use $4]]
	ADDU	$4,:base,(24+16)*2	
	[[INCLUDE RegisterEqual.mms :avail $4]]
]]

[[Driver]]
[[END 9]]

[[TEST 10  keeping two cyclic nodes]]
[[SET	Requests
	[[Request $0 20 16]]
	[[Request $1 40 32]]
	[[Request $2 20 8]]
	[[Request $3 10 8]]
	SET	:use,$2
	STOU	$0,:use,0	link node 0 to node 2
	STOU	:use,$0,0	link node 2 to node 0
	STOU	$0,$0,8 	link node 0 to node 0

]]

[[SET Test
	ADDU	$4,:base,24+16	
	[[INCLUDE RegisterEqual.mms :use $4]]
	ADDU	$4,:base,(24+16)*2	
	[[INCLUDE RegisterEqual.mms :avail $4]]
]]

[[Driver]]
[[END 10]]


