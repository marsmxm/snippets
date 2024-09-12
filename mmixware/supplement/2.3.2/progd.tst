[[SET Driver

	LOC	#100

[[INCLUDE progd.mms]]

[[INCLUDE subs.mms]]
[[INCLUDE ex13.mms]]

[[INCLUDE allocate.mms]]

[[INCLUDE diff.mms]]
[[INCLUDE mult.mms]]
[[INCLUDE ex15.mms]]
[[INCLUDE ex16.mms]]

	PREFIX	:D:
:LastText	IS	@

	LOC	:Data_Segment
	GREG	@
:poly	IS	@
0H	OCTA	@,1F,0	tree head	
[[Y]]

:var	OCTA	('x'<<56)+(:Var-:Const)	name,var

:dpoly	IS	@
0H	OCTA	@,1F,0	tree head	
[[DY]]

	PREFIX	:

	LOC	LastText

Main	SET	$255,1
%	PUSHJ	$255,:print:tab
%	LDA	$1,poly
%	PUSHJ	$0,printpoly
%	PUSHJ	$255,:print:tab
	LDA	$1,poly
	LDO	$2,var
	PUSHJ	$0,D
%	SET	$2,$0
%	PUSHJ	$1,printpoly
%	PUSHJ	$255,:print:nl
	SET	$1,$0
	LDA	$2,dpoly
	BOD	$0,Fail
	PUSHJ	$0,TreeEqual

OK	SET	$255,0; TRAP 0,Halt,0
Fail	SET	$255,1; TRAP 0,Halt,0

[[INCLUDE treeequal.mms]]

	PREFIX	:pp:
P	IS	$0
rJ	IS	$1
diff	IS	$2
t	IS	$3
:printpoly	BZ	P,9F
		LDOU	P,P,:LLINK
%%%		
0H		GET	rJ,:rJ
		LDWU	diff,P,:DIFF
		GETA  	t,3F
		GO    	t,t,diff
3H		JMP   	CONST
        	JMP   	VAR
        	JMP   	LN
        	JMP   	NEG
        	JMP   	BINARY
        	JMP   	BINARY
        	JMP   	BINARY
        	JMP   	BINARY
        	JMP   	BINARY
CONST		LDT   	$255,P,:INFO; PUSHJ $255,:print:int
		JMP   	Done
VAR		ADDU	$255,P,:INFO; TRAP 0,:Fputs,:StdOut
		JMP	Done
LN		GETA	$255,ln; TRAP 0,:Fputs,:StdOut 
1H		GETA	$255,open; TRAP 0,:Fputs,:StdOut 
		LDOU	t+1,P,:LLINK
		PUSHJ	t,0B
		GETA	$255,close; TRAP 0,:Fputs,:StdOut 
		JMP	Done
NEG		GETA	$255,minus; TRAP 0,:Fputs,:StdOut 
		JMP	1B
open		BYTE	"(",0,0,0
close		BYTE	")",0,0,0
ln		BYTE	"ln",0,0
neg		BYTE	"-",0,0,0
plus		BYTE	"+",0,0,0
minus		BYTE	"-",0,0,0
		BYTE	"*",0,0,0
		BYTE	"/",0,0,0
		BYTE	"^",0,0,0
BINARY		GETA	$255,open; TRAP 0,:Fputs,:StdOut 	
		LDOU	t+1,P,:LLINK
		PUSHJ	t,0B
		GETA	$255,open
		ADD	$255,$255,diff
		ANDN	$255,$255,3
		TRAP 	0,:Fputs,:StdOut 
		LDOU	t+1,P,:LLINK
		LDOU	t+1,t+1,:RLINK
		PUSHJ	t,0B
		GETA	$255,close; TRAP 0,:Fputs,:StdOut 	
%%%
Done		PUT	:rJ,rJ
9H		POP	0,0


	PREFIX	:

[[INCLUDE print.mms]]

]]


[[COMMENT Tests taken from S232PD-DIFF.tst ]]


