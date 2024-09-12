[[SET Driver

	LOC	Data_Segment
	GREG	@
	[[P]]
	[[Q]]
	[[S]]

	GREG	@
Free	OCTA	1F,0,0
1H	OCTA	1F,0,0
1H	OCTA	1F,0,0
1H	OCTA	1F,0,0
1H	OCTA	1F,0,0
1H	OCTA	1F,0,0
1H	OCTA	1F,0,0
1H	OCTA	1F,0,0
1H	OCTA	1F,0,0
1H	OCTA	1F,0,0
1H	OCTA	1F,0,0
1H	OCTA	1F,0,0
1H	OCTA	1F,0,0
1H	OCTA	1F,0,0
1H	OCTA	1F,0,0
1H	OCTA	1F,0,0
1H	OCTA	1F,0,0
1H	OCTA	1F,0,0
1H	OCTA	1F,0,0
1H	OCTA	1F,0,0
1H	OCTA	1F,0,0
1H	OCTA	1F,0,0
1H	OCTA	1F,0,0
1H	OCTA	1F,0,0
1H	OCTA	1F,0,0
1H	OCTA	1F,0,0
1H	OCTA	1F,0,0
1H	OCTA	1F,0,0
1H	OCTA	0,0,0

avail	GREG	0

	LOC	#100



Main	LDA	avail,Free
	LDA	$1,P
	LDA	$2,Q
	PUSHJ	$0,Add	

	LDA	$1,S
	LDA	$2,Q
	PUSHJ	$0,Compare	
	BNZ	$0,Fail

	SET	$255,0
	TRAP	0,Halt,0

Fail	SET	$255,1
	TRAP	0,Halt,0

	PREFIX :CompPoly
COEF    IS      16             &  Definition of coefficient field
ABC     IS      8             &  Definition of ABC exponent field
LINK    IS      0            &  Definition of link field

S	IS     $0
Q	IS     $1
xS	IS     $2
xQ	IS     $3
cS	IS     $4
cQ	IS     $5
t	IS     $6

:Compare LDOU	S,S,LINK
	LDOU	Q,Q,LINK
	LDO	xS,S,ABC	
	LDO	xQ,Q,ABC
	CMP	t,xS,xQ
	BNZ	t,Fail
	LDO	cS,S,COEF
	LDO	cQ,Q,COEF
	CMP	t,cS,cQ
	BNZ	t,Fail
	BNN	xQ,:Compare
	POP	0,0

Fail	SET	$0,1	
	POP	1,0
	PREFIX	:



[[INCLUDE addnew.mms]]

]]

[[TEST 1]]
[[COMMENT two constants]]
[[SET P	

P	OCTA	1F,-1,0
1H	OCTA	P; WYDE 0,0,0,0; OCTA 5 
]]
[[SET Q

Q	OCTA	1F,-1,0
1H	OCTA	Q; WYDE 0,0,0,0; OCTA 7 

]]
[[SET S	

S	OCTA	1F,-1,0
1H	OCTA	S; WYDE 0,0,0,0; OCTA 12 
]]

[[Driver]]
[[END 1]]

[[TEST 2]]
[[COMMENT two constants cancel]]
[[SET P	

P	OCTA	1F,-1,0
1H	OCTA	P; WYDE 0,0,0,0; OCTA 5 
]]
[[SET Q

Q	OCTA	1F,-1,0
1H	OCTA	Q; WYDE 0,0,0,0; OCTA -5 
]]
[[SET S	

S	OCTA	S,-1,0
]]

[[Driver]]
[[END 2]]

[[TEST 3]]
[[COMMENT 5x+50 add 3x+30 = 8x+80]]
[[SET P

P	OCTA	1F,-1,0
1H	OCTA	1F; WYDE 0,0,0,0; OCTA 50 
1H	OCTA	P; WYDE 1,0,0,0; OCTA 5 

]]
[[SET Q	

Q	OCTA	1F,-1,0
1H	OCTA	1F; WYDE 0,0,0,0; OCTA 30
1H	OCTA	Q; WYDE 1,0,0,0; OCTA 3 

]]
[[SET S

S	OCTA	1F,-1,0
1H	OCTA	1F; WYDE 0,0,0,0; OCTA 80
1H	OCTA	S; WYDE 1,0,0,0; OCTA 8 

]]

