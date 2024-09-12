[[SET Driver

	LOC	Data_Segment
	GREG	@
Rtotal	GREG	0
m	IS	[[m]]
	OCTA	0	Table is preceeded by empty key
Table	OCTA	0
	LOC	Table+8*m
	GREG	@
Hash	OCTA	Table
	TETRA	m,m-1
data	 	[[data]]
n	IS	[[n]]
	LOC	#100

Main	LDA	$2,data
	SET	$3,n

1H	LDA	$5,Hash
	LDO	$6,$2,0
	GET	$0,rI		% get runtime
	PUSHJ	$4,Start
	GET	$1,rI	        % get runtime again
	SUB	$0,$0,$1
	SUB	$0,$0,5		GET,PUSHJ,POP
	ADD	Rtotal,Rtotal,$0

	[[overflow]]
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

Overflow GETA	$255,OV; 	TRAP	0,:Fputs,:StdErr
	LDO	$255,$3,0; 	PUSHJ	$255,:print:int; PUSHJ	$255,:print:nl
	JMP	Error
OV	BYTE	"Overflow: ",0

Unique GETA	$255,UQ; 	TRAP	0,:Fputs,:StdErr
	LDO	$255,$3,0; 	PUSHJ	$255,:print:int; PUSHJ	$255,:print:nl
	JMP	Error
UQ	BYTE	"Not unique: ",0


[[INCLUDE progd.mms]]
[[INCLUDE print.mms]]

]]

[[SET Runtime %]]

[[SET overflow
        BN	$4,Overflow
]]

[[SET unique
	BNZ	$4,Unique	on first run it should not find keys
]]

[[SET  find
	LDA	$5,data
2H	LDA	$8,Hash
	LDO	$9,$5,0
	PUSHJ	$7,Start
	BZ	$7,Missing	on second run it should find all keys
	LDO	$8,$7,0
	LDO	$9,$5,0
	CMP	$8,$9,$8
	BNZ	$8,Error
	ADD	$5,$5,8
	CMP	$6,$5,$2
	BNP	$6,2B
]]

[[SET findwhile [[find]]]]
[[SET findafter %]]

[[SET m 7]]

[[TEST 1]]

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

[[SET data OCTA [[m]],[[m]]+1,2*[[m]]+1]]
[[SET n 3]]
[[Driver]]

[[END 3]]


[[TEST 4]]
[[SET data OCTA [[m]]-1,2*[[m]]-1,[[m]]-2]]
[[SET n 3]]
[[Driver]]

[[END 4]]

[[TEST 5]]
[[SET data OCTA [[m]]-2,[[m]]-1,2*[[m]]-1]]
[[SET n 3]]
[[Driver]]

[[END 5]]

[[TEST 6]]

[[SET data OCTA 7,6,5,4,3,10]]
[[SET n 6]]
[[Driver]]

[[END 6]]

[[TEST 7]]
[[SET overflow 
        BN	$4,Done
]]

[[SET data OCTA 7,6,5,4,3,2,1]]
[[SET n 7]]
[[Driver]]

[[END 7]]


[[TEST 8]]
[[SET Runtime 
	SET	$0,0
	[[INCLUDE runtime.mms :Rtotal $0 1861 0]]
]]
[[SET m 17]]
[[SET data [[INCLUDE table1.mms]]]]
[[SET n 16]]
[[Driver]]

[[END 8]]

[[SET findafter [[find]]]]
[[SET findwhile %]]


[[TEST 9]]
[[SET Runtime 
	SET	$0,0
	[[INCLUDE runtime.mms :Rtotal $0 144957 0]]
]]

[[SET unique %]]
[[SET data [[INCLUDE r1000.mms]]]]
[[SET n 1000]]
[[SET m 1009]]
[[Driver]]

[[END 9]]

[[TEST 10]]
[[SET Runtime 
	SET	$0,0
	[[INCLUDE runtime.mms :Rtotal $0 103622 0]]
]]

[[SET unique %]]
[[SET data [[INCLUDE r1000.mms]]]]
[[SET n 1000]]
[[SET m 1409]]
[[Driver]]

[[END 10]]

[[TEST 11]]
[[SET Runtime 
	SET	$0,0
	[[INCLUDE runtime.mms :Rtotal $0 1028216 0]]
]]

[[SET unique %]]
[[SET data [[INCLUDE r10000.mms]]]]
[[SET n 10000]]
[[SET m 15401]]
[[Driver]]

[[END 11]]

