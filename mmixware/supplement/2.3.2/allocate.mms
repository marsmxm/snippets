%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	2.3.2/allocate.mms
%	Author:	M.Ruckert
%	Title:	Memmory Allocate and Free
	PREFIX	:Memory:
%%%	return zero initialized node

%%%on
avail		GREG	0
pool		GREG	0
:Allocate	BNZ	avail,1F	\.AVAIL. stack empty?
		SETH	$0,#4000	If so, get 24 bytes 
		ADDU	$0,$0,pool	\qquad from the \.Pool\_Segment..
		ADDU	pool,pool,24
		JMP 	0F
1H		SET	$0,avail	Else, get the next node
		LDOU	avail,avail,:LLINK \qquad from the \.AVAIL. stack.
0H		STCO	0,$0,:RLINK	Zero out the node.
		STCO	0,$0,:LLINK
		STCO	0,$0,:INFO
		POP	1,0
%%%
:Free		STOU	avail,$0,:LLINK	Add node to the \.AVAIL. stack.
		SET	avail,$0
		POP	0,0		\slug
%%%off
		PREFIX	:
