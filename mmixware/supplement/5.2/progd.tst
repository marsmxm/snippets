
[[SET Driver

		LOC	Data_Segment
		GREG	@
Data		[[In]]
Size		IS	[[n]]	
u		IS	[[u]]
v		IS	[[v]]
		GREG	@	
Count		OCTA	0
		LOC	Count+(v-u+1)*8
		GREG	@
Output		OCTA	0
		LOC	Output+Size*8
		GREG	@
Sorted		[[Finish]]

		LOC	#100
Main		IS	@
		[[keyshift]]
		
		LDA	$2,Data
		LDA	$3,Count
		LDA	$4,Output
		SET	$5,Size
		SET	$6,u
		SET	$7,v
		GET	$0,:rI	
		PUSHJ	$1,Sort
		GET	$1,:rI

		[[Timing]]

		LDA	$1,Sorted
		LDA	$2,Output
		SET	$3,Size
		PUSHJ	$0,:Compare:Octa

		SET	$255,0 
		TRAP 0,Halt,0
Cycles		BYTE	9," cycles:",9,0,0

[[INCLUDE progd.mms]]
[[INCLUDE print.mms]]
[[INCLUDE compare.mms]]
]]
[[SET	keyshift % ]]

[[SET	u '2']]
[[SET	v '6']]
[[SET Timing %]]
[[COMMENT Timing [[INCLUDE runtime.mms $0 $1 0 5]]]]



[[TEST 1]]
[[SET In BYTE 0,"5aaaaaa",0,"2bbbbbb",0]]
[[SET n  1]]
[[SET Finish BYTE 0,"5aaaaaa",0,0]]

[[Driver]]
[[END 1]]

[[TEST 2]]

[[SET In BYTE 0,"5aaaaaa",0,"2bbbbbb",0]]
[[SET n  2]]
[[SET Finish BYTE 0,"2bbbbbb",0,"5aaaaaa",0]]

[[Driver]]
[[END 2]]

[[TEST 3]]

[[SET In BYTE 0,"2bbbbbb",0,"5aaaaaa",0]]
[[SET n  2]]
[[SET Finish BYTE 0,"2bbbbbb",0,"5aaaaaa",0]]
[[Driver]]
[[END 3]]

[[TEST 4]]

[[SET In BYTE 0,"5aaaaaa",0,"2bbbbbb",0,"5cccccc",0]]
[[SET n  3]]
[[SET Finish BYTE 0,"2bbbbbb",0,"5aaaaaa",0,"5cccccc",0]]

[[Driver]]
[[END 4]]

[[TEST 5]]

[[SET In BYTE 0,"5aaaaaa",0,"2bbbbbb",0,"6cccccc",0,"3dddddd",0]]
[[SET n  4]]
[[SET Finish BYTE 0,"2bbbbbb",0,"3dddddd",0,"5aaaaaa",0,"6cccccc",0]]

[[Driver]]
[[END 5]]

[[TEST 6]]

[[SET In BYTE 0,"2aaaaaa",0,"3bbbbbb",0,"2cccccc",0,"3dddddd",0]]
[[SET n  4]]
[[SET Finish BYTE 0,"2aaaaaa",0,"2cccccc",0,"3bbbbbb",0,"3dddddd",0]]

[[Driver]]
[[END 6]]

[[SET	keyshift
	SET	$0,Count*8
	LDA	$1,Data
	LDA	$3,Sorted
	JMP	0F

1H	LDOU	$2,$1,$0
	SL	$2,$2,48
	STOU	$2,$1,$0
	LDOU	$2,$3,$0
	SL	$2,$2,48
	STOU	$2,$3,$0

0H	SUB	$0,$0,8
	BNN	$0,1B
]]


[[TEST 7]]
[[SET	u 61]]
[[SET	v 909]]
[[SET n  16]]
[[SET In  [[INCLUDE table1.mms]]
	 OCTA 0
]]
[[SET Finish  [[INCLUDE table1s.mms]]
	 OCTA 0
]]
	[[COMMENT Data for 5.5 table 1]]
[[SET Timing [[INCLUDE runtime.mms $0 $1 7054 5]]]]
[[Driver]]
[[END 7]]



[[TEST 8]]
[[SET	u 0]]
[[SET	v #FFFF]]
[[SET n  1000]]
[[SET In  [[INCLUDE s1000.mms]]
	 OCTA 0
]]
[[SET Finish [[INCLUDE s1000s.mms]]
	 OCTA 0
]]
	[[COMMENT Data for 5.5 table 1]]
[[SET Timing [[INCLUDE runtime.mms $0 $1 539310 5]]]]
[[Driver]]
[[END 8]]
