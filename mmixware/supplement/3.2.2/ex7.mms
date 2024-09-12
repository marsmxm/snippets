%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	3.2.2/ex7.mms
%	Author:	M.Ruckert
%	Title:	Exercise 7
s	IS	$0

t	IS	$1

%%%on
	ZSN	t,x,a
%%% t=a for x<0 t=0 for x>=0
	SLU	x,x,1
	ZSZ	s,x,a
%%% s=a for 2x=0 s=0 for 2x \ne 0
	XOR	x,x,t
	XOR	x,x,s		\quad\slug
%%% 2x^s^t =0 for x=10000..., =a for x=0, =2x^a for x<0, = 2x for x>0
%%%off