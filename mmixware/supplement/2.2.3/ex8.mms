%%%off
%	Copyright: This file is part of the MMIX Supplement package (c) Martin Ruckert 2014
%	File:	2.2.3/ex8.mms
%	Author:	M.Ruckert
%	Title:	Exercise 8, Revert
	PREFIX	:Revert:
%%%
LINK	IS	0			Offset for the \.LINK. field.
%%%
%%
first   IS $0	Parameter
p       IS $1
q       IS $2
r       IS $3  
%%%on
:Revert LDO  p,first     1 & \ut  I1.\\ $\.P.\is\.FIRST.$.
        BZ   p,2F        1\bg{0} & \ut  I2.\\ If the list is empty, jump.
        SET  q,0      	 1 & $\.Q.\is \Lambda$.
1H      SET  r,q       	 n & $\.R.\is \.Q.$. 
        SET  q,p 	 n & $\.Q.\is \.P.$. 
        LDOU p,q,LINK  	 n & $\.P.\is \.LINK(Q).$. 
        STOU r,q,LINK    n & $\.LINK(Q).\is \.R.$. 
        PBNZ p,1B      	 n\bg{1} & Is $\.P. \ne \Lambda$?
        STOU q,first     1 & \ut  I3.\\ $\.FIRST. \is \.Q.$.
2H      POP  0,0  	   & \slug
%%%off     
        PREFIX :


