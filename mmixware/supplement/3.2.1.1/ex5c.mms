%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	3.2.1.1/ex5c.mms
%	Author:	M.Ruckert
%	Title:	Exercise 5c
x	IS	$0
y	IS	$1
m	IS	$2
d	IS	$3
sum	IS	$4
t	IS	$5
%%%on
	SUB	d,x,y
	ZSN	t,d,m
	ADD	d,d,t		\quad\slug
%%%off