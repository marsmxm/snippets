<TeXmacs|2.1.1>

<style|generic>

<\body>
  1. Let X and Y be random variables with alphabets X = Y = {1, 2, 3, 4, 5}
  and joint distribution p(x, y) given by

  <\equation*>
    <frac|1|25><bmatrix|<tformat|<table|<row|<cell|11111>>|<row|<cell|21200>>|<row|<cell|20111>>|<row|<cell|03020>>|<row|<cell|00113>>>>>.
  </equation*>

  Calculate H(X), H(Y), H(X\|Y), H(Y\|X), and I(X;Y).

  <strong|Solution>:

  <\eqnarray*>
    <tformat|<table|<row|<cell|H<around*|(|X|)>>|<cell|=>|<cell|-<big|sum><rsub|x<rsup|>>p<around*|(|x|)>*log
    p<around*|(|x|)>>>|<row|<cell|>|<cell|=>|<cell|5*<frac|1|5>*log5>>|<row|<cell|>|<cell|=>|<cell|log5>>>>
  </eqnarray*>

  <\eqnarray*>
    <tformat|<table|<row|<cell|H<around*|(|Y|)>>|<cell|=>|<cell|-<big|sum><rsub|y>p<around*|(|y|)>*log
    p<around*|(|y|)>>>|<row|<cell|>|=|<cell|log 5>>>>
  </eqnarray*>

  <\eqnarray*>
    <tformat|<table|<row|<cell|H<around*|(|X<around*|\||Y|)>|\<nobracket\>>>|<cell|=>|<cell|-<big|sum><rsub|x,y>p<around*|(|x,y|)>*log
    p<around*|(|x<around*|\||y|\<nobracket\>>|)>>>|<row|<cell|>|<cell|=>|<cell|<big|sum><rsub|y>p<around*|(|y|)>*H<around*|(|X<around*|\||Y=y|\<nobracket\>>|)>>>|<row|<cell|>|<cell|=>|<cell|<frac|1|5>*<around*|(|<frac|1|5>*log
    5+<frac|4|5>*<around*|(|log 5-log 2|)>|)>+>>|<row|<cell|>|<cell|>|<cell|<frac|1|5>*<around*|(|<frac|2|5>*log
    5+<frac|3|5>*<around*|(|log 5-log 3|)>|)>+>>|<row|<cell|>|<cell|>|<cell|<frac|1|5>*<around*|(|<frac|3|5>*log
    5+<frac|2|5>*<around*|(|log 5-log 2|)>|)>+>>|<row|<cell|>|<cell|>|<cell|<frac|1|5>*<around*|(|<frac|3|5>*log
    5+<frac|2|5>*<around*|(|log 5-log 2|)>|)>+>>|<row|<cell|>|<cell|>|<cell|<frac|1|5>*<around*|(|<frac|2|5>*log
    5+<frac|3|5>*<around*|(|log 5-log 3|)>|)>>>|<row|<cell|>|<cell|=>|<cell|log
    5-<frac|6|25>*log 3-<frac|8|25>>>>>
  </eqnarray*>

  <\eqnarray*>
    <tformat|<table|<row|<cell|H<around*|(|Y<around*|\||X|\<nobracket\>>|)>>|<cell|=>|<cell|<big|sum><rsub|x>p<around*|(|x|)>*H<around*|(|Y<around*|\||X=x|\<nobracket\>>|)>>>|<row|<cell|>|<cell|=>|<cell|log
    5-<frac|6|25>*log 3-<frac|8|25>>>>>
  </eqnarray*>

  <\eqnarray*>
    <tformat|<table|<row|<cell|I<around*|(|X;Y|)>>|<cell|=>|<cell|H<around*|(|X|)>-H<around*|(|X<around*|\||Y|\<nobracket\>>|)>>>|<row|<cell|>|<cell|=>|<cell|<frac|6|25>*log
    3+<frac|8|25>>>>>
  </eqnarray*>

  \;

  \;

  \;

  \;

  \;

  2. Prove Propositions 2.8, 2.9, 2.19, 2.21, and 2.22.

  <strong|Solution>:

  \;

  Proposition 2.8. <math|X<rsub|1>\<rightarrow\>X<rsub|2>\<rightarrow\>\<cdots\>\<rightarrow\>X<rsub|n>>
  forms a Markov chain if and only if

  <\eqnarray*>
    <tformat|<table|<row|<cell|>|<cell|>|<cell|X<rsub|1>\<rightarrow\>X<rsub|2>\<rightarrow\>X<rsub|3>>>|<row|<cell|>|<cell|>|<cell|<around*|(|X<rsub|1>,X<rsub|2>|)>\<rightarrow\>X<rsub|3>\<rightarrow\>X<rsub|4>>>|<row|<cell|>|<cell|>|<cell|\<vdots\>>>|<row|<cell|>|<cell|>|<cell|<around*|(|X<rsub|1>,X<rsub|2>,\<cdots\>,X<rsub|n-2>|)>\<rightarrow\>X<rsub|n-1>\<rightarrow\>X<rsub|n>>>>>
  </eqnarray*>

  form Markov chains.

  <strong|Proof>.\ 

  If:

  <\eqnarray*>
    <tformat|<table|<row|<cell|X<rsub|1>\<rightarrow\>X<rsub|2>\<rightarrow\>X<rsub|3>>|<cell|\<Rightarrow\>>|<cell|p<around*|(|x<rsub|1>,x<rsub|2>,x<rsub|3>|)>=p<around*|(|x<rsub|1>,x<rsub|2>|)>*p<around*|(|x<rsub|3><around*|\||x<rsub|2>|\<nobracket\>>|)>>>|<row|<cell|<around*|(|X<rsub|1>,X<rsub|2>|)>\<rightarrow\>X<rsub|3>\<rightarrow\>X<rsub|4>>|<cell|\<Rightarrow\>>|<cell|p<around*|(|x<rsub|1>,x<rsub|2>,x<rsub|3>,x<rsub|4>|)>>>|<row|<cell|>|<cell|>|<cell|=p<around*|(|x<rsub|1>,x<rsub|2>,x<rsub|3>|)>*p<around*|(|x<rsub|4><around*|\||x<rsub|3>|\<nobracket\>>|)>>>|<row|<cell|>|<cell|>|<cell|=p<around*|(|x<rsub|1>,x<rsub|2>|)>*p<around*|(|x<rsub|3><around*|\||x<rsub|2>|\<nobracket\>>|)>*p<around*|(|x<rsub|4><around*|\||x<rsub|3>|\<nobracket\>>|)>>>|<row|<cell|>|<cell|\<vdots\>>|<cell|>>|<row|<cell|<around*|(|X<rsub|1>,X<rsub|2>,\<cdots\>,X<rsub|n-2>|)>\<rightarrow\>X<rsub|n-1>\<rightarrow\>X<rsub|n>>|<cell|\<Rightarrow\>>|<cell|p<around*|(|x<rsub|1>,x<rsub|2>,\<cdots\>,x<rsub|n>|)>>>|<row|<cell|>|<cell|>|<cell|=p<around*|(|x<rsub|1>,x<rsub|2>,\<cdots\>,x<rsub|n-1>|)>*p<around*|(|x<rsub|n><around*|\||x<rsub|n-1>|\<nobracket\>>|)>>>|<row|<cell|>|<cell|>|<cell|=p<around*|(|x<rsub|1>,x<rsub|2>,\<cdots\>,x<rsub|n-2>|)>*p<around*|(|x<rsub|n-1><around*|\||x<rsub|n-2>|\<nobracket\>>|)>*p<around*|(|x<rsub|n><around*|\||x<rsub|n-1>|\<nobracket\>>|)>>>|<row|<cell|>|<cell|>|<cell|\<vdots\>>>|<row|<cell|>|<cell|>|<cell|=p<around*|(|x<rsub|1>,x<rsub|2>|)>*p<around*|(|x<rsub|3><around*|\||x<rsub|2>|\<nobracket\>>|)>\<cdots\>p<around*|(|x<rsub|n><around*|\||x<rsub|n-1>|\<nobracket\>>|)>>>>>
  </eqnarray*>

  thus <math|X<rsub|1>\<rightarrow\>X<rsub|2>\<rightarrow\>\<cdots\>\<rightarrow\>X<rsub|n>.>

  Only if:

  <\eqnarray*>
    <tformat|<table|<row|<cell|X<rsub|1>\<rightarrow\>X<rsub|2>\<rightarrow\>\<cdots\>\<rightarrow\>X<rsub|n>>|<cell|\<Rightarrow\>>|<cell|p<around*|(|x<rsub|1>,x<rsub|2>,\<cdots\>,x<rsub|n>|)>=p<around*|(|x<rsub|1>,x<rsub|2>|)>*p<around*|(|x<rsub|3><around*|\||x<rsub|2>|\<nobracket\>>|)>*\<cdots\>**p<around*|(|x<rsub|n><around*|\||x<rsub|n-1>|\<nobracket\>>|)>>>|<row|<cell|>|<cell|>|<cell|>>>>
  </eqnarray*>

  \;

  \;

  \;

  \;

  \;

  \;

  \;

  \;

  \;

  \;

  \;

  \;

  \;

  Proposition 2.9. <math|X<rsub|1>\<rightarrow\>X<rsub|2>\<rightarrow\>\<cdots\>\<rightarrow\>X<rsub|n>>
  forms a Markov chain if and only if\ 

  <\equation*>
    p<around*|(|x<rsub|1>,x<rsub|2>,\<ldots\>,x<rsub|n>|)>=f<rsub|1><around*|(|x<rsub|1>,x<rsub|2>|)>*f<rsub|2><around*|(|x<rsub|2>,x<rsub|3>|)>*\<cdots\>**f<rsub|n-1><around*|(|x<rsub|n-1>,x<rsub|n>|)>
  </equation*>

  for all <math|x<rsub|1>,x<rsub|2>,\<ldots\>,x<rsub|n>> such that
  <math|p<around*|(|x<rsub|2>|)>,p<around*|(|x<rsub|3>|)>,\<ldots\>,p<around*|(|x<rsub|n-1>|)>\<gtr\>0>.

  <space|1em>Note that Proposition 2.9 is a generalization of
  Propositio<abbr|>n 2.5. From Proposition 2.9, one can prove the following
  important property of a Markov chain. Again, the details are left as an
  exercise.

  <em|<em|<strong|Proof>>.>

  The \<#2018\>only if\<#2019\> part follows immediately from the definition.

  if part:

  Assume <math|p<around*|(|x<rsub|1>,x<rsub|2>,\<ldots\>,x<rsub|n>|)>=f<rsub|1><around*|(|x<rsub|1>,x<rsub|2>|)>*f<rsub|2><around*|(|x<rsub|2>,x<rsub|3>|)>*\<cdots\>**f<rsub|n-1><around*|(|x<rsub|n-1>,x<rsub|n>|)>>.

  \;
</body>

<\initial>
  <\collection>
    <associate|info-flag|detailed>
    <associate|page-medium|paper>
  </collection>
</initial>