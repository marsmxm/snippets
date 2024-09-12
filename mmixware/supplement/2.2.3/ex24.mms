%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	2.2.3/ex24.mms
%	Author:	M.Ruckert
%	Title:	Exercise 24, Program T
COUNT		IS	0
QLINK		IS	0
TOP		IS	4
SUC		IS	0
NEXT		IS	4

%%%		LOC	Data_Segment		Defined in the test framework

%%%		GREG	@
%%%Fin		IS	3
%%%Fout		IS	4
%%%InName	BYTE	"data.in"		
%%%OutName	BYTE	"data.out"		
%%%InOpen		OCTA	InName,:BinaryRead
%%%OutOpen		OCTA	OutName,:BinaryWrite
%%%Args		OCTA	Buffer,BufSize
%%%BufSize		IS	256*2*4			
%%%Buffer	OCTA	0			
%%%		LOC	Buffer+BufSize
%%%		GREG	@
%%%Sentinel	OCTA	0		Terminates input buffer	
%%%Base		OCTA	0		The remaining Data_Segment for X.
%%%		LOC	#100
		PREFIX	:Tsort:
n		IS	$0		Return value
avail		IS	$1
rJ 		IS	$2
count		IS	$3
top		IS	$4
suc		IS	count
next		IS	top
qlink		IS	count
i		IS	$5
j		IS	$6
k		IS	$7
left		IS	$8	
right		IS	$9	
p		IS	$10	
r		IS	$11
c		IS	$12
s		IS	$13
f		IS	$14
sb		IS	$15
t		IS	$16

:Tsort		LDA	$255,InOpen	 1 &\ut T1. Initialize.\\
		TRAP	0,:Fopen,Fin	 1 &Open input file.
		LDA	$255,IOArgs	 1 &
		TRAP	0,:Fread,Fin	 1 &	Read first input buffer.
		LDA	left,Sentinel	 1 &Point $J$ to the buffer end
		ADDU	right,left,4		 1 &Point $K$ to next \.TETRA..
		SET	sb,BufSize	 1 &Load buffer size.
		NEG	i,sb		 1 &Point $i$ to the buffer start.
		LDT	n,right,i		 1 &Load first pair $(0,n)$
		ADD	i,i,8		 1 &
		SET	avail,8		 1 &Allocate \.QLINK[$0$]..
		8ADDU	avail,n,avail	 1 &Allocate $n$  \.COUNT. and \.TOP. fields.
		LDA	count,Base+COUNT  1 &$\.count. \is $\.LOC(COUNT[$0$]).$.
		LDA	top,Base+TOP	 1 &$\.top. \is \.LOC(TOP[$0$]).$.
		SL	k,n,3		 1 &For $0\le k \le n$
1H		STCO	0,count,k	 n+1 &\qquad $(\.COUNT[$k$].,\.TOP[$k$].)\is 0$.
		SUB	k,k,8		 n+1 &
		PBNN	k,1B		 n+1\bg{1}& Anticipate $\.QLINK[$0$].\is0$ in step T4.
		JMP	T2		 1 &
%%%
T3		SL	k,k,3		 m &\ut T3. Record the relation.\\
		LDT	c,count,k	 m &Increase $\.COUNT[$k$].$ by one.
		ADD	c,c,1		 m &
		STT	c,count,k	 m &
		SET	p,avail		 m &$P\Leftarrow \.AVAIL.$.
		ADD	avail,avail,8	 m &
		STT	k,suc,p		 m &$\.SUC(P).\is k$.
		SL	j,j,3		 m &
		LDTU	t,top,j		 m &$\.NEXT(P).\is \.TOP[$j$].$.
		STTU	t,next,p	 m &
		STTU	p,top,j		 m &$\.TOP[$j$].\is P$.
%%%
T2		LDT	j,left,i		 m+b &\ut T2. Next relation.\\
		LDT	k,right,i		 m+b &
		ADD	i,i,8		 m+b &
		PBNZ	j,T3		 m+b\bg{b} &End of input or buffer?
%%%
1H		BNP	i,T4		 b\bg{1} &End of input?
		TRAP	0,:Fread,Fin	 b-1 &Read next buffer.
		NEG	i,sb		 b-1 &Point $i$ to the buffer start.
		JMP	T2		 b-1 &
%%%
T4		TRAP	0,:Fclose,Fin	 1 &\ut T4. Scan for zeros.\\
		SET	r,0		 1 &$r\is 0$.
		SL	k,n,3		 1 &For $1\le k \le n$
1H		LDT	c,count,k	 n &examine $\.COUNT[$k$].$,
		PBNZ	c,0F		 n\bg{a} &and if it is zero,
		STT	k,qlink,r	 a &\qquad $\.QLINK[$r$].\is k$,
		SET	r,k		 a &\qquad $r\is k$.
0H		SUB	k,k,8		 n &
		PBP	k,1B		 n\bg{1} &
		LDT	f,qlink,0	 1 &$f\is\.QLINK[$0$].$.  
%%%
		LDA	$255,OutOpen 	 1 &Open output file.
		TRAP	0,:Fopen,Fout	 1 &
		NEG	i,sb		 1 &Point $i$ to the buffer start.
		SL	k,n,3		      & Prepare for T9: $k\is n$.
		JMP	T5		 1 &
%%%
T5B		PBN	i,0F		 n \bg{c-1} &Test whether buffer is full
		LDA	$255,IOArgs	 c-1 &
		TRAP	0,:Fwrite,Fout	 c-1 &Flush output buffer.
		NEG	i,sb		 c-1 &Point $i$ to the buffer start.
0H		SUB	n,n,1		 n &$n\is n-1$.
		LDTU	p,top,f		 n &$P\is\.TOP[$f$].$.
		SET	t,0
		STTU	t,top,f		
		BZ	p,T7		 n\bg{d} &If $P=\Lambda$ go to T7.
%%%
T6		LDT	s,suc,p		 m &\ut T6. Erase relations.\\
		LDT	c,count,s	 m &Decrease $\.COUNT[$\.SUC(P).$].$.
		SUB	c,c,1		 m &
		STT	c,count,s	 m &
		PBNZ	c,0F		 m\bg{n-a} &If zero,
		STT	s,qlink,r	 n-a &\qquad $\.QLINK[$r$].\is \.SUC(P).$,
		SET	r,s		 n-a &\qquad $r\is \.SUC(P).$.
0H		LDT	p,next,p	 m &$P\is \.NEXT(P).$.
		PBNZ	p,T6		 m\bg{n-d} &If $P=\Lambda$ go to T7.
%%%
T7		LDT	f,qlink,f	 n &\ut T7. Remove from queue.\\
%%%
T5		SR	t,f,3		 n+1 &\ut T5. Output front of queue.\\
		STT	t,left,i		 n+1 &Output the value of $f$
		ADD	i,i,4		 n+1 &
		PBNZ	f,T5B		 n+1\bg{1} &If $f=0$ go to T8.
%%%
T8		LDA	$255,IOArgs	 1 &\ut T8 End of process.\\
		TRAP	0,:Fwrite,Fout	 1 &Flush output buffer.
		TRAP	0,:Fclose,Fout	 1 &Close output file.\lineref|2.2.3T8|
		BNZ	n,T9
		PUT	:rJ,rJ	 1 &
		POP	1,0		      &Return $n$.
%%%on
T9 		GET	rJ,:rJ	        &
		GETA	$255,Msg	&^{GETA+<GETA> (get address)}
		TRAP	0,:Fputs,:StdErr & Print indication of loop.^{Fputs+<Fputs> operation}^{StdErr+<StdErr> (standard error)}^{Standard error file}
		SET	t,0		& $\.t.\is 0$.
1H		LDTU	p,top,k		&$\.P.\is\.TOP[$k$].$.
		STT	t,top,k		&$\.TOP[$k$].\is 0$.
%%%
T10		BZ	p,0F		& Resume T9 if $\.P.= \Lambda$.
		LDT	t,suc,p		& 
		STT	k,qlink,t	& $\.QLINK[SUC(P)].\is k$.
		LDT	p,next,p	&$\.P.\is \.NEXT(P).$.
		BNZ	p,T10		& Is $\.P.= \Lambda$?
%%%
0H		SUB	k,k,8		& $k\is k-1$.
		BP	k,1B		& Repeat while $k>0$.
%%%		
T11		ADD	k,k,8		& $k\is k+1$.
		LDT	t,qlink,k	
		BZ	t,T11		& Find $k$ with $\.QLINK[$k$].\ne 0$.
%%%
T12		STT	k,top,k		& $\.TOP[$k$].\is k$.
		LDT	k,qlink,k	& $k\is\.QLINK[$k$].$.
		LDT	t,top,k		&
		BZ	t,T12		& Repeat if $\.TOP[$k$].= 0$.
%%%
T13		SR	t+1,k,3		& Scale back.
		PUSHJ	t,:Println	& Assume this prints $k$ on \.StdErr.^{StdErr+<StdErr> (standard error)}.^{Standard error file}
		LDT	t,top,k		&
		BZ	t,1F		& Stop when $\.TOP[$k$].=0$.
		SET	t,0
		STT	t,top,k		& $\.TOP[$k$].\is 0$.
		LDT	k,qlink,k	& $k\is\.QLINK[$k$].$.
		JMP	T13
%%%
1H		PUT	:rJ,rJ	
		POP	0,0		& Return.
%%%
Msg		BYTE	"Loop detected"
                BYTE	" in input:",#a,0  &\slug
%%%off
		PREFIX	: