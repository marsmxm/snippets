[[SET Driver

	LOC	Data_Segment
	GREG	@
	[[Q]]
	[[P]]
	[[M]]
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
1H	OCTA	1F,0,0
1H	OCTA	0,0,0

avail	GREG	0

	LOC	#100

C	IS	$0
Cn	IS	$1
An	IS	$2
t	IS	$3

Main	LDA	avail,Free
	
	LDA	t+1,Q
	LDA	t+2,M
	LDA	t+3,P
	PUSHJ	t,:Mult			Q is Q+M*P

	LDA	t+1,S			S is the solution
	LDA	t+2,Q
	PUSHJ	t,Compare		check S=Q
	BNZ	t,Fail

	LDA	t+1,Q
	PUSHJ	t,Copy
	SET	C,t			C is a copy of Q
	
	LDA	t+1,S
	LDA	t+2,C
	PUSHJ	t,Compare		check S=C
	BNZ	t,Fail
	

	SET	t+1,C
	PUSHJ	t,Length		Cn is the length of C
	SET	Cn,t

	SET	t+1,avail
	PUSHJ	t,Length
	SET	An,t			An is the length of AVAIL
	
	SET	t+1,C
	PUSHJ	t,Erase			Erase C
	
	SET	t+1,avail
	PUSHJ	t,Length		check t = An+Cn

	SUB	t,t,An
	SUB	t,t,Cn
	BNZ	t,Fail
	


	PUSHJ	t+1,Zero
	SET	t+3,t+1
	LDA	t+4,Q
	PUSHJ	t+5,Zero
	PUSHJ	t+2,:Mult

	PUSHJ	t+2,Zero
	PUSHJ	t,Compare	&0 = 0+Q*0 ?	
	BNZ	t,Fail





OK	SET	$255,0
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
	LDOU	xS,S,ABC	
	LDOU	xQ,Q,ABC
	CMP	t,xS,xQ
	BNZ	t,Fail
	LDOU	cS,S,COEF
	LDOU	cQ,Q,COEF
	CMP	t,cS,cQ
	BNZ	t,Fail
	BNN	xQ,:Compare
	POP	0,0

Fail	SET	$0,1	
	POP	1,0

	PREFIX	:Length:
LINK    IS      0            &  Definition of link field

P	IS	$0
length	IS	$1
Head	IS	$2
t	IS	$3

:Length	SET	length,0
	SET	Head,P
0H	BZ	P,1F
	ADD	length,length,1
	LDOU	P,P,LINK
	CMP	t,P,Head
	BNZ	t,0B

1H	SET	$0,length
	POP	1,0

	PREFIX	:

[[INCLUDE ex11new.mms]]
[[INCLUDE ex13.mms]]
[[INCLUDE ex14new.mms]]
[[INCLUDE ex15new.mms]]

]]

[[TEST 1]]
[[COMMENT constants S = Q = Q + M*P= 7+2*5 ]]
[[SET P	

P	OCTA	1F,-1,0
1H	OCTA	P; WYDE 0,0,0,0; OCTA 5 
]]
[[SET Q	

Q	OCTA	1F,-1,0
1H	OCTA	Q; WYDE 0,0,0,0; OCTA 7 
]]
[[SET M	

M	OCTA	1F,-1,0
1H	OCTA	M; WYDE 0,0,0,0; OCTA 2 
]]
[[SET S

S	OCTA	1F,-1,0
1H	OCTA	S; WYDE 0,0,0,0; OCTA 17
]]



[[Driver]]
[[END 1]]


[[TEST 2]]
[[COMMENT constants S = Q + M*P; 0 =  -10+2*5 ]]
[[SET P

P	OCTA	1F,-1,0
1H	OCTA	P; WYDE 0,0,0,0; OCTA 5 
]]
[[SET Q

Q	OCTA	1F,-1,0
1H	OCTA	Q; WYDE 0,0,0,0; OCTA -10 
]]
[[SET M

M	OCTA	1F,-1,0
1H	OCTA	M; WYDE 0,0,0,0; OCTA 2 
]]
[[SET S

S	OCTA	S,-1,0
]]

[[Driver]]
[[END 2]]


