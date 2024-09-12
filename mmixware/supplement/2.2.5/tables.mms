%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	2.2.5/tables.mms
%	Author:	M.Ruckert
%	Title:	Fixed-size Tables and List Heads
%%%on
		LOC	Data_Segment
WAIT		OCTA	USER1,USER1,0,0	List head for \.WAIT. list\lineref|waithead|
USER1		OCTA	WAIT,WAIT,U1,0	User action U1\lineref|nodes|
wait	 	GREG	WAIT		Pointer to \.WAIT. list head
%%%
ELEV1		OCTA	0,0,E1,0	Elevator actions except E5 and E9
ELEV2		OCTA	0,0,E5,0	Elevator action E5
ELEV3		OCTA	0,0,E9,0	Elevator action E9\lineref|nodesend|
%%%
time		GREG	0		Current simulated time
c		GREG	0		Current node
c0		GREG	0		Backup for current node
%%%
queue		GREG	@-4*8		Pointer to \.QUEUE[$0$]. list head
		OCTA	@-4*8,@-4*8	List head for \.QUEUE[$0$].\lineref|queuehead|
		OCTA	@-4*8,@-4*8	List head for \.QUEUE[$1$].
		OCTA	@-4*8,@-4*8	(All queues are 
		OCTA	@-4*8,@-4*8	\qquad initially empty.)
		OCTA	@-4*8,@-4*8	List head for \.QUEUE[$4$].\lineref|queueheadend|
%%%		
elevator	GREG	@-4*8		Pointer to \.ELEVATOR. list head
		OCTA	@-4*8,@-4*8	List head for \.ELEVATOR.\lineref|elevatorhead|
%%%
%%%off		\slug