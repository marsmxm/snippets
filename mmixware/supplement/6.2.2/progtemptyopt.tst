[[SET Driver

	LOC	Data_Segment
	GREG	@
Rtotal	GREG	0
Head	OCTA	0,0
data	 	[[data]]
n	IS	[[n]]
	GREG	@
	LOC	#100

Pool	GREG	0

Main	SETH	Pool,(Pool_Segment>>(64-16))
	LDA	$2,data
	SET	$3,n
1H	LDA	$5,Head
	LDO	$6,$2,0
%	SET	$255,$6; 	PUSHJ	$255,:print:int; PUSHJ	$255,:print:nl

	GET	$0,rI		% get runtime
	PUSHJ	$4,:btree:Start
	GET	$1,rI	        % get runtime again
	SUB	$0,$0,$1
	SUB	$0,$0,5+5	GET,PUSHJ,POP,AVAIL
	ADD	Rtotal,Rtotal,$0
	[[unique]]

	[[findwhile]]


	ADD	$2,$2,8
	SUB	$3,$3,1
	BP	$3,1B
	SUB	$2,$2,8

	[[findafter]]
	
	[[Runtime]]
	

Done	SET	$255,0
	TRAP	0,Halt,0

Error	SET	$255,1
	TRAP	0,Halt,0
	
Missing GETA	$255,MI; 	TRAP	0,:Fputs,:StdErr
	LDO	$255,$3,0; 	PUSHJ	$255,:print:int; PUSHJ	$255,:print:nl
	JMP	Error
MI	BYTE	"Missing: ",0


AVAIL	SET	$0,Pool
	ADDU	Pool,Pool,3*8
	POP	1,0


[[INCLUDE progtemptyopt.mms]]
[[INCLUDE print.mms]]

]]

[[SET Runtime %]]

[[SET unique
	BNZ	$4,Error	on first run it should not find keys
]]

[[SET  find
	LDA	$5,data
2H	LDA	$8,Head
	LDO	$9,$5,0
	PUSHJ	$7,:btree:Start
	BZ	$7,Missing	on second run it should find all keys
	[[unique]]
	LDO	$8,$7,16
	LDO	$9,$5,0
	CMP	$8,$9,$8
	BNZ	$8,Error
	ADD	$5,$5,8
	CMP	$6,$5,$2
	BNP	$6,2B
]]

[[SET findwhile [[find]]]]
[[SET findafter %]]

[[TEST 1]]
[[SET Runtime	SET	$255,Rtotal; 	PUSHJ	$255,:print:int]]

[[SET data OCTA 1]]
[[SET n 1]]

[[Driver]]
[[END 1]]

[[TEST 2]]
[[SET data OCTA 1,2]]
[[SET n 2]]

[[Driver]]


[[END 2]]


[[TEST 3]]

[[SET data OCTA 2,1,5]]
[[SET n 3]]
[[Driver]]

[[END 3]]


[[TEST 4]]
[[COMMENT single rotation right ]]
[[SET data OCTA 1,2,5]]
[[SET n 3]]
[[Driver]]

[[END 4]]

[[TEST 5]]
[[COMMENT single rotation left]]

[[SET data OCTA 5,2,1]]
[[SET n 3]]
[[Driver]]

[[END 5]]

[[TEST 6]]

[[SET data OCTA 3,5,2,1]]
[[SET n 4]]
[[Driver]]

[[END 6]]

[[TEST 7]]
[[COMMENT double rotation left]]

[[SET data OCTA 3,1,6,4,5]]
[[SET n 5]]
[[Driver]]

[[END 7]]

[[TEST 8]]

[[SET Runtime 
	SET	$0,0
	[[INCLUDE runtime.mms :Rtotal $0 508 0]]
]]

[[SET data [[INCLUDE table1.mms]]]]
[[SET n 16]]
[[Driver]]

[[END 8]]

[[SET findafter [[find]]]]
[[SET findwhile %]]


[[TEST 9]]
[[SET Runtime 
	SET	$0,0
	[[INCLUDE runtime.mms :Rtotal $0 78550 0]]
]]

[[SET unique %]]
[[SET data [[INCLUDE r1000.mms]]]]
[[SET n 1000]]
[[Driver]]

[[END 9]]

[[TEST 10]]
[[SET Runtime 
	SET	$0,0
	[[INCLUDE runtime.mms :Rtotal $0 2457 0]]
]]

[[SET unique %]]
[[SET findafter %]]
[[SET findwhile %]]

[[SET data OCTA 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30]]
[[SET n 27]]
[[Driver]]

[[END 10]]