[[TEST 3]]
[[COMMENT constants S = Q + M*P]]
[[COMMENT  13x +130   = 3x+30 + 2*(5x+50) ]]
[[SET Q

Q	OCTA	1F,-1,0
1H	OCTA	1F; WYDE 1,0,0,0; OCTA 3 
1H	OCTA	Q; WYDE 0,0,0,0; OCTA 30
]]
[[SET P	

P	OCTA	1F,-1,0
1H	OCTA	1F; WYDE 1,0,0,0; OCTA 5 
1H	OCTA	P; WYDE 0,0,0,0; OCTA 50 
]]
[[SET M	

M	OCTA	1F,-1,0
1H	OCTA	M; WYDE 0,0,0,0; OCTA 2 
]]
[[SET S

S	OCTA	1F,-1,0
1H	OCTA	1F; WYDE 1,0,0,0; OCTA 13 
1H	OCTA	S; WYDE 0,0,0,0; OCTA 130
]]

[[Driver]]
[[END 3]]


[[TEST 4]]
[[COMMENT constants S = Q + M*P]]
[[COMMENT  10x^2+ 103x + 30   = 3x+30 + 2x*(5x+50) ]]
[[SET Q	

Q	OCTA	1F,-1,0
1H	OCTA	1F; WYDE 1,0,0,0; OCTA 3 
1H	OCTA	Q; WYDE 0,0,0,0; OCTA 30
]]
[[SET P	

P	OCTA	1F,-1,0
1H	OCTA	1F; WYDE 1,0,0,0; OCTA 5 
1H	OCTA	P; WYDE 0,0,0,0; OCTA 50 
]]
[[SET M

M	OCTA	1F,-1,0
1H	OCTA	1F; WYDE 1,0,0,0; OCTA 2 
1H	OCTA	M; WYDE 0,0,0,0; OCTA 0 
]]
[[SET S

S	OCTA	1F,-1,0
1H	OCTA	1F; WYDE 2,0,0,0; OCTA 10 
1H	OCTA	1F; WYDE 1,0,0,0; OCTA 103
1H	OCTA	S; WYDE 0,0,0,0; OCTA 30
]]

[[Driver]]
[[END 4]]


[[TEST 5]]
[[COMMENT constants S = Q + M*P]]
[[COMMENT  10x^2 + 30   = -100x+30 + 2x*(5x+50) deleting term]]
[[SET Q	

Q	OCTA	1F,-1,0
1H	OCTA	1F; WYDE 1,0,0,0; OCTA -100 
1H	OCTA	Q; WYDE 0,0,0,0; OCTA 30
]]
[[SET P	

P	OCTA	1F,-1,0
1H	OCTA	1F; WYDE 1,0,0,0; OCTA 5 
1H	OCTA	P; WYDE 0,0,0,0; OCTA 50 
]]
[[SET M

M	OCTA	1F,-1,0
1H	OCTA	M; WYDE 1,0,0,0; OCTA 2  
]]
[[SET S

S	OCTA	1F,-1,0
1H	OCTA	1F; WYDE 2,0,0,0; OCTA 10 
1H	OCTA	S; WYDE 0,0,0,0; OCTA 30

]]

[[Driver]]
[[END 5]]

[[TEST 6]]
[[COMMENT constants S = Q + M*P]]
[[COMMENT  10x^2   = -105x-50 + (2x+1)*(5x+50) deleting two terms inserting one]]
[[SET Q	

Q	OCTA	1F,-1,0
1H	OCTA	1F; WYDE 1,0,0,0; OCTA -105 
1H	OCTA	Q; WYDE 0,0,0,0; OCTA -50
]]
[[SET P	

P	OCTA	1F,-1,0
1H	OCTA	1F; WYDE 1,0,0,0; OCTA 5 
1H	OCTA	P; WYDE 0,0,0,0; OCTA 50 
]]
[[SET M

M	OCTA	1F,-1,0
1H	OCTA	1F; WYDE 1,0,0,0; OCTA 2 
1H	OCTA	M; WYDE 0,0,0,0; OCTA 1 
]]
[[SET S

S	OCTA	1F,-1,0
1H	OCTA	S; WYDE 2,0,0,0; OCTA 10 


]]

[[Driver]]
[[END 6]]

