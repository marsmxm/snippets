%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	2.2.5/pool.mms
%	Author:	M.Ruckert
%	Title:	Storage Pool
%%%on
avail		GREG	 0		List of available nodes
poolmax		GREG	 0		Location of pool memory
Allocate	PBNZ	 avail,1F	$\.C.\Leftarrow \.AVAIL.$ using 2.2.3--\eq(7).\lineref|allocate|
		SET	 c,poolmax
		ADDU	 poolmax,c,6*8
		POP	 1,0
1H		SET	 c,avail	
		LDOU	 avail,c,LLINK1
		POP	 1,0		\lineref|allocateend|
%%%
Free		STOU	avail,c,LLINK1		$\.AVAIL.\Leftarrow \.C.$ using 2.2.3--\eq(5).\lineref|free|
		SET	avail,c
		POP	0,0		\slug\lineref|freeend|
%%%off