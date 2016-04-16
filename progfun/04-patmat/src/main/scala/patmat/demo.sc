package patmat

import Huffman._

object demo {
  println("Welcome to the Scala worksheet")       //> Welcome to the Scala worksheet
  createCodeTree(List('a','b','c','b','a'))       //> res0: patmat.Huffman.CodeTree = Fork(Leaf(b,2),Fork(Leaf(c,1),Leaf(a,2),List
                                                  //| (c, a),3),List(b, c, a),5)
  decodedSecret                                   //> res1: List[Char] = List(h, u, f, f, m, a, n, e, s, t, c, o, o, l)
}