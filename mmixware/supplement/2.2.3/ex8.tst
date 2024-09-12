[[SET Driver
	  LOC	Data_Segment
	  GREG	@
List	  OCTA	1F
[[List]]

	  GREG	@
tsiL	  OCTA	[[Reverse]]

	  LOC	#100
[[INCLUDE ex8.mms]]


Main	  IS	@
	  LDA	$1,List
	  PUSHJ	$0,Revert

	  LDO	$0,List
	  LDA	$1,tsiL
	  JMP	1F

0H	  LDOU	$0,$0,0
	  ADDU	$1,$1,8

1H	  BZ	$0,Fail
	  LDO	$2,$0,8
	  LDO	$3,$1,0
	  CMP	$4,$2,$3
	  BNZ	$4,Fail
	  BNZ	$3,0B	List ends with zero.


	  SET	$255,0
	  TRAP	0,Halt,0

Fail	  SET	$255,1
	  TRAP	0,Halt,0

]]	

[[TEST	1]]
[[SET List
1H	  OCTA	2F,0
2H	  OCTA	3F,1
3H	  OCTA	0,2
]]
[[SET	Reverse 2,1,0 ]]

[[Driver]]

[[END 1]]


[[TEST	2]]
[[SET List
1H	  OCTA	2F,0
2H	  OCTA	0,1
]]
[[SET	Reverse 1,0 ]]

[[Driver]]

[[END 2]]


[[TEST	3]]
[[SET List
1H	  OCTA	0,0

]]
[[SET	Reverse 0 ]]

[[Driver]]

[[END 3]]


[[TEST	4]]
[[SET List
1H	  OCTA	2F,0
2H	  OCTA	3F,1
3H	  OCTA	4F,2
4H	  OCTA	5F,3
5H	  OCTA	6F,4
6H	  OCTA	0,5


]]
[[SET	Reverse 5,4,3,2,1,0 ]]

[[Driver]]

[[END 4]]
