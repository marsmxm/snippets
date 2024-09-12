[[SET DRIVER
	LOC	Data_Segment
	GREG	@
	[[INCLUDE keys.mms]]
	
	LOC (@|#FFF)+1
	GREG	@
Table	OCTA 0
	LOC Table+24*31
	
	BYTE "CANARY  CANARY  CANARY  CANARY  CANARY  CANARY  "

	LOC (@|#FFF)+1
	GREG	@
]]

[[SET DRIVER2
	LOC	#100
	
	[[INCLUDE hashmap.mms]]
	
Main	IS	@
	SET	$255,0	added this to get a working test. MR 6.8.2012
	TRAP	0,0,0
]]

[[COMMENT % vergleicht 1 mit 2, im fehlerfall returned 3 ]]
[[SET RegisterEqual
	SET	$255,[[2]]
	CMP	$255,[[1]],$255
	BZ	$255,1F
	SET	$255,[[3]]
	SWYM	42
	SET	$255,0
	TRAP	0,0,0
1H	IS	@		]]
	

[[TEST 1]]

	[[DRIVER]]

comp	OCTA 0,0,0			% 0

	OCTA 0,0,0			% 1

	BYTE "BE"			% 2
	OCTA 26*24
	OCTA 0202

	OCTA 0,0,0			% 3

	OCTA 0,0,0			% 4

	OCTA 5				% 5
	OCTA 30*24
	OCTA 0505

	OCTA 0,0,0			% 6
	OCTA 0,0,0			% 7
	OCTA 0,0,0			% 8
	OCTA 0,0,0			% 9
	OCTA 0,0,0			%10
	OCTA 0,0,0			%11
	OCTA 0,0,0			%12
	OCTA 0,0,0			%13
	OCTA 0,0,0			%14

	OCTA 15				%15
	OCTA 27*24
	OCTA 1515

	OCTA 0,0,0			%16
	OCTA 0,0,0			%17
	OCTA 0,0,0			%18
	OCTA 0,0,0			%19
	OCTA 0,0,0			%20
	OCTA 0,0,0			%21
	OCTA 0,0,0			%22
	OCTA 0,0,0			%23
	OCTA 0,0,0			%24
	OCTA 0,0,0			%25

	BYTE "THIS"			%26
	OCTA -1
	OCTA 0226

	OCTA 15+31*1			%27
	OCTA -1
	OCTA 1527

	OCTA 5+31*2			%28
	OCTA -1
	OCTA 0528

	OCTA 29				%29
	OCTA -1
	OCTA 2929

	OCTA 5+31*1			%30
	OCTA 28*24
	OCTA 0530

	BYTE "CANARY  CANARY  CANARY  CANARY  CANARY  CANARY  "

	[[DRIVER2]]

	% h=5  i=5
	SET	$1,5
	SET	$2,0505
	PUSHJ	$0,searchorinsert
[[RegisterEqual $0 :hm:RETURN_INSERT  101]]

	% h=29 i=29
	SET	$1,29
	SET	$2,2929
	PUSHJ	$0,searchorinsert
[[RegisterEqual $0 :hm:RETURN_INSERT  101]]
	
	% h=5 i=30	testet listen n=1
	SET	$1,5+31*1
	SET	$2,0530
	PUSHJ	$0,searchorinsert
[[RegisterEqual $0 :hm:RETURN_INSERT  101]]
	
	% h=5 i=28
	SET	$1,5+31*2
	SET	$2,0528
	PUSHJ	$0,searchorinsert
[[RegisterEqual $0 :hm:RETURN_INSERT  101]]
	
	% h=15 i=15
	SET	$1,15+31*0
	SET	$2,1515
	PUSHJ	$0,searchorinsert
[[RegisterEqual $0 :hm:RETURN_INSERT  101]]
	
	% h=15 i=27
	SET	$1,15+31*1
	SET	$2,1527
	PUSHJ	$0,searchorinsert
[[RegisterEqual $0 :hm:RETURN_INSERT  101]]
	
	% h=5 i=28 überschr vorher 0528
	SET	$1,5+31*2
	SET	$2,4267
	PUSHJ	$0,searchorinsert
[[RegisterEqual $0 :hm:RETURN_REPLACE  102]]
[[RegisterEqual $1 0528  103]]

	% h=5 i=28 überschr	vorher 4267
	SET	$1,5+31*2
	SET	$2,0528
	PUSHJ	$0,searchorinsert
[[RegisterEqual $0 :hm:RETURN_REPLACE  104]]
[[RegisterEqual $1 4267  105]]

	% h=2 i=2
	LDO	$1,kBE
	SET	$2,0202
	PUSHJ	$0,searchorinsert
[[RegisterEqual $0 :hm:RETURN_INSERT  101]]

	% h=2 i=26
	LDO	$1,kTHIS
	SET	$2,0226
	PUSHJ	$0,searchorinsert
[[RegisterEqual $0 :hm:RETURN_INSERT  101]]


	
[[INCLUDE OctaEqual.mms Table comp 31*3+6]]

	SET	$255,0
	TRAP	0,Halt,0

[[END 1]]

[[TEST 2]]

	[[DRIVER]]

	[[DRIVER2]]
	
	% h=5  i=5
	SET	$1,5
	SET	$2,0505
	PUSHJ	$0,searchorinsert

	SET	$255,0
	TRAP	0,:Halt,0
[[END 2]]

[[TEST 3]]

	[[DRIVER]]

	[[DRIVER2]]
	
	SET	$1,5+31*0
	SET	$2,0505
	PUSHJ	$0,searchorinsert
	
	SET	$1,5+31*1
	SET	$2,0505
	PUSHJ	$0,searchorinsert
	
	SET	$1,5+31*2
	SET	$2,0505
	PUSHJ	$0,searchorinsert

	SET	$255,0
	TRAP	0,:Halt,0
[[END 3]]


[[TEST 6]]

	[[DRIVER]]

	[[DRIVER2]]
	
	
	SET	$1,5+31*0
	SET	$2,0505
	PUSHJ	$0,searchorinsert
	
	SET	$1,5+31*1
	SET	$2,0505
	PUSHJ	$0,searchorinsert
	
	SET	$1,5+31*2
	SET	$2,0505
	PUSHJ	$0,searchorinsert

	
	SET	$1,5+31*3
	SET	$2,0505
	PUSHJ	$0,searchorinsert
	
	SET	$1,5+31*4
	SET	$2,0505
	PUSHJ	$0,searchorinsert
	
	SET	$1,5+31*5
	SET	$2,0505
	PUSHJ	$0,searchorinsert


	SET	$255,0
	TRAP	0,:Halt,0
[[END 6]]



[[TEST 12]]

	[[DRIVER]]

	[[DRIVER2]]
	
	
	SET	$1,5+31*0
	SET	$2,0505
	PUSHJ	$0,searchorinsert
	
	SET	$1,5+31*1
	SET	$2,0505
	PUSHJ	$0,searchorinsert
	
	SET	$1,5+31*2
	SET	$2,0505
	PUSHJ	$0,searchorinsert

	
	SET	$1,5+31*3
	SET	$2,0505
	PUSHJ	$0,searchorinsert
	
	SET	$1,5+31*4
	SET	$2,0505
	PUSHJ	$0,searchorinsert
	
	SET	$1,5+31*5
	SET	$2,0505
	PUSHJ	$0,searchorinsert

	
	SET	$1,5+31*6
	SET	$2,0505
	PUSHJ	$0,searchorinsert
	
	SET	$1,5+31*7
	SET	$2,0505
	PUSHJ	$0,searchorinsert

	
	SET	$1,5+31*8
	SET	$2,0505
	PUSHJ	$0,searchorinsert

	
	SET	$1,5+31*9
	SET	$2,0505
	PUSHJ	$0,searchorinsert

	
	SET	$1,5+31*10
	SET	$2,0505
	PUSHJ	$0,searchorinsert

	
	SET	$1,5+31*11
	SET	$2,0505
	PUSHJ	$0,searchorinsert

	SET	$255,0
	TRAP	0,:Halt,0
[[END 12]]


[[TEST 500]]

	LOC	Data_Segment
	GREG	@
Table	OCTA 0

	LOC	#100
	
	[[INCLUDE hashmap.mms]]
	
Main	IS	@

	[[INCLUDE 500inserts.mms]]
	SET	$255,0
	TRAP	0,:Halt,0

	
[[END 500]]


[[TEST 1000]]

	LOC	Data_Segment
	GREG	@
Table	OCTA 0

	LOC	#100
	
	[[INCLUDE hashmap.mms]]
	
Main	IS	@

	[[INCLUDE 1000inserts.mms]]

	SET	$255,0
	TRAP	0,:Halt,0
	
[[END 1000]]


[[TEST 1300]]

	LOC	Data_Segment
	GREG	@
Table	OCTA 0

	LOC	#100
	
	[[INCLUDE hashmap.mms]]
	
Main	IS	@

	[[INCLUDE 1300inserts.mms]]
	SET	$255,0
	TRAP	0,:Halt,0

	
[[END 1300]]
% vim: setf mmix
