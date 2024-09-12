%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	2.2.5/control.mms
%	Author:	M.Ruckert
%	Title:	Control Routines
%%%on
%%%
%%%		Control Routines
%%%
		LOC	    0			\.TRIP. entry point
		GET	    $0,rX		$\.\$0.\is \.TRIP X,Y,Z.$.^{rX+rX (execution register for trips)}
		GET	    $1,rW		$\.\$1.\is \.rW.$ (the return address).^{rW+rW (where interrupted register for trips)}^{Where interrupted register}
		SR	    $2,$0,16		Extract \.X. field
		AND	    $2,$2,#FF		\quad and
		GO	    $2,$2,0		\quad dispatch depending on \.X..^{GO+<GO> (go to location)}
Cycle1		STOU	    $1,c,NEXTINST	Set $\.NEXTINST(C).\is \.rW.$.
		JMP	    Cycle
HoldCI		AND	    dt,$0,#FF		Set $\.dt.\is \.Z.$.
HoldC		STOU	    $1,c,NEXTINST	Set $\.NEXTINST(C).\is \.rW.$.
		PUSHJ	    $0,Hold		Insert \.NODE(C). in \.WAIT. with delay \.dt..
Cycle		LDOU	    c,wait,RLINK1	Set $\.C.\is \.RLINK1(LOC(WAIT)).$.
		LDTU	    time,c,NEXTTIME	$\.TIME.\is \.NEXTTIME(C).$.
		PUSHJ	    $0,DeleteW		Remove \.NODE(C). from \.WAIT. list.\lineref|DeleteW| 
		LDOU	    $0,c,NEXTINST
		PUT	    rW,$0		$\.rW.\is\.NEXTINST(C).$.
		SET	    $0,[[cycles]]	%%hide
		CMP	    $0,$0,:time		%%hide
		BN	    $0,1F		%%hide
		RESUME	    0			Return.^{RESUME+<RESUME> (resume after interrupt)}
%%\mmsskip
1H		SET	    $255,0		%%hide
		TRAP	    0,:Halt,0		%%hide
%%%off		\slug