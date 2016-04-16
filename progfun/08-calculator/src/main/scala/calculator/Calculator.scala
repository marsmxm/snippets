package calculator

sealed abstract class Expr
final case class Literal(v: Double) extends Expr
final case class Ref(name: String) extends Expr
final case class Plus(a: Expr, b: Expr) extends Expr
final case class Minus(a: Expr, b: Expr) extends Expr
final case class Times(a: Expr, b: Expr) extends Expr
final case class Divide(a: Expr, b: Expr) extends Expr

object Calculator {
  def computeValues(
      namedExpressions: Map[String, Signal[Expr]]): Map[String, Signal[Double]] = {
    namedExpressions.map {case (k, v) => (k, Signal(eval(v(), namedExpressions)))}
  }

  def eval(expr: Expr, references: Map[String, Signal[Expr]]): Double = expr match {
    case Literal(v) => v
    case Ref(name) => {
      val refExpr = getReferenceExpr(name, references)
      if (cyclic(name, refExpr, references)) Double.NaN
      else eval(refExpr, references)
    }
    case Plus(a, b) => eval(a, references) + eval(b, references)
    case Minus(a, b) => eval(a, references) - eval(b, references)
    case Times(a, b) => eval(a, references) * eval(b, references)
    case Divide(a, b) => {
      val bValue = eval(b, references)
      if (bValue == 0) Double.NaN
      else eval(a, references) / bValue
    }
  }

  private def cyclic(name: String, expr: Expr, references: Map[String, Signal[Expr]]): Boolean = expr match {
    case Literal(_) => false
    case Ref(thatName) => {
      val indirectExpr = getReferenceExpr(thatName, references)
      indirectExpr match {
        case Literal(_) => false
        case Ref(thirdName) => thirdName == name
        case Plus(a, b) => cyclic(name, a, references) || cyclic(name, b, references)
        case Minus(a, b) => cyclic(name, a, references) || cyclic(name, b, references)
        case Times(a, b) => cyclic(name, a, references) || cyclic(name, b, references)
        case Divide(a, b) => cyclic(name, a, references) || cyclic(name, b, references)
      }
    }
    case Plus(a, b) => cyclic(name, a, references) || cyclic(name, b, references)
    case Minus(a, b) => cyclic(name, a, references) || cyclic(name, b, references)
    case Times(a, b) => cyclic(name, a, references) || cyclic(name, b, references)
    case Divide(a, b) => cyclic(name, a, references) || cyclic(name, b, references)
  }

  /** Get the Expr for a referenced variables.
   *  If the variable is not known, returns a literal NaN.
   */
  private def getReferenceExpr(name: String,
      references: Map[String, Signal[Expr]]) = {
    references.get(name).fold[Expr] {
      Literal(Double.NaN)
    } { exprSignal =>
      exprSignal()
    }
  }
}
