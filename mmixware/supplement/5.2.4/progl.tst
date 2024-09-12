
[[COMMENT for prog2s Program 5.2.4S]]

[[SET Driver
                LOC	Data_Segment
		GREG	@
Data		[[In]]
		GREG	@
Size		OCTA	[[n]]
		LOC	(@&~#FFF)+#1000
		GREG	@
DataLinked	OCTA	0
		LOC	@+8*[[n]]
		OCTA	0
		GREG	@
Sorted		[[Out]]
		
		LOC	#100
Main		PUSHJ	$0,AddLinks
		LDA	$3,DataLinked
		LDO	$4,Size
		GET	$0,rI		% get runtime
		PUSHJ	$2,Sort
		GET	$1,rI	        % get runtime again

		[[Runtime]]

		PUSHJ	$0,RemoveLinks

		[[INCLUDE OctaEqual.mms Data Sorted [[n]]]] 

		SET	$255,0 
		TRAP 0,Halt,0
		
		GREG	@
		PREFIX	:add:
in		IS	$0
out		IS	$1
n		IS	$2
k		IS	$3
:AddLinks	LDA	in,:Data
		LDA	out,:DataLinked+8
		LDO	n,:Size
		SL	n,n,3
		BNP	n,1F
0H		SUB	n,n,8
		LDO	k,in,n
		STT	k,out,n
		BP	n,0B
1H		POP	0,0

p		IS	$4
L		IS	$5

:RemoveLinks	LDA	out,:Data
		LDA	in,:DataLinked
		ADDU	L,in,4
		SET	n,0
		LDTU	p,L,0
		ANDN	p,p,1
		BZ	p,1F
0H		LDT	k,in,p
		STO	k,out,n
		ADD	n,n,8
		LDT	p,L,p
		ANDN	p,p,1
		BNZ	p,0B
1H		POP	0,0


		PREFIX	:

[[INCLUDE progl.mms]]
[[INCLUDE print.mms]]
]]
[[SET Runtime %]]
[[TEST 1]]
        [[SET In  OCTA 5,0]]
        [[SET n     1]]
        [[SET Out OCTA 5,0]]

        [[Driver]]
[[END 1]]

[[TEST 2]]
	[[SET In OCTA 5,2,0]]
	[[SET n  2]]
	[[SET Out OCTA 2,5,0]]

	[[Driver]]
[[END 2]]

[[TEST 3]]
	[[SET In OCTA 2,5,0]]
	[[SET n  2]]
	[[SET Out OCTA 2,5,0]]

	[[Driver]]
[[END 3]]

[[TEST 4]]
	[[SET In OCTA 3,2,5,0]]
	[[SET n  3]]
	[[SET Out OCTA 2,3,5,0]]

	[[Driver]]
[[END 4]]

[[TEST 5]]
	[[SET In OCTA 5,3,2,5,0]]
	[[SET n  4]]
	[[SET Out OCTA 2,3,5,5,0]]

	[[Driver]]
[[END 5]]

[[TEST 6]]
	[[SET In OCTA 5,3,2,5,7,11,-3,2,99,5,0]]
	[[SET n  10]]
	[[SET Out OCTA -3,2,2,3,5,5,5,7,11,99,0]]

	[[Driver]]
[[END 6]]


[[SET Runtime	[[INCLUDE runtime.mms $0 $1 [[time]] 5]]]]


[[COMMENT Table 1 on page 140]]
[[TEST 7]]
	[[SET In [[INCLUDE table1.mms]]]]
	[[SET n  16]]
	[[SET Out [[INCLUDE table1s.mms]]]]
	[[SET time 757]]
	[[Driver]]
[[END 7]]


[[COMMENT 1000 Elemente]]
[[TEST 8]]
	[[SET In [[INCLUDE s1000.mms]]]]
	[[SET n 1000]]
	[[SET Out [[INCLUDE s1000s.mms]]]]
	[[SET time 90571]]
	[[Driver]]
[[END 8]]


[[COMMENT 1000 Elemente]]
[[TEST 9]]
	[[SET In [[INCLUDE s10000.mms]]]]
	[[SET n 10000]]
	[[SET Out [[INCLUDE s10000s.mms]]]]
	[[SET time 1190583]]
	[[Driver]]
[[END 9]]

[[COMMENT 64 Elemente]]
[[TEST 10]]
	[[SET In [[INCLUDE s64.mms]]]]
	[[SET n 64]]
	[[SET Out [[INCLUDE s64s.mms]]]]
	[[SET time 3854]]
	[[Driver]]
[[END 10]]