[[TEST 10]]
[[COMMENT Topology: very simple. Y = 42. Can't do simpler.]]
[[SET Y
1H	OCTA 	0B+1,0,(42<<32)
]]
[[SET DY
1H	OCTA 	0B+1,0,0
]]
[[Driver]]
[[END 10]]

[[TEST 100]]
[[COMMENT Topology:  Y = Z, DY = 0]]
[[SET Y
1H	OCTA 	0B+1,0,'z'<<56+(:Var-:Const)
]]
[[SET DY
1H	OCTA 	0B+1,0,0
]]
[[Driver]]
[[END 100]]

[[TEST 110]]
[[COMMENT Topology: Y = X, DY = 1]]
[[SET Y
1H	OCTA 	0B+1,0,'x'<<56+(:Var-:Const)
]]
[[SET DY
1H	OCTA 	0B+1,0,1<<32			1
]]
[[Driver]]
[[END 110]]

[[TEST 200]]
[[COMMENT Topology: Y = LN 42, DY = 0]]
[[SET Y
1H	OCTA 	0B+1,2F,(:Ln-:Const)		ln
2H	OCTA	1B+1,0,(42<<32)			42
]]
[[SET DY
1H	OCTA 	0B+1,0,0<<32			0
]]
[[Driver]]
[[END 200]]

[[TEST 210]]
[[COMMENT Topology: Y = LN X, DY = 1 / X]]
[[SET Y
1H	OCTA 	0B+1,2F,(:Ln-:Const)			ln
2H	OCTA	1B+1,0,'x'<<56+(:Var-:Const)		x
]]
[[SET DY
1H	OCTA 	0B+1,2F,(:Div-:Const)			/ 
2H	OCTA	3F,0,1<<32			1
3H	OCTA	1B+1,0,'x'<<56+(:Var-:Const)		x
]]
[[Driver]]
[[END 210]]

[[TEST 300]]
[[COMMENT Topology: Y = NEG 42, DY = 0]]
[[SET Y
1H	OCTA 	0B+1,2F,(:Neg-:Const)		neg
2H	OCTA	1B+1,0,(42<<32)			42
]]
[[SET DY
1H	OCTA 	0B+1,0,0<<32			0
]]
[[Driver]]
[[END 300]]

[[TEST 310]]
[[COMMENT Topology: Y = NEG X, DY = NEG 1]]
[[SET Y
1H	OCTA 	0B+1,2F,(:Neg-:Const)		neg
2H	OCTA	1B+1,0,'x'<<56+(:Var-:Const)		x
]]
[[SET DY
1H	OCTA 	0B+1,2F,(:Neg-:Const)		neg
2H	OCTA	1B+1,0,1<<32			1
]]
[[Driver]]
[[END 310]]

[[TEST 400]]
[[COMMENT Topology: Y = 42 + X, DY = 1]]
[[SET Y
1H	OCTA 	0B+1,2F,(:Add-:Const)			+
2H	OCTA	3F,0,42<<32			42
3H	OCTA	1B+1,0,'x'<<56+(:Var-:Const)		x
]]
[[SET DY
1H	OCTA 	0B+1,0,1<<32			1
]]
[[Driver]]
[[END 400]]

[[TEST 410]]
[[COMMENT Topology: Y = X + 42, DY = 1]]
[[SET Y
1H	OCTA 	0B+1,2F,(:Add-:Const)			+
2H	OCTA	3F,0,'x'<<56+(:Var-:Const)		x
3H	OCTA	1B+1,0,42<<32			42
]]
[[SET DY
1H	OCTA 	0B+1,0,1<<32			1
]]
[[Driver]]
[[END 410]]

[[TEST 420]]
[[COMMENT Topology: Y = 10 + 42, DY = 0]]
[[SET Y
1H	OCTA 	0B+1,2F,(:Add-:Const)			+
2H	OCTA	3F,0,10<<32			10
3H	OCTA	1B+1,0,42<<32			42
]]
[[SET DY
1H	OCTA 	0B+1,0,0			0
]]
[[Driver]]
[[END 420]]

[[TEST 430]]
[[COMMENT Topology: Y = X + X, DY = 1 + 1]]
[[SET Y
1H	OCTA 	0B+1,2F,(:Add-:Const)			+
2H	OCTA	3F,0,'x'<<56+(:Var-:Const)		x
3H	OCTA	1B+1,0,'x'<<56+(:Var-:Const)		x
]]
[[SET DY
1H	OCTA 	0B+1,2F,(:Add-:Const)			+
2H	OCTA	3F,0,1<<32			1
3H	OCTA	1B+1,0,1<<32			1
]]
[[Driver]]
[[END 430]]

[[TEST 500]]
[[COMMENT Topology: Y = 42 - X, DY = -1]]
[[SET Y
1H	OCTA 	0B+1,2F,(:Sub-:Const)			-
2H	OCTA	3F,0,42<<32			42
3H	OCTA	1B+1,0,'x'<<56+(:Var-:Const)		x
]]
[[SET DY
1H	OCTA 	0B+1,2F,(:Neg-:Const)			neg
2H	OCTA 	1B+1,0,1<<32			1
]]
[[Driver]]
[[END 500]]

[[TEST 510]]
[[COMMENT Topology: Y = X - 42, DY = 1]]
[[SET Y
1H	OCTA 	0B+1,2F,(:Sub-:Const)			-
2H	OCTA	3F,0,'x'<<56+(:Var-:Const)		x
3H	OCTA	1B+1,0,42<<32			42
]]
[[SET DY
1H	OCTA 	0B+1,0,1<<32			1
]]
[[Driver]]
[[END 510]]

[[TEST 520]]
[[COMMENT Topology: Y = 10 - 42, DY = 0]]
[[SET Y
1H	OCTA 	0B+1,2F,(:Sub-:Const)			-
2H	OCTA	3F,0,10<<32			10
3H	OCTA	1B+1,0,42<<32			42
]]
[[SET DY
1H	OCTA 	0B+1,0,0			0
]]
[[Driver]]
[[END 520]]

[[TEST 530]]
[[COMMENT Topology: Y = X - X, DY = 1 - 1]]
[[SET Y
1H	OCTA 	0B+1,2F,(:Sub-:Const)			-
2H	OCTA	3F,0,'x'<<56+(:Var-:Const)		x
3H	OCTA	1B+1,0,'x'<<56+(:Var-:Const)		x
]]
[[SET DY
1H	OCTA 	0B+1,2F,(:Sub-:Const)			+
2H	OCTA	3F,0,1<<32			1
3H	OCTA	1B+1,0,1<<32			1
]]
[[Driver]]
[[END 530]]

[[TEST 600]]
[[COMMENT Topology: Y = 42 * X, DY = 42]]
[[SET Y
1H	OCTA 	0B+1,2F,(:Mul-:Const)			*
2H	OCTA	3F,0,42<<32			42
3H	OCTA	1B+1,0,'x'<<56+(:Var-:Const)		x
]]
[[SET DY
1H	OCTA 	0B+1,0,42<<32			1
]]
[[Driver]]
[[END 600]]

[[TEST 610]]
[[COMMENT Topology: Y = X * 42, DY = 42]]
[[SET Y
1H	OCTA 	0B+1,2F,(:Mul-:Const)			*
2H	OCTA	3F,0,'x'<<56+(:Var-:Const)		x
3H	OCTA	1B+1,0,42<<32			42
]]
[[SET DY
1H	OCTA 	0B+1,0,42<<32			42
]]
[[Driver]]
[[END 610]]

[[TEST 620]]
[[COMMENT Topology: Y = 10 * 42, DY = 0]]
[[SET Y
1H	OCTA 	0B+1,2F,(:Mul-:Const)			*
2H	OCTA	3F,0,10<<32			10
3H	OCTA	1B+1,0,42<<32			42
]]
[[SET DY
1H	OCTA 	0B+1,0,0			0
]]
[[Driver]]
[[END 620]]

[[TEST 630]]
[[COMMENT Topology: Y = X * X, DY = X + X]]
[[SET Y
1H	OCTA 	0B+1,2F,(:Mul-:Const)			*
2H	OCTA	3F,0,'x'<<56+(:Var-:Const)		x
3H	OCTA	1B+1,0,'x'<<56+(:Var-:Const)		x
]]
[[SET DY
1H	OCTA 	0B+1,2F,(:Add-:Const)			+
2H	OCTA	3F,0,'x'<<56+(:Var-:Const)		x
3H	OCTA	1B+1,0,'x'<<56+(:Var-:Const)		x
]]
[[Driver]]
[[END 630]]

[[TEST 700]]
[[COMMENT Topology: Y = 1 / X, DY = -(1/X^2)]]
[[SET Y
1H	OCTA 	0B+1,2F,(:Div-:Const)			/
2H	OCTA	3F,0,1<<32			1
3H	OCTA	1B+1,0,'x'<<56+(:Var-:Const)		x
]]
[[SET DY
1H	OCTA 	0B+1,2F,(:Neg-:Const)			neg
2H	OCTA 	1B+1,3F,(:Div-:Const)			/
3H	OCTA 	4F,0,1<<32			1
4H	OCTA 	2B+1,5F,:Pwr-:Const			^
5H	OCTA 	6F,0,'x'<<56+(:Var-:Const)		x
6H	OCTA 	4B+1,0,2<<32			2
]]
[[Driver]]
[[END 700]]

[[TEST 710]]
[[COMMENT Topology: Y = X / 42, DY = 1/42]]
[[SET Y
1H	OCTA 	0B+1,2F,(:Div-:Const)			/
2H	OCTA	3F,0,'x'<<56+(:Var-:Const)		x
3H	OCTA	1B+1,0,42<<32			42
]]
[[SET DY
1H	OCTA 	0B+1,2F,(:Div-:Const)			/
2H	OCTA	3F,0,1<<32		1
3H	OCTA	1B+1,0,42<<32			42
]]
[[Driver]]
[[END 710]]

[[TEST 720]]
[[COMMENT Topology: Y = 10 / 42, DY = 0]]
[[SET Y
1H	OCTA 	0B+1,2F,(:Div-:Const)			/
2H	OCTA	3F,0,10<<32			10
3H	OCTA	1B+1,0,42<<32			42
]]
[[SET DY
1H	OCTA 	0B+1,0,0			0
]]
[[Driver]]
[[END 720]]

[[TEST 730]]
[[COMMENT Topology: Y = X / X, DY = 1/X - X/X^2]]
[[SET Y
1H	OCTA 	0B+1,2F,(:Div-:Const)			/
2H	OCTA	3F,0,'x'<<56+(:Var-:Const)		x
3H	OCTA	1B+1,0,'x'<<56+(:Var-:Const)		x
]]
[[SET DY
1H	OCTA 	0B+1,2F,(:Sub-:Const)			-
2H	OCTA	3F,4F,(:Div-:Const)			/
3H	OCTA	1B+1,6F,(:Div-:Const)			/

4H	OCTA	5F,0,1<<32			1
5H	OCTA	2B+1,0,'x'<<56+(:Var-:Const)		x

6H	OCTA	7F,0,'x'<<56+(:Var-:Const)		x
7H	OCTA	3B+1,8F,:Pwr-:Const			^

8H	OCTA	9F,0,'x'<<56+(:Var-:Const)		x
9H	OCTA	7B+1,0,2<<32			2
]]
[[Driver]]
[[END 730]]


[[TEST 800]]
[[COMMENT Topology: Y = 42 ^ X, DY = 42]]
[[SET Y
1H	OCTA 	0B+1,2F,(:Pwr-:Const)			^
2H	OCTA	3F,0,42<<32			42
3H	OCTA	1B+1,0,'x'<<56+(:Var-:Const)		x
]]
[[SET DY
1H	OCTA 	0B+1,2F,:Mul-:Const			*
2H	OCTA 	4F,3F,:Ln-:Const			ln
3H	OCTA 	2B+1,0,42<<32			42

4H	OCTA 	1B+1,5F,(:Pwr-:Const)			^
5H	OCTA	6F,0,42<<32			42
6H	OCTA	4B+1,0,'x'<<56+(:Var-:Const)		x
]]
[[Driver]]
[[END 800]]

[[TEST 810]]
[[COMMENT Topology: Y = X ^ 42, DY = 42*x^41]]
[[SET Y
1H	OCTA 	0B+1,2F,(:Pwr-:Const)			^
2H	OCTA	3F,0,'x'<<56+(:Var-:Const)		x
3H	OCTA	1B+1,0,42<<32			42
]]
[[SET DY
1H	OCTA 	0B+1,2F,(:Mul-:Const)			*
2H	OCTA 	3F,0,42<<32			42
3H	OCTA 	1B+1,4F,(:Pwr-:Const)			^
4H	OCTA	5F,0,'x'<<56+(:Var-:Const)		x
5H	OCTA	3B+1,0,41<<32			41
]]
[[Driver]]
[[END 810]]

[[TEST 820]]
[[COMMENT Topology: Y = 10 ^ 42, DY = 0]]
[[SET Y
1H	OCTA 	0B+1,2F,(:Pwr-:Const)			^
2H	OCTA	3F,0,10<<32			10
3H	OCTA	1B+1,0,42<<32			42
]]
[[SET DY
1H	OCTA 	0B+1,0,0			0
]]
[[Driver]]
[[END 820]]

[[TEST 821]]
[[COMMENT Topology: Y = 1^ 2, DY = 0]]
[[SET Y
1H	OCTA 	0B+1,2F,(:Pwr-:Const)			^
2H	OCTA	3F,0,1<<32			10
3H	OCTA	1B+1,0,2<<32			42
]]
[[SET DY
1H	OCTA 	0B+1,0,0			0
]]
[[Driver]]
[[END 821]]

[[TEST 822]]
[[COMMENT Topology: Y = 1^ 3, DY = 0]]
[[SET Y
1H	OCTA 	0B+1,2F,(:Pwr-:Const)			^
2H	OCTA	3F,0,1<<32			10
3H	OCTA	1B+1,0,3<<32			42
]]
[[SET DY
1H	OCTA 	0B+1,0,0			0
]]
[[Driver]]
[[END 822]]

[[TEST 830]]
[[COMMENT Topology: Y = X ^ X, DY = X + X]]
[[SET Y
1H	OCTA 	0B+1,2F,(:Pwr-:Const)			^
2H	OCTA	3F,0,'x'<<56+(:Var-:Const)		x
3H	OCTA	1B+1,0,'x'<<56+(:Var-:Const)		x
]]
[[SET DY
1H	OCTA 	0B+1,2F,(:Add-:Const)			+
2H	OCTA	3F,4F,(:Mul-:Const)			*
3H	OCTA	1B+1,0F,(:Mul-:Const)			*

4H	OCTA	5F,0,'x'<<56+(:Var-:Const)		x
5H	OCTA	2B+1,6F,(:Pwr-:Const)			^
6H	OCTA	7F,0,'x'<<56+(:Var-:Const)		x
7H	OCTA	5B+1,8F,(:Sub-:Const)			-
8H	OCTA	9F,0,'x'<<56+(:Var-:Const)		x
9H	OCTA	7B+1,0,1<<32			1
				
0H	OCTA 	4F,7F,:Ln-:Const			ln
7H	OCTA 	0B+1,0,'x'<<56+(:Var-:Const)		x

4H	OCTA 	3B+1,5F,(:Pwr-:Const)			^
5H	OCTA	6F,0,'x'<<56+(:Var-:Const)		x
6H	OCTA	4B+1,0,'x'<<56+(:Var-:Const)		x


]]
[[Driver]]
[[END 830]]
