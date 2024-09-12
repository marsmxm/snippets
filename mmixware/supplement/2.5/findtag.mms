%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	2.5/findtag.mms
%	Author:	M.Ruckert
%	Title:	Exercise 27, FindTag subroutine
%%%on
		PREFIX	:FindTag:	&\pageref|2.5findtag|
p		IS	$0		&Parameter
tag		IS	$2		&Primary return value
mask		IS	$0		&Second return value	
address		IS	$1		&Third return value
t		IS	$3		&Temporary variable
%%\mmsskip
:FindTag	SR	address,p,7		&$\.address.\is \lfloor (\.P./16/64)*8 \rfloor$.
		SR	t,p,4			
		AND	t,t,64-1		&$\.t.\is  \lfloor \.P./16 \rfloor\mod 64$.
		SETH	mask,#8000
		SRU	mask,mask,t		&$\.mask.\is 2^{63-\.t.}$.
		LDOU	tag,:tags,address
		POP	3,0			&Return \.tag., \.mask., and \.address..\quad\slug
%%%off