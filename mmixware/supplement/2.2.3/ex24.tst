[[SET Driver

		LOC	Data_Segment		Defined in the test framework

		GREG	@
		PREFIX	:Tsort:
Fin		IS	3
Fout		IS	4
InName		BYTE	[[Input]]
		BYTE	0
OutName		BYTE	[[Output]]
		BYTE	0
InOpen		OCTA	InName,:BinaryRead
OutOpen		OCTA	OutName,:BinaryWrite
BufSize		IS	256*2*4			
Buffer	OCTA	0			
		LOC	Buffer+BufSize
		GREG	@
IOArgs		OCTA	Buffer,BufSize
:Data		[[Data]]
		LOC	:Data+BufSize	Fake input buffer
		GREG	@
Sentinel	OCTA	0		Terminates input buffer
:Sorted		[[Sorted]]	

Base		OCTA	0		Last OCTA in data segement.

		LOC	#100

[[INCLUDE ex24.mms]]

		PREFIX	:
Main		PUSHJ	$0,Tsort
		
		[[Test]]

		SET	$255,0
		TRAP	0,Halt,0

[[INCLUDE print.mms]]

:Println	GET	$1,:rJ
		SET	$255,$0
		PUSHJ	$255,:print:int
		PUSHJ	$255,:print:nl
		PUT	:rJ,$1
		POP	0,0
]]

[[SET Input "data.in"]]
[[SET Output "data.out"]]
[[SET Test [[INCLUDE TetraEqual.mms :Data :Sorted [[n]]]]]]



[[TEST 1]]
[[SET n 3]]
[[SET Data	TETRA	0,[[n]],1,2,1,3,0,0]]
[[SET Sorted	TETRA	1,3,2,0]]
[[Driver]]
[[END 1]]

[[TEST 2]]
[[SET n 9]]
[[SET Data	TETRA	0,[[n]],9,2,3,7,7,5,5,8,8,6,4,6,1,3,7,4,9,5,2,8,0,0]]
[[SET Sorted	TETRA	9,1,2,3,7,4,5,8,6,0]]
[[Driver]]
[[END 2]]

[[TEST 3]]
[[SET n 5]]
[[SET Data	TETRA	0,[[n]],1,2,2,3,3,4,4,2,3,5,1,4,0,0]]
[[SET Sorted	TETRA	1,0]]
[[SET Test [[INCLUDE TetraEqual.mms :Data :Sorted 1]]]]
[[Driver]]
[[END 3]]

[[TEST 4]]
[[SET n 9]]
[[SET Data	TETRA	0,[[n]],9,2,3,7,7,5,5,8,8,6,4,6,1,3,7,4,9,5,2,8,9,1,6,9,0,0]]
[[SET Sorted	TETRA	9,2,3,7,5,8,6,0]]
[[SET Test %]]
[[Driver]]
[[END 4]]
