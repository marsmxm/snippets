%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	2.2.5/main.mms
%	Author:	M.Ruckert
%	Title:	Main program
		PREFIX	:
%%%on		
Main		SET 	 floor,2   			Start with $\.FLOOR. = 2$,
		SET 	 state,0   			\quad $ \.STATE. = \.NEUTRAL.$,
		SETH	 poolmax,Pool_Segment>>48 	\quad and no extra nodes.
		TRIP  	 Cycle,0,0   			Begin simulation.\quad\slug
%%%off