[[SET Driver

      LOC	Data_Segment
      GREG	@
Data  IS	@

[[INCLUDE progda.dat]]

n     IS	(@-Data)/(3*16)		Number of tripples

      LOC	#100

[[INCLUDE print.mms]]

w0    IS	$0
w1    IS	$1
eu    IS	$2
ev    IS	$3
e     IS	$4	
d     IS	$5
p     IS	$6
i     IS	$7
t     IS	$8

Main  LDA	p,Data
      SET	i,n
Loop  LDOU	t+1,p,0
      LDOU	t+2,p,8
      LDOU	t+3,p,16
      LDOU	t+4,p,24
      PUSHJ	t,DFadd
      LDOU	w1,p,32
      LDOU	w0,p,40
      
      CMPU	d,t,w1
      BNZ	d,Error
      SUBU	d,t+1,w0
      BZ	d,1F 
      NEG	t,d
      CSN	d,d,t		get absolute difference.
      LDOU	eu,p,0
      LDOU	ev,p,16
      XOR	t,eu,ev
      SET	e,1		same sign, rounding one bit
      BZ	t,2F
      ANDNH	ev,#8000
      ANDNH	eu,#8000
      SRU	ev,ev,48
      SRU	eu,eu,48
      SUB	eu,eu,ev
      NEG	e,eu
      CSN	e,e,eu		different sign

      SUB	eu,e,0
      ZSNN	e,eu,eu		reduce by 1 bit
      ADD	e,e,1		increase by 1 bit
 
2H    SRU	d,d,e
      BNZ	d,Error
   
1H    ADD	p,p,3*16
      SUB	i,i,1
      BP	i,Loop


OK    SET	$255,0; TRAP	0,Halt,0

Error IS	@
      NEG	i,n+1,i
      [[printi :i]]
      [[printnl]]
      SET	$255,1; TRAP	0,Halt,0
        

[[INCLUDE progdasub.mms]]
[[  INCLUDE dnormalize.mms]]


]]



[[TEST 1 addition]]
[[Driver]]
[[END 1]]

[[SET Driver

       LOC	#100
p       GREG	@
[[Data]]
w1	IS	$0
w0	IS	$1
d	IS	$2
t	IS	$3
Main  LDOU	t+1,p,0
      LDOU	t+2,p,8
      LDOU	t+3,p,16
      LDOU	t+4,p,24
      PUSHJ	t,DFsub
      LDOU	w1,p,32
      LDOU	w0,p,40
      
      CMPU	d,t,w1
      BNZ	d,Error
      CMPU	d,t+1,w0
      BNZ	d,Error

OK    SET	$255,0; TRAP	0,Halt,0

Error SET	$255,1; TRAP	0,Halt,0


[[INCLUDE progdasub.mms]]
[[  INCLUDE dnormalize.mms]]

]]


[[TEST 2 subtraction]]
[[SET Data
u      	OCTA	#3FFF000000000000,#0000000000000000	1.000000 
v	OCTA	#4000000000000000,#0000000000000000	2.000000
w	OCTA	#BFFF000000000000,#0000000000000000	-1.000000

]]
[[Driver]]
[[END 2]]

[[TEST 3 subtraction]]
[[SET Data
u      	OCTA	#3FFF000000000000,#0000000000000000	1.000000 
v	OCTA	#3FFE555555555555,#5555555555555556	0.666667
w	OCTA	#3FFD555555555555,#5555555555555554	0.333333 last bit wrong

]]
[[Driver]]
[[END 3]]