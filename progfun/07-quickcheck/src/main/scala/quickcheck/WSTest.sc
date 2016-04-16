import org.scalacheck.Arbitrary._
import org.scalacheck.Gen
import org.scalacheck.Gen._


object WSTest {
  lazy val genMap: Gen[Map[Int,Int]] = for {
    k <- arbitrary[Int]
    v <- arbitrary[Int]
    m <- oneOf(const(Map.empty[Int,Int]), genMap)
  } yield m.updated(k, v)

  genMap.sample

}

