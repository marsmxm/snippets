%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	2.2.3/tsort.mms
%	Author:	M.Ruckert
%	Title:	Program T, Topological Sort
		PREFIX	:TSort:
		LOC	:Data_Segment		Defined in the test framework

		GREG	@
Fin		IS	3
Fout		IS	4
InName		BYTE	0  /* we fake input and output */
		BYTE	0
OutName		BYTE	0
		BYTE	0
InOpen		OCTA	InName,:BinaryRead
OutOpen		OCTA	OutName,:BinaryWrite
SIZE		IS	256*2*4			
Buffer		[[Data]]			
		LOC	Buffer+SIZE
		GREG	@
Sentinel	OCTA	0		Terminates input buffer
IOArgs		OCTA	Buffer,SIZE
Data		[[Data]]
		LOC	Data+SIZE	Fake input buffer
		GREG	@
Sorted		[[Sorted]]	

Base		OCTA	0		Last OCTA in data segment.

		LOC	#100


COUNT		IS	0
QLINK		IS	0
TOP		IS	4
SUC		IS	0
NEXT		IS	4


n		IS	$0	
:avail		IS	$1
count		IS	$2
top		IS	$3
suc		IS	count
next		IS	top
qlink		IS	count
i		IS	$4
j		IS	$5
k		IS	$6
left		IS	$7	
right		IS	$8	
p		IS	$9	
r		IS	$10
s		IS	$12
f		IS	$13
size		IS	$14
t		IS	$15

%%%on
:TSort		LDA	$255,InOpen	 1 &\ut T1. Initialize.\\
		TRAP	0,:Fopen,Fin	 1 &Open input file.^{Fopen+<Fopen> operation}
		LDA	$255,IOArgs	 1 &
		TRAP	0,:Fread,Fin	 1 &Read first input buffer.^{Fread+<Fread> operation}
		SET	size,SIZE	 1 &Load buffer size.
		LDA	left,Buffer+SIZE 1 &Point \.left. to the buffer end.
		ADDU	right,left,4	 1 &Point \.right. to next \.TETRA..
		NEG	i,size		 1 &$i\is 0$.
		LDT	n,right,i	 1 &First pair is $(0,n)$, $\.n.\is n$.
		ADD	i,i,8		 1 &$i\is i+1$.
		SET	:avail,8	 1 &Allocate \.QLINK[$0$]..\lineref|2.2.3malloc0|
		8ADDU	:avail,n,:avail	 1 &Allocate $n$  \.COUNT. and \.TOP. fields.\lineref|2.2.3malloc1|
		LDA	count,Base+COUNT 1 &$\.count. \is \.LOC(COUNT[$0$]).$.\lineref|2.2.3base|
		LDA	top,Base+TOP	 1 &$\.top. \is \.LOC(TOP[$0$]).$.
		SL	k,n,3		 1 &$k\is n$.
1H		STCO	0,k,count	 n+1 &Set $(\.COUNT[$k$].,\.TOP[$k$].)\is (0,0)$,^{STCO+<STCO> (store constant octabyte)}
		SUB	k,k,8		 n+1 &\qquad for $0\le k \le n$.
		PBNN	k,1B		 n+1\bg{1}& Anticipate $\.QLINK[$0$].\is0$ (step T4).
		JMP	T2		 1 &\sourcenext
%%%
T3		SL	k,k,3		 m &\ut T3. Record the relation.\\
		LDT	t,k,count	 m &Increase $\.COUNT[$k$].$ by one.
		ADD	t,t,1		 m &
		STT	t,k,count	 m &
		SET	p,:avail		 m &$\.P.\Leftarrow \.AVAIL.$.\lineref|2.2.3malloc2|
		ADD	:avail,:avail,8	 m &\lineref|2.2.3malloc3|
		STT	k,suc,p		 m &$\.SUC(P).\is k$.
		SL	j,j,3		 m &
		LDTU	t,top,j		 m &$\.NEXT(P).\is \.TOP[$j$].$.
		STTU	t,next,p	 m &
		STTU	p,top,j		 m &$\.TOP[$j$].\is \.P.$.
