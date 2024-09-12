[[SET Driver
	LOC	Data_Segment
	GREG	@
XData	OCTA	[[X]]
cData	OCTA	[[c]]
Vtable	OCTA	0


	LOC	#100

x	GREG	0
y	GREG	0
V	GREG	Vtable
a	GREG	0
c	GREG	0
j	IS	$0

	PREFIX	:
Main	IS	@
	SET	a,1
	LDO	c,cData
	LDO	x,XData

	SET	j,256*8
1H	SUB	j,j,8
	STO	x,V,j
	[[INCLUDE ../3.2.1.1/modw.mms]]
	BP	j,1B
	
	SET	y,x
	
	[[INCLUDE progr.mms]]

	[[INCLUDE expect.mms "Y" :y [[Y1]]]]

	[[INCLUDE progr.mms]]

	[[INCLUDE expect.mms "Y" :y [[Y2]]]]

	SET	$255,0
	TRAP	0,Halt,0

[[INCLUDE print.mms]]
]]


[[TEST 1]]
[[SET c 1]]
[[SET X 1]]
[[SET Y1 256]]
[[SET Y2 258]]

[[Driver]]
[[END 1]]


[[TEST 2]]
[[SET c #0001000000000000]]
[[SET X #0001000000000000]]
[[SET Y1 (255<<48)]]
[[SET Y2 (256<<48)]]

[[Driver]]
[[END 2]]



	