package patmat

import Huffman._

object demo {;import org.scalaide.worksheet.runtime.library.WorksheetSupport._; def main(args: Array[String])=$execute{;$skip(91); 
  println("Welcome to the Scala worksheet");$skip(44); val res$0 = 
  createCodeTree(List('a','b','c','b','a'));System.out.println("""res0: patmat.Huffman.CodeTree = """ + $show(res$0));$skip(16); val res$1 = 
  decodedSecret;System.out.println("""res1: List[Char] = """ + $show(res$1))}
}