%%%
T2		LDT	j,left,i	 m+b &\ut T2. Next relation.\\
		LDT	k,right,i	 m+b &
		ADD	i,i,8		 m+b &$i\is i+1$.
		PBNZ	j,T3		 m+b\bg{b} &End of input or buffer?
%%%
1H		BNP	i,T4		 b\bg{1} &End of input?
		TRAP	0,:Fread,Fin	 b-1 &Read next buffer.
		NEG	i,size		 b-1 &$i\is 0$.
		JMP	T2		 b-1 &
%%%
T4		TRAP	0,:Fclose,Fin	 1 &\ut T4. Scan for zeros.\\^{Fclose+<Fclose> operation}
		SET	r,0		 1 &$\.R.\is 0$.
		SL	k,n,3		 1 &$k\is n$.
1H		LDT	t,k,count	 n &Examine $\.COUNT[$k$].$,
		PBNZ	t,0F		 n\bg{a} &and if it is zero,
		STT	k,qlink,r	 a &\qquad set $ \.QLINK[R].\is k$,
		SET	r,k		 a &\qquad and $\.R.\is k$.
0H		SUB	k,k,8		 n &
		PBP	k,1B		 n\bg{1} & For $n\ge k> 0$.
		LDT	f,qlink,0	 1 &$\.F.\is\.QLINK[$0$].$.  
%%%
		LDA	$255,OutOpen 	 1 &Open output file.
		TRAP	0,:Fopen,Fout	 1 &
		NEG	i,size		 1 &Point $i$ to the buffer start.\lineref|2.2.3T5start|
		JMP	T5		 1 &\sourcenext
%%%
T5B		PBN	i,0F		 n \bg{c-1} &Jump if buffer is not full.
		LDA	$255,IOArgs	 c-1 &
		TRAP	0,:Fwrite,Fout	 c-1 &Flush output buffer.^{Fwrite+<Fwrite> operation}
		NEG	i,size		 c-1 &Point $i$ to the buffer start.
0H		SUB	n,n,1		 n &$\.n.\is \.n.-1$.
		LDTU	p,top,f		 n &$\.P.\is\.TOP[F].$.\lineref|2.2.3T5|	
		BZ	p,T7		 n\bg{d} &If $\.P.=\Lambda$ go to T7.
%%%
T6		LDT	s,suc,p		 m &\ut T6. Erase relations.\\
		LDT	t,s,count	 m &Decrease \.COUNT[SUC(P)]..
		SUB	t,t,1		 m &
		STT	t,s,count	 m &
		PBNZ	t,0F		 m\bg{n-a} &If zero,
		STT	s,qlink,r	 n-a &\qquad set $\.QLINK[R].\is \.SUC(P).$,
		SET	r,s		 n-a &\qquad and $\.R.\is \.SUC(P).$.
0H		LDT	p,next,p	 m &$\.P.\is \.NEXT(P).$.
		PBNZ	p,T6		 m\bg{n-d} &If $\.P.=\Lambda$ go to T7.
%%%
T7		LDT	f,qlink,f	 n &\ut T7. Remove from queue.\\
%%%
T5		SR	t,f,3		 n+1 &\ut T5. Output front of queue.\\
		STT	t,left,i		 n+1 &Output the value of \.F..
		ADD	i,i,4		 n+1 &
		PBNZ	f,T5B		 n+1\bg{1} &If $\.F.=0$ go to T8.
%%%
T8		LDA	$255,IOArgs	 1 &\ut T8. End of process.\\
		TRAP	0,:Fwrite,Fout	 1 &Flush output buffer.
		TRAP	0,:Fclose,Fout	 1 &Close output file.\lineref|2.2.3T8|
		POP	1,0		   &Return \.n..\quad\slug\lineref|2.2.3Tlast|
%%%rt 2.2.3tsort.rt & (22m+22n+14b+9c+50)\upsilon+ (12m+6n+2b+4)\mu
%%%off
		PREFIX	: