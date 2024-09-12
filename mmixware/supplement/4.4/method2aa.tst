[[SET Driver

	LOC	Data_Segment
	GREG	@
Decimal	BYTE	0
	LOC	Decimal+32
Binary	TETRA	[[Binary]]
        OCTA	#AABBCC0000DDEEFF
Solution BYTE	[[Decimal]]
	 BYTE	#AB

	LOC	#100
Main	IS	@

j	IS	$0
u10	IS	$1
u	IS	$2
x	IS	$3
t	IS	$4
	LDA	u10,Decimal
	LDTU	u,Binary

[[INCLUDE method2aa.mms ]]

[[INCLUDE ByteEqual.mms :Decimal :Solution 9]]

	SET     $255,0
	TRAP	0,Halt,0

]]

[[TEST 1 ]]

[[SET Binary    123456789]]
[[SET Decimal   9,8,7,6,5,4,3,2,1]]

[[Driver]]

[[END 1]]



[[TEST 2 ]]

[[SET M		5]]
[[SET Binary    20001]]
[[SET Decimal   1,0,0,0,2,0,0,0,0]]

[[Driver]]

[[END 2]]

