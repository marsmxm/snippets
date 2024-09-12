
[[SET Driver

		LOC	Data_Segment
		GREG	@
		OCTA	1<<63		MIN signed OCTA
Data		[[In]]
		OCTA	-1>>1		MAX signed OCTA
Size		IS	[[n]]
Bits		IS	[[m]]	
		GREG	@	
Sorted		[[Out]]

		LOC	#100
Main		IS	@
%		SET	$3,Size
%		LDA	$4,Data
%		GETA	$5,RSort
%		PREGO	255,$5,0
%0H		LDO	$5,$4,0		Prime the cache
%		ADD	$4,$4,8
%		SUB	$3,$3,1
%		BP	$3,0B
		
		LDA	$2,Data
		SET	$3,Size
		SET	$4,Bits
		GET	$0,rI		% get runtime
		PUSHJ	$1,RSort
		GET	$1,rI	        % get runtime again
		[[Runtime]]

		[[INCLUDE OctaEqual.mms Data Sorted Size]] 

		SET	$255,0 
		TRAP 0,Halt,0

[[INCLUDE radix.mms]]
[[INCLUDE print.mms]]

]]
[[SET Runtime %]]
[[SET m 3]]

[[TEST 1]]
	[[SET In  OCTA 5]]
	[[SET n     1]]
	[[SET Out OCTA 5]]

	[[Driver]]
[[END 1]]

[[TEST 2]]

[[SET In OCTA 5,2]]
[[SET n  2]]
[[SET Out OCTA 2,5]]

[[Driver]]
[[END 2]]

[[TEST 3]]

[[SET In OCTA 2,5]]
[[SET n  2]]
[[SET Out OCTA 2,5]]

[[Driver]]
[[END 3]]

[[TEST 4]]

[[SET In OCTA 3,2,5]]
[[SET n  3]]
[[SET Out OCTA 2,3,5]]

[[Driver]]
[[END 4]]

[[TEST 5]]

[[SET In OCTA 5,3,2,5]]
[[SET n  4]]
[[SET Out OCTA 2,3,5,5]]

[[Driver]]
[[END 5]]

[[TEST 6]]

[[SET m 7]]
[[SET In OCTA 5,3,2,5,7,11,0,2,99,5]]
[[SET n  10]]
[[SET Out OCTA 0,2,2,3,5,5,5,7,11,99]]

[[Driver]]

[[END 6]]

[[TEST 7]]


[[SET In [[INCLUDE table1.mms]]]]
[[SET m  10]]
[[SET n  16]]
[[SET Out [[INCLUDE table1s.mms]]]]

[[SET Runtime	[[INCLUDE runtime.mms $0 $1 925 5 ]]]]

[[Driver]]

[[END 7]]

[[TEST 8]]


[[SET In OCTA  0,1,2,3,4,5,6,7,9,10,11,12,13,14,15,16,8]]
[[SET m  5]]
[[SET n  17]]
[[SET Out OCTA 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16]]                           

[[Driver]]

[[END 8]]


[[TEST 9]]

[[SET In [[INCLUDE r1000.mms]]]]
[[SET m  32]]
[[SET n  1000]]
[[SET Out [[INCLUDE r1000s.mms]]]]

[[SET Runtime	[[INCLUDE runtime.mms $0 $1 101026 5 ]]]]

[[Driver]]

[[END 9]]

[[TEST 10]]

[[SET In [[INCLUDE r10000.mms]]]]
[[SET m  32]]
[[SET n  10000]]
[[SET Out [[INCLUDE r10000s.mms]]]]

[[SET Runtime	[[INCLUDE runtime.mms $0 $1 1252793 5 ]]]]

[[Driver]]

[[END 10]]

