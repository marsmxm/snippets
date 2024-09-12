		PREFIX	:Values:
vcount		GREG	0
:Values		CMP	$0,vcount,10
		BN	$0,Initial

		GET	$0,:rJ
%%%
		PUSHJ	$1,Random
		DIVU	$1,$1,5
		GET	:fi,:rR
		SET	$255,:fi; PUSHJ $255,:print:int; PUSHJ $255,:print:nl
%%%
1H		PUSHJ	$1,Random
		DIVU	$1,$1,5
		GET	:fo,:rR
		CMP	$1,:fi,:fo
		BZ	$1,1B
%%%
		SET	$255,:fo; PUSHJ $255,:print:int; PUSHJ $255,:print:nl
		PUSHJ	$1,Random
		DIVU	$1,$1,250
		GET	:tg,:rR
		ADD	:tg,:tg,250
		SET	$255,:tg; PUSHJ $255,:print:int; PUSHJ $255,:print:nl
%%%
		PUSHJ	$1,Random
		SET	$2,[[dt]]
		DIVU	$1,$1,$2
		GET	:dt,:rR
		SET	$255,:dt; PUSHJ $255,:print:int; PUSHJ $255,:print:nl
		PUT	:rJ,$0
		POP	0,0
%%%
%%%		Random: see Vol 2 page 185
%%%
M		GREG	2147483647
A		GREG	48271
Q		GREG	44488
R		GREG	3399	
X		GREG	2147483647-1
Random		DIV	$0,X,Q
		MUL	$0,$0,R
		GET	$1,:rR
		MUL	$1,$1,A
		SUB	X,$1,$0
		BNN	X,1F
		ADD	X,X,M
1H		SET	$0,X
		GET	$1,:rJ
		SET	$255,$0; PUSHJ $255,:print:int; PUSHJ $255,:print:nl
		PUT	:rJ,$1
		POP	1,0


		*	ID,Time getting in,floor in, floor out,time leaving
		*	id,t,i,o,g
DonsValues	WYDE	1,0,0,2,152
		WYDE	2,38,4,1,1158
		WYDE	3,136,2,1,1108
		WYDE	4,141,2,1,1083
		WYDE	5,291,3,1,1133
		WYDE	6,364,2,1,540
		WYDE	7,602,1,2,1183
		WYDE	8,827,1,0,1398
		WYDE	9,876,1,3,2000
		WYDE   10,1048,0,4,2000
		WYDE   11,2000,1,2,3000	used only for dt

Initial		GETA   $0,DonsValues
		MUL    $1,vcount,10
		ADD    $0,$0,$1

		LDW	$1,$0,0		id
		LDW	$2,$0,2		time getting in
		LDW	$3,$0,12	next time getting in
		SUB	:dt,$3,$2	new delta t
		LDW	:fi,$0,4	fi
		LDW	:fo,$0,6	fo
		LDW	:tg,$0,8	time getting out
		SUB	:tg,:tg,$2	give up time

%%%		GET	$3,:rJ
%%%		SET	$255,$1; PUSHJ $255,:print:int; PUSHJ $255,:print:space
%%%		SET	$255,$2; PUSHJ $255,:print:int; PUSHJ $255,:print:space
%%%		SET	$255,:fi; PUSHJ $255,:print:int; PUSHJ $255,:print:space
%%%		SET	$255,:fo; PUSHJ $255,:print:int; PUSHJ $255,:print:space
%%%		SET	$255,:tg; PUSHJ $255,:print:int; PUSHJ $255,:print:space
%%%		SET	$255,:dt; PUSHJ $255,:print:int; PUSHJ $255,:print:nl
%%%		PUT	:rJ,$3

		ADD	vcount,vcount,1
		POP	0,0