[[SET Driver
		LOC	:Data_Segment
		GREG	@
rover		GREG	0		
		TETRA	0			Align AVAIL

AVAIL		TETRA	16
		TETRA	6*4			First-AVAIL
		TETRA	6*4			First-AVAIL
		TETRA	16		

		TETRA	1,1			Mark as used (see Algorithm C).

First		TETRA	[[Total]]-16		SIZE
		TETRA	0,0			RLINK=LLINK=AVAIL
		LOC	First+[[Total]]-16-4
		TETRA	[[Total]]-16

		TETRA	1			Mark as used (see Algorithm C).


		LOC	#100
Main	IS	@
	[[Main]]

	LDTU	$0,AVAIL+4		RLINK
	CMPU	$0,$0,6*4		only first node remaining
	BNZ	$0,Fail			
	LDTU	$0,AVAIL+8		LLINK
	CMPU	$0,$0,6*4		only first node remaining
	BNZ	$0,Fail			
	LDOU	$0,First+4
	BNZ	$0,Fail			First node links to AVAIL
	SET	$1,[[Total]]-16
	LDA	$3,First
	LDTU	$0,$3,0
	CMP	$2,$0,$1		Check SIZE of first node
	BNZ	$2,Fail
	SUB	$0,$0,4
	LDTU	$0,$3,$0		Check SIZE of at end of first node
	CMP	$2,$0,$1		
	BNZ	$2,Fail

OK	SET	$255,0
	TRAP 0,Halt,0

Fail	SET	$255,1
	TRAP 0,Halt,0

[[INCLUDE ex13.mms]]
[[INCLUDE ex16.mms]]
[[INCLUDE print.mms]]

]]

[[TEST 1]]
[[COMMENT allocate everything and free it again]]
[[SET	Total #70]]

[[SET Main
	SET	$2,[[Total]]-16-8	total - header node - overhead
	PUSHJ	$1,Allocate
	PUSHJ	$0,Free	
]]
[[Driver]]
[[END 1]]



[[TEST 2]]
[[COMMENT allocate everything in two steps and free it again]]
[[SET	Total #60]]

[[SET Main
	SET	$2,#10
	PUSHJ	$1,Allocate
	SET	$4,[[Total]]-16-8-#10-8
	PUSHJ	$3,Allocate
	PUSHJ	$2,Free
	PUSHJ	$0,Free	
]]
[[Driver]]
[[END 2]]


[[TEST 3]]
[[COMMENT allocate something in three steps 1,2,3 and free it again 3,2,1]]
[[SET	Total #B00]]

[[SET Main
	SET	$2,#10
	PUSHJ	$1,Allocate

	SET	$4,#10
	PUSHJ	$3,Allocate

	SET	$6,#10
	PUSHJ	$5,Allocate

	PUSHJ	$4,Free
before  GREG	0
	GET	before,rI
	PUSHJ	$2,Free
after	GREG	0
	GET	after,rI
[[COMMENT next block ocupied preceeding block free]]
[[INCLUDE runtime.mms :before :after 18 5]]
	PUSHJ	$0,Free	
]]
[[Driver]]
[[END 3]]

[[TEST 4]]
[[COMMENT allocate everything in three steps 1,2,3 and free it again 2,1,3]]
[[SET	Total #B0]]

[[SET Main
	SET	$2,#10
	PUSHJ	$1,Allocate
	SET	$4,#10
	PUSHJ	$3,Allocate
	SET	$6,#10
	PUSHJ	$5,Allocate
	SET	$7,$3
before  GREG	0
	GET	before,rI
	PUSHJ	$6,Free
after	GREG	0
	GET	after,rI
[[COMMENT next block occupied preceeding block occupied]]
[[INCLUDE runtime.mms :before :after 22 5]]

	SET	$7,$1
	PUSHJ	$6,Free

	SET	$7,$5
	PUSHJ	$6,Free
]]
[[Driver]]
[[END 4]]

[[TEST 5]]
[[COMMENT allocate everything in three steps 1,2,3 and free it again 2,3,1]]
[[SET	Total #B0]]

[[SET Main
	SET	$2,#10
	PUSHJ	$1,Allocate
	SET	$4,#10
	PUSHJ	$3,Allocate
	SET	$6,#10
	PUSHJ	$5,Allocate
	SET	$7,$3
	PUSHJ	$6,Free
	SET	$7,$5
before  GREG	0
	GET	before,rI
	PUSHJ	$6,Free
after	GREG	0
	GET	after,rI
[[COMMENT next block free preceeding block free]]
[[INCLUDE runtime.mms :before :after 28 5]]
	SET	$7,$1
	PUSHJ	$6,Free
]]
[[Driver]]
[[END 5]]

[[TEST 6]]
[[COMMENT allocate everything in three steps 1,2,3 and free it again 1,3,2]]
[[SET	Total #B0]]

[[SET Main
	SET	$2,#10
	PUSHJ	$1,Allocate
	SET	$4,#10
	PUSHJ	$3,Allocate
	SET	$6,#10
	PUSHJ	$5,Allocate
	SET	$7,$1
	PUSHJ	$6,Free
	SET	$7,$5
before  GREG	0
	GET	before,rI
	PUSHJ	$6,Free
after	GREG	0
	GET	after,rI
[[COMMENT next block free preceeding block free]]
[[INCLUDE runtime.mms :before :after 18 5]]
	SET	$7,$3
	PUSHJ	$6,Free
]]
[[Driver]]
[[END 6]]


[[TEST 7]]
[[COMMENT allocate everything in three steps 1,2,3 and free it again 1,2,3]]
[[SET	Total #B00]]

[[SET Main
	SET	$2,#10
	PUSHJ	$1,Allocate
	SET	$4,#10
	PUSHJ	$3,Allocate
	SET	$6,#10
	PUSHJ	$5,Allocate
	SET	$7,$1
	PUSHJ	$6,Free
	SET	$7,$3
before  GREG	0
	GET	before,rI
	PUSHJ	$6,Free
after	GREG	0
	GET	after,rI
[[COMMENT next block free preceeding block occupied]]
[[INCLUDE runtime.mms :before :after 27 5]]
	SET	$7,$5
	PUSHJ	$6,Free
]]
[[Driver]]
[[END 7]]




[[TEST 9]]

[[SET m 100]]
[[SET n 10]]
[[SET d 2]]
[[SET min 5]]
[[SET max 300]]
[[SET Total #5000]]


		LOC	:Data_Segment
		GREG	@
rover		GREG	0		
		TETRA	0			Align AVAIL

AVAIL		TETRA	0			SIZE=0
		TETRA	6*4			RLINK=First-AVAIL
		TETRA	6*4			LLINK=First-AVAIL
		TETRA	0			SIZE=0

		TETRA	1,1			Mark as used (see Algorithm C).

First		TETRA	[[Total]]-16		SIZE
		TETRA	0,0			RLINK=LLINK=AVAIL
		LOC	First+[[Total]]-16-4
		TETRA	[[Total]]-16		SIZE

		TETRA	1			Mark as used (see Algorithm C).


		LOC	((@+#FFF)&~#FFF)	round to a nice boundary for debugging
Blocks		GREG	@
		OCTA	0

:Allocate:Total	IS	[[Total]]     		The total size used (including list head).

		LOC	#100

[[INCLUDE ex13.mms]]

[[INCLUDE ex16.mms]]

[[INCLUDE print.mms]]


n	  IS	$0		number of iterations
i	  IS	$1		number of insertions
k	  IS	$2
p	  IS	$3
m	  IS	$4
t	  IS	$5

Main	  SET	$255,1		default fail.
	  SET	m,[[m]]
	  SR	i,m,1		insert m/2 blocks
1H	  PUSHJ	t,insert
	  SUB	i,i,1
	  BP	i,1B		
%	  [[printnl]]
	  SET	n,[[n]]	

2H	  PUSHJ	t,Random	random inserts and deletions
	  DIV	t,t,m
	  GET	i,rR
	  SR	i,i,3		0<= i < m/8		

1H	  PUSHJ	t,insert
	  SUB	i,i,1
	  BP	i,1B		
	
%	  [[printnl]]
%	  [[printT :First]];	[[printtab]]
	
	  PUSHJ	t,Random	random inserts and deletions
	  DIV	t,t,m
	  GET	i,rR
	  ADD	i,i,8*[[d]]		delete slighly more than insert
	  SR	i,i,3		0<= i < m/8		

1H	  PUSHJ	t,delete
	  SUB	i,i,1
	  BP	i,1B		
	
%	  [[printtab]]
%	  [[printT :First]];	[[printnl]]

	  SUB	n,n,1
	  BP	n,2B

	
	  SET	k,m
1H	  SUB	k,k,1
	  BN	k,1F
	  SL	p,k,3
	  LDO	t,Blocks,p
	  BZ	t,1B
	  LDOU	t+1,Blocks,p
	  STCO	0,Blocks,p
%	  SUB	t+2,t+1,8
%	  [[printT t+2,0]]; [[printsp]]
	  PUSHJ	t,Free
	  JMP	1B



1H	  LDT	$255,First
	  SET	$0,[[Total]]-16
	  CMP	$1,$0,$255
	  BNZ	$1,Fail

%	  [[printtab]]
%	  [[printT :Allocate:base,24]];	[[printnl]]
	  SET	$255,0
	  TRAP	0,Halt,0


insert		GET	n,rJ
		SET	m,[[m]]
		PUSHJ	t,Random	
		SET	k,[[max]]-[[min]]
		DIV	t,t,k
		GET	k,rR
		ADD	k,k,[[min]]
%		[[printi k]]; [[printsp]]
		SET	t+1,k
		PUSHJ	t,Allocate
		BZ	t,Overflow
		SET	i,t
		PUSHJ	t,Random	
		DIV	t,t,m
		GET	k,rR
1H		SL	p,k,3
		LDO	t,Blocks,p
		BZ	t,1F
		SUB	k,k,1
		BNN	k,1B
		SUB	k,m,1
		JMP	1B
1H		STOU	i,Blocks,p
		PUT	rJ,n
		POP	0,0

delete		GET	n,rJ
		SET	m,[[m]]
		PUSHJ	t,Random	
		DIV	t,t,m
		GET	k,rR
1H		SL	p,k,3
		LDO	t,Blocks,p
		BNZ	t,1F
		SUB	k,k,1
		BNN	k,1B
		SUB	k,m,1
		JMP	1B
1H		LDOU	t+1,Blocks,p
		STCO	0,Blocks,p
		SUB	t+2,t+1,8
%		[[printT t+2,0]]; [[printsp]]
		PUSHJ	t,Free
		PUT	rJ,n
		POP	0,0

Overflow	GETA	$255,1F
		TRAP	0,Fputs,StdOut
		JMP	Fail
1H		BYTE	"Overflow in Allocate",10,0




Fail	  	SET	$255,1
	  	TRAP	0,Halt,0


[[INCLUDE random.mms]]


[[END 9]]
