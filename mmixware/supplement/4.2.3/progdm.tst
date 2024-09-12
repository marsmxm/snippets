[[SET Driver

      LOC	Data_Segment
      GREG	@
Data  IS	@

[[INCLUDE progdm.dat]]

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
      PUSHJ	t,DFmul
      LDOU	w1,p,32
      LDOU	w0,p,40
      
      CMPU	d,t,w1
      BZ	d,1F
      ADDU	t,t,1
      CMPU	d,t,w1
      BNZ	d,Error

1H    CMPU	d,t+1,w0
      BZ	d,1F
      ADDU	t+1,t+1,1
      CMPU	d,t+1,w0
      BNZ	d,Error

   
1H    ADD	p,p,3*16
      SUB	i,i,1
      BP	i,Loop


OK    SET	$255,0; TRAP	0,Halt,0

Error IS	@
      NEG	i,n,i
      [[printi :i]]
      [[printnl]]
      SET	$255,1; TRAP	0,Halt,0
        

[[INCLUDE progdm.mms]]
[[INCLUDE dnormalize.mms]]

]]



[[TEST 1 addition]]
[[Driver]]
[[END 1]]