[[Driver]]
[[END 3]]


[[TEST 4]]
[[COMMENT 5x+50 add -5x+30 = 80 deleting term]]
[[SET P

P	OCTA	1F,-1,0
1H	OCTA	1F; WYDE 0,0,0,0; OCTA 50 
1H	OCTA	P; WYDE 1,0,0,0; OCTA 5 

]]
[[SET Q

Q	OCTA	1F,-1,0
1H	OCTA	1F; WYDE 0,0,0,0; OCTA 30
1H	OCTA	Q; WYDE 1,0,0,0; OCTA -5 

]]
[[SET S

S	OCTA	1F,-1,0
1H	OCTA	S; WYDE 0,0,0,0; OCTA 80
]]

[[Driver]]
[[END 4]]


[[TEST 5]]
[[COMMENT 5xy+7x+20 add 3xy-7x+30 = 8xy+50 deleting term]]
[[SET P	

P	OCTA	1F,-1,0
1H	OCTA	1F; WYDE 1,1,0,0; OCTA 5 
1H	OCTA	1F; WYDE 1,0,0,0; OCTA 7
1H	OCTA	P; WYDE 0,0,0,0; OCTA 20 

]]
[[SET Q

Q	OCTA	1F,-1,0
1H	OCTA	1F; WYDE 1,1,0,0; OCTA 3 
1H	OCTA	1F; WYDE 1,0,0,0; OCTA -7
1H	OCTA	Q; WYDE 0,0,0,0; OCTA 30 

]]
[[SET S

S	OCTA	1F,-1,0
1H	OCTA	1F; WYDE 1,1,0,0; OCTA 8 
1H	OCTA	S; WYDE 0,0,0,0; OCTA 50 

]]

[[Driver]]
[[END 5]]


[[TEST 6]]
[[COMMENT 5xy+7x+20 add 3xy-7y+30 = 8xy+7x-7y+50 inserting term]]
[[SET P	

P	OCTA	1F,-1,0
1H	OCTA	1F; WYDE 1,1,0,0; OCTA 5 
1H	OCTA	1F; WYDE 1,0,0,0; OCTA 7
1H	OCTA	P; WYDE 0,0,0,0; OCTA 20 

]]
[[SET Q

Q	OCTA	1F,-1,0
1H	OCTA	1F; WYDE 1,1,0,0; OCTA 3 
1H	OCTA	1F; WYDE 0,1,0,0; OCTA -7
1H	OCTA	Q; WYDE 0,0,0,0; OCTA 30 

]]
[[SET S

S	OCTA	1F,-1,0
1H	OCTA	1F; WYDE 1,1,0,0; OCTA 8 
1H	OCTA	1F; WYDE 1,0,0,0; OCTA 7
1H	OCTA	1F; WYDE 0,1,0,0; OCTA -7
1H	OCTA	S;  WYDE 0,0,0,0; OCTA 50 

]]

[[Driver]]
[[END 6]]



[[TEST 7]]
[[COMMENT 5xy+7x+20 add 3xy-7y-20 = 8xy+7x-7y inserting term]]
[[SET P

P	OCTA	1F,-1,0
1H	OCTA	1F; WYDE 1,1,0,0; OCTA 5 
1H	OCTA	1F; WYDE 1,0,0,0; OCTA 7
1H	OCTA	1F; WYDE 0,1,1,0; OCTA 7
1H	OCTA	P; WYDE 0,0,0,0; OCTA 20 

]]
[[SET Q

Q	OCTA	1F,-1,0
1H	OCTA	1F; WYDE 1,1,0,0; OCTA 3 
1H	OCTA	1F; WYDE 0,1,1,0; OCTA -7
1H	OCTA	1F; WYDE 0,1,0,0; OCTA 3
1H	OCTA	Q; WYDE 0,0,0,0; OCTA -20 

]]
[[SET S

S	OCTA	1F,-1,0
1H	OCTA	1F; WYDE 1,1,0,0; OCTA 8 
1H	OCTA	1F; WYDE 1,0,0,0; OCTA 7
1H	OCTA	S; WYDE 0,1,0,0; OCTA 3


]]

[[Driver]]
[[END 7]]


