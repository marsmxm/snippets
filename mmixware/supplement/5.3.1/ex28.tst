[[SET Driver


	LOC	Data_Segment
	GREG	@

Sorted	BYTE	1,2,3,4,5
	OCTA	0	align to octa
Unsorted BYTE	1,2,3,4,5


	LOC	#100

K	GREG	0
Rtotal	GREG	0

i	IS	$0
before	IS	$1
after	IS	$2
min	IS	$3
max	IS	$4
sum	IS	$5
tmp	IS	$6

Main	LDA	K,Unsorted
	SET	tmp+1,5
	PUSHJ	tmp,generate
	SET	i,120

	LDA	K,Unsorted
	SET	min,1000
	SET	max,0
	SET	sum,0

0H	SET	tmp+1,K
	GET	before,rI		% get runtime
	PUSHJ	tmp,Sort
	GET	after,rI	        % get runtime again
	SUB	before,before,after
	SUB	before,before,5		GET,PUSHJ,POP
	ADD	sum,sum,before
	CMP	tmp,before,min
	CSN	min,tmp,before
	CMP	tmp,before,max
	CSP	max,tmp,before

	LDA	tmp+1,Sorted
	SET	tmp+2,K
	SET	tmp+3,5
	PUSHJ	tmp,ByteEqual:Start
	ADDU	K,K,8
	SUB	i,i,1
	BP	i,0B
	GET 	$255,:rN
	SRU	$255,$255,32
	BEV	$255,OK			 do not measure runtimes if SUBSUBVERSION is even = mmmix

[[INCLUDE expect.mms "min" :min 32]]

[[INCLUDE expect.mms "max" :max 42]]

[[INCLUDE expect.mms "sum" :sum 4464]]

OK	SET	$255,0
	TRAP	0,Halt,0

	PREFIX	:Sort:
[[INCLUDE ex28.mms]]
	PREFIX 	:
	
[[INCLUDE ByteEqual.mms $0 $1 $2]]
	POP	0,0

	PREFIX	:Generate:
n	IS	$0
Base	IS	$1
return	IS	$2
i	IS	$3
j	IS	$4
a	IS	$5
b	IS	$6
tmp	IS	$7

:generate	NEG	j,5,n
		SUB	n,n,1
		BNP	n,9F
		SET	i,j
		GET	return,:rJ
		SET	Base,:K

1H		SET	tmp+1,n
		PUSHJ	tmp,:generate
		ADD	i,i,1
		CMP	tmp,i,5
		BNN	tmp,8F	
		LDOU	tmp,Base,0
		ADDU	:K,:K,8
		STOU	tmp,:K,0
		LDB	a,:K,j
		LDB	b,:K,i
		STB	a,:K,i
		STB	b,:K,j
		JMP	1B

8H		PUT	:rJ,return
9H		POP	0,0	


[[INCLUDE print.mms]]



]]





[[TEST 1]]

[[Driver]]

[[END 1]]





