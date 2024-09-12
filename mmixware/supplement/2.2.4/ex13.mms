%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	2.2.4/ex13.mms
%	Author:	M.Ruckert
%	Title:	Exercise 13, Erase
% ---------------------------- Program A ------------------------------
% Call with PUSHJ $R,Add, with polynomials in $(R+1) 
% The polynomial pointed to by P is erased
%%%
	PREFIX	:Erase:
LINK    IS      0              Definition of link field
%%%
p       IS      $0		Parameter \.P.
t	IS	$1		Temporary variable
%%%on
:Erase	LDOU	t,p,LINK	Get first node.
	STOU	:avail,p,LINK	Link end of polynomial to the \.AVAIL. list.
	SET	:avail,t	Point \.AVAIL. to first node.
	POP	0,0		Done.\quad\slug
%%%off