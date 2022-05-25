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
    <tformat|<table|<row|<cell|H<around*|(|X|)>=>|<cell|-<big|sum><rsub|x<rsup|>>p<around*|(|x|)>*log
    p<around*|(|x|)>>|<cell|>>|<row|<cell|=>|<cell|5*<frac|1|5>*log5>|<cell|>>|<row|<cell|=>|<cell|log5>|<cell|>>>>
  </eqnarray*>

  <\eqnarray*>
    <tformat|<table|<row|<cell|H<around*|(|Y|)>=>|<cell|-<big|sum><rsub|y>p<around*|(|y|)>*log
    p<around*|(|y|)>>|<cell|>>|<row|<cell|=>|<cell|>|<cell|>>>>
  </eqnarray*>

  \;
</body>

<\initial>
  <\collection>
    <associate|info-flag|detailed>
    <associate|page-medium|paper>
  </collection>
</initial>