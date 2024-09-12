[[SET Driver
       LOC	Data_Segment
       GREG	@
L      IS	32*8
       % The data from Table 1
R1     IS	@+1
R2     IS	R1+L
R3     IS	R2+L
R4     IS	R3+L
R5     IS	R4+L
R6     IS	R5+L
R7     IS	R6+L
R8     IS	R7+L
R9     IS	R8+L
R10    IS	R9+L
R11    IS	R10+L
R12    IS	R11+L

       OCTA	0,R2,R3,0,0,0,R4,0,R5,R6,0,0,0,0; BYTE "NOT"; OCTA R7,0,0,0,0,R8,0,0,R9,0; BYTE "YOU"
       LOC	R2-1
       BYTE	"A"; OCTA 0,0,0,0,0,0,0,0,0,0,0,0,0; BYTE "AND"; OCTA 0,0,0; BYTE "ARE",0,0,0,0,0,"AS",0,0,0,0,0,0,"AT"
       LOC	R3-1
       OCTA	0,0,0,0,0; BYTE "BE"; OCTA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0; BYTE "BUT"; OCTA 0,0,0; BYTE "BY"
       LOC	R4-1
       OCTA	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0; BYTE "FOR"; OCTA 0,0; BYTE "FROM"
       LOC	R5-1
       OCTA	0,R10,0,0,0,R11,0,0,0; BYTE "HIS"

       LOC	R11-1
       BYTE	"HE"

       OCTA	0	Align to octabyte
       GREG	@
Key    IS	@
0H     BYTE	[[Key]],0; LOC  (0B+7)&~7



       LOC	#100
k      IS	$0
t      IS	$1
Main   LDA	t+1,R1
       LDOU	t+2,Key
       PUSHJ	t,Start
       LDOU	k,Key

       [[Test]]

OK     SET	$255,0
       TRAP	0,Halt,0

Fail   SET	$255,1
       TRAP	0,Halt,0

[[INCLUDE progt.mms ]]

]]

[[SET Equal LDOU t,t,0; CMP t,t,k; BNZ t,Fail]]
[[SET Unequal BNZ t,Fail]]

[[TEST 1 ]]
[[SET Key "A" ]]
[[SET Test [[Equal]]]]
[[Driver]]
[[END 1]]

[[TEST 2 ]]
[[SET Key "B" ]]
[[SET Test [[Unequal]]]]
[[Driver]]
[[END 2]]


[[TEST 3 ]]
[[SET Key "AND" ]]
[[SET Test [[Equal]]]]
[[Driver]]
[[END 3]]

[[TEST 4 ]]
[[SET Key "AS" ]]
[[SET Test [[Equal]]]]
[[Driver]]
[[END 4]]


[[TEST 5 ]]
[[SET Key "ALL" ]]
[[SET Test [[Unequal]]]]
[[Driver]]
[[END 5]]

[[TEST 6 ]]
[[SET Key "BE" ]]
[[SET Test [[Equal]]]]
[[Driver]]
[[END 6]]

[[TEST 7 ]]
[[SET Key "BUT" ]]
[[SET Test [[Equal]]]]
[[Driver]]
[[END 7]]


[[TEST 8 ]]
[[SET Key "FOR" ]]
[[SET Test [[Equal]]]]
[[Driver]]
[[END 8]]


[[TEST 9 ]]
[[SET Key "HE" ]]
[[SET Test [[Equal]]]]
[[Driver]]
[[END 9]]
