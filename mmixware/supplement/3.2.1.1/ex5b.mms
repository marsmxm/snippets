%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	3.2.1.1/ex5b.mms
%	Author:	M.Ruckert
%	Title:	Exercise 5b
%%%on
	SUBU	t,m,y
	SUBU	s,x,t
	CMPU	t,x,t
	ZSN	t,t,m
	ADDU	s,s,t	\quad\slug
%%%off