[[SET Driver

	LOC	Data_Segment
	GREG	@
Decimal	BYTE	[[Decimal]]
        OCTA	#AABBCC0000DDEEFF
Binary	OCTA	[[Binary]]
        OCTA	#AABBCC0000DDEEFF

	LOC	#100
Main	IS	@

j	IS	$0
u	IS	$1
u10	IS	$2
x	IS	$3
t	IS	$4
m	IS	[[m]]

	LDA	u10,Decimal

[[INCLUDE method1b.mms ]]

	LDOU    t,Binary
	CMPU	t,t,u
	BNZ	t,Error  	


	SET     $255,0
	TRAP	0,Halt,0

Error	SET     $255,1
	TRAP	0,Halt,0


]]

[[TEST 1 ]]
[[SET m	10]]	
[[SET Binary    1234567890]]
[[SET Decimal   0,9,8,7,6,5,4,3,2,1]]

[[Driver]]

[[END 1]]



[[TEST 2 ]]

[[SET m		5]]
[[SET Binary    20001]]
[[SET Decimal   1,0,0,0,2]]

[[Driver]]

[[END 2]]

