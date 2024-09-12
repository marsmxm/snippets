[[SET Driver

	LOC	Data_Segment
	GREG	@
Rtotal	GREG	0
Head	OCTA	0,0,0
data	 	[[data]]
n	IS	[[n]]
	GREG	@

avail	GREG	0
Pool	OCTA	0,0,0

	LOC	#100


Main	LDA	$1,Pool	
	SET	$3,n+10
1H	STOU	avail,$1
	SET	avail,$1
	ADDU	$1,$1,3*8
	SUB	$3,$3,1
	BNN	$3,1B
	
	LDA	$2,data
	SET	$3,n
1H	LDA	$5,Head
	LDO	$6,$2,0
%	SET	$255,$6; 	PUSHJ	$255,:print:int; PUSHJ	$255,:print:nl

	GET	$0,rI		% get runtime
	PUSHJ	$4,Search
	GET	$1,rI	        % get runtime again
	SUB	$0,$0,$1
	SUB	$0,$0,5
	ADD	Rtotal,Rtotal,$0
	[[unique]]

	[[findwhile]]


	ADD	$2,$2,8
	SUB	$3,$3,1
	BP	$3,1B
	SUB	$2,$2,8

	[[findafter]]
	
	[[Runtime]]
	
	LDOU	$4,Head
	LDO	$5,Head+8
	PUSHJ	$3,:Verify
	BNZ	$3,Error

	[[TestHeight]]


Done	SET	$255,0
	TRAP	0,Halt,0

Error	SET	$255,1
	TRAP	0,Halt,0
	
Missing GETA	$255,MI; 	TRAP	0,:Fputs,:StdErr
	LDO	$255,$3,0; 	PUSHJ	$255,:print:int; PUSHJ	$255,:print:nl
	JMP	Error
MI	BYTE	"Missing: ",0

Overflow GETA	$255,1F; 	TRAP	0,:Fputs,:StdErr
	JMP	Error
1H	BYTE	"Overflow",10,0

	
	PREFIX	:Verify:
P	IS	$0
h	IS	$1
l	IS	$2
r	IS	$3
rJ	IS	$4
t	IS	$5
	% 	return nonzero if Error found

:Verify	BZ	P,0F
	BZ	h,0F
	SET	l,1
	SET	r,1
	BEV	P,1F
	AND	t,P,3
	CMP	t,t,1
	CSZ	l,t,2
	CSNZ	r,t,2

1H	GET	rJ,:rJ
	LDOU	t+1,P,0		%right
	SUB	t+2,h,r
	PUSHJ	t,:Verify
	BNZ	t,2F
	LDOU	t+1,P,8		%left
	SUB	t+2,h,l
	PUSHJ	t,:Verify
	BNZ	t,2F
	PUT	:rJ,rJ
	SET	$0,0
	POP	1,0
	
0H	CMP	$0,P,h	%empty
	POP	1,0

2H	SET	$0,t
	PUT	:rJ,rJ
	POP	1,0


[[INCLUDE proga.mms]]
[[INCLUDE search.mms]]
[[INCLUDE print.mms]]

]]

[[SET Runtime %]]

[[SET unique
	BNZ	$4,Error	on first run it should not find keys
]]

[[SET TestHeight
	LDO	$2,Head+8
	[[INCLUDE expect.mms "Height" $2 [[height]]]]
]]



[[SET  find
	LDA	$5,data
2H	LDA	$8,Head
	LDO	$9,$5,0
	PUSHJ	$7,:search:Search
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
[[SET height 1]]

[[Driver]]
[[END 1]]

[[TEST 2]]
[[SET data OCTA 1,2]]
[[SET n 2]]
[[SET height 2]]

[[Driver]]


[[END 2]]


[[TEST 3]]

[[SET data OCTA 2,1,5]]
[[SET n 3]]
[[SET height 2]]
[[Driver]]

[[END 3]]


[[TEST 4]]
[[COMMENT single rotation right ]]
[[SET data OCTA 1,2,5]]
[[SET n 3]]
[[SET height 2]]
[[Driver]]

[[END 4]]

[[TEST 5]]
[[COMMENT single rotation left]]

[[SET data OCTA 5,2,1]]
[[SET n 3]]
[[SET height 2]]
[[Driver]]

[[END 5]]

[[TEST 6]]

[[SET data OCTA 3,5,2,1]]
[[SET n 4]]
[[SET height 3]]
[[Driver]]

[[END 6]]

[[TEST 7]]
[[COMMENT double rotation left]]

[[SET data OCTA 3,1,6,4,5]]
[[SET n 5]]
[[SET height 3]]
[[Driver]]

[[END 7]]




[[TEST 8]]

[[SET Runtime 
	SET	$0,0
	[[INCLUDE runtime.mms :Rtotal $0 1150 0]]
]]

[[SET data [[INCLUDE table1.mms]]]]
[[SET n 16]]
[[SET height 5]]
[[Driver]]

[[END 8]]

[[SET findafter [[find]]]]
[[SET findwhile %]]


[[TEST 9]]
[[SET Runtime 
	SET	$0,0
	[[INCLUDE runtime.mms :Rtotal $0 129613 0]]
]]

[[SET unique %]]
[[SET data [[INCLUDE r1000.mms]]]]
[[SET n 1000]]
[[SET height 12]]
[[Driver]]

[[END 9]]

[[TEST 10]]
[[SET unique %]]
[[SET data [[INCLUDE r10000.mms]]]]
[[SET n 10000]]
[[SET height 16]]
[[Driver]]

[[END 10]]


[[TEST 11]]

[[SET Runtime 
	SET	$0,0
	[[INCLUDE runtime.mms :Rtotal $0 2460 0]]
]]
[[SET TestHeight %]]
[[SET unique %]]
[[SET findafter %]]
[[SET findwhile %]]



[[SET data OCTA 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30]]
[[SET n 27]]
[[Driver]]

[[END 11]]