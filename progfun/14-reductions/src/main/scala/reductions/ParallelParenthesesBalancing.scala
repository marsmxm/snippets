package reductions

import scala.annotation._
import org.scalameter._
import common._

object ParallelParenthesesBalancingRunner {

  @volatile var seqResult = false

  @volatile var parResult = false

  val standardConfig = config(
    Key.exec.minWarmupRuns -> 40,
    Key.exec.maxWarmupRuns -> 80,
    Key.exec.benchRuns -> 120,
    Key.verbose -> true
  ) withWarmer(new Warmer.Default)

  def main(args: Array[String]): Unit = {
    val length = 100000000
    val chars = new Array[Char](length)
    val threshold = 10000
    val seqtime = standardConfig measure {
      seqResult = ParallelParenthesesBalancing.balance(chars)
    }
    println(s"sequential result = $seqResult")
    println(s"sequential balancing time: $seqtime ms")

    val fjtime = standardConfig measure {
      parResult = ParallelParenthesesBalancing.parBalance(chars, threshold)
    }
    println(s"parallel result = $parResult")
    println(s"parallel balancing time: $fjtime ms")
    println(s"speedup: ${seqtime / fjtime}")
  }
}

object ParallelParenthesesBalancing {

  /** Returns `true` iff the parentheses in the input `chars` are balanced.
   */
  def balance(chars: Array[Char]): Boolean = {
    var lefts = 0
    var idx = 0
    while (idx < chars.length) {
      if (lefts < 0) return false

      if (chars(idx) == '(') lefts += 1
      else if (chars(idx) == ')') lefts -= 1

      idx += 1
    }
    lefts == 0
//    def helper(chars: List[Char], lefts: Int): Boolean = chars match {
//      case _ if lefts < 0 => false
//      case Nil if lefts == 0 => true
//      case Nil => false
//      case (x :: xs) =>
//        if (x == '(') helper(xs, lefts + 1)
//        else if (x == ')') helper(xs, lefts - 1)
//        else helper(xs, lefts)
//    }
//
//    helper(chars, 0)
  }

  /** Returns `true` iff the parentheses in the input `chars` are balanced.
   */
  def parBalance(chars: Array[Char], threshold: Int): Boolean = {

    def traverse(idx: Int, until: Int, lefts: Int, orphans: Int): (Int, Int) = {
      if (idx == until) {
        (lefts, orphans)
      } else {
        if (chars(idx) == '(') {
          traverse(idx + 1, until, lefts + 1, orphans)
        } else if (chars(idx) == ')') {
          if (lefts <= 0) {
            traverse(idx + 1, until, lefts, orphans + 1)
          } else {
            traverse(idx + 1, until, lefts - 1, orphans)
          }
        } else {
          traverse(idx + 1, until , lefts, orphans)
        }
      }
    }

    def reduce(from: Int, until: Int): (Int, Int) = {
      if (from > until) throw new IllegalArgumentException

      if (until - from <= threshold) {
        traverse(from, until, 0, 0)
      } else {
        val mid = from + (until - from) / 2
        val ((lefts1, orphans1), (lefts2, orphans2)) = parallel(reduce(from, mid),
                                                                reduce(mid, until))
        if (lefts1 >= orphans2) {
          (lefts1 - orphans2 + lefts2, orphans1)
        } else {
          (lefts2, orphans1 + orphans2 - lefts1)
        }
      }
    }

    val (lefts, orphans) = reduce(0, chars.length)
    orphans == 0 && lefts == 0
  }

  // For those who want more:
  // Prove that your reduction operator is associative!

}
