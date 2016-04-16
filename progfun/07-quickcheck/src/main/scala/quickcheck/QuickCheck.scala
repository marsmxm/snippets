package quickcheck

import common._

import org.scalacheck._
import Arbitrary._
import Gen._
import Prop._

abstract class QuickCheckHeap extends Properties("Heap") with IntHeap {

  property("min1") = forAll { a: Int =>
    val h = insert(a, empty)
    findMin(h) == a
  }

  property("gen1") = forAll { (h: H) =>
    val m = if (isEmpty(h)) 0 else findMin(h)
    findMin(insert(m, h)) == m
  }

  property("min of two1") = forAll { (e1: Int, e2: Int) =>
    findMin(insert(e2, insert(e1, empty))) == Math.min(e1, e2)
  }

  property("min of two2") = forAll { (e1: Int, e2: Int) =>
    val heap = insert(e2, insert(e1, empty))
    findMin(heap) == Math.min(e1, e2) &&
        findMin(deleteMin(heap)) == Math.max(e1, e2)
  }

  property("delete min1") = forAll { e: Int =>
    isEmpty(deleteMin(insert(e, empty)))
  }

  property("delete min2") = forAll { e: Int =>
    val newE = e / 2
    val heap = insert(newE + 2, insert(newE + 1, insert(newE, empty)))
    findMin(deleteMin(deleteMin(heap))) == newE + 2
  }

  property("delete continually") = forAll { h: H =>
    def helper(curHeap: H, last: A): Boolean =
      if (isEmpty(curHeap)) true
      else {
        val min = findMin(curHeap)
        if (last > min) false else helper(deleteMin(curHeap), min)
      }
    helper(h, Integer.MIN_VALUE)
  }

  property("meld") = forAll { (h1: H, h2: H) =>
    findMin(meld(h1, h2)) == Math.min(findMin(h1), findMin(h2))
  }

  lazy val genHeap: Gen[H] = for {
    e <- arbitrary[Int]
    h <- oneOf(const(empty), genHeap)
  } yield insert(e, h)

  implicit lazy val arbHeap: Arbitrary[H] = Arbitrary(genHeap)

}
