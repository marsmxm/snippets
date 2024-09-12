%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	3.2.1.1/ex5a.mms
%	Author:	M.Ruckert
%	Title:	Exercise 5a
%%%on
%%%
	SUBU	d,x,y
	CMPU	t,x,y
	ZSN	t,t,m
        ADDU	d,d,t	\quad\slug
%%%off