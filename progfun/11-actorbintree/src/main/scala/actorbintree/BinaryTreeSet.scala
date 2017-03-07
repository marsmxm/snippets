/**
 * Copyright (C) 2009-2013 Typesafe Inc. <http://www.typesafe.com>
 */
package actorbintree

import akka.actor._

import scala.collection.immutable.Queue

object BinaryTreeSet {

  trait Operation {
    def requester: ActorRef
    def id: Int
    def elem: Int
  }

  trait OperationReply {
    def id: Int
  }

  /** Request with identifier `id` to insert an element `elem` into the tree.
    * The actor at reference `requester` should be notified when this operation
    * is completed.
    */
  case class Insert(requester: ActorRef, id: Int, elem: Int) extends Operation

  /** Request with identifier `id` to check whether an element `elem` is present
    * in the tree. The actor at reference `requester` should be notified when
    * this operation is completed.
    */
  case class Contains(requester: ActorRef, id: Int, elem: Int) extends Operation

  /** Request with identifier `id` to remove the element `elem` from the tree.
    * The actor at reference `requester` should be notified when this operation
    * is completed.
    */
  case class Remove(requester: ActorRef, id: Int, elem: Int) extends Operation

  /** Request to perform garbage collection*/
  case object GC

  /** Holds the answer to the Contains request with identifier `id`.
    * `result` is true if and only if the element is present in the tree.
    */
  case class ContainsResult(id: Int, result: Boolean) extends OperationReply
  
  /** Message to signal successful completion of an insert or remove operation. */
  case class OperationFinished(id: Int) extends OperationReply

}


class BinaryTreeSet extends Actor {
  import BinaryTreeNode._
  import BinaryTreeSet._

  def createRoot: ActorRef = context.actorOf(props(0, initiallyRemoved = true))

  var root = createRoot

  // optional
  var pendingQueue = Queue.empty[Operation]

  // collections for ordering issue
  var currentAlterations = Vector.empty[Operation]
  var pendingQueries = Vector.empty[Contains]

  private def tryQuery(query: Contains) =
    if (currentAlterations.exists(_.elem == query.elem)) {
      if (!pendingQueries.exists(_.id == query.id)) {
        pendingQueries :+= query
        println("currentAlterations" + currentAlterations)
        println("pendingQueries" + pendingQueries)
      }
    }
    else {
      root ! query
      pendingQueries = pendingQueries.dropWhile(_.id == query.id)
    }

  private def tryQueries() = pendingQueries.foreach(tryQuery)

  // optional
  def receive = normal

  // optional
  /** Accepts `Operation` and `GC` messages. */
  val normal: Receive = {
    case Insert(requester, id, elem) =>
      root ! Insert(self, id, elem)
      currentAlterations :+= Insert(requester, id, elem)
    case Remove(requester, id, elem) =>
      root ! Remove(self, id, elem)
      currentAlterations :+= Remove(requester, id, elem)
    case query: Contains => tryQuery(query)
    case OperationFinished(id) =>
      val index = currentAlterations.indexWhere(_.id == id)
      currentAlterations(index).requester ! OperationFinished(id)
      // remove ith element
      currentAlterations = (currentAlterations take index) ++ (currentAlterations drop (index + 1))
      tryQueries()
    case GC =>
      pendingQueries.foreach(pendingQueue.enqueue(_))
      val newRoot = createRoot
      root ! CopyTo(newRoot)
      context.become(garbageCollecting(newRoot))
  }

  // optional
  /** Handles messages while garbage collection is performed.
    * `newRoot` is the root of the new binary tree where we want to copy
    * all non-removed elements into.
    */
  def garbageCollecting(newRoot: ActorRef): Receive = {
    case CopyFinished =>
      sender ! PoisonPill
      root = newRoot
      pendingQueue.foreach(root ! _)
      context.become(normal)
    case opt: Operation =>
      pendingQueue = pendingQueue.enqueue(opt)
    case OperationFinished(id) =>
      val index = currentAlterations.indexWhere(_.id == id)
      currentAlterations(index).requester ! OperationFinished(id)
      // remove ith element
      currentAlterations = (currentAlterations take index) ++ (currentAlterations drop (index + 1))
  }

}

object BinaryTreeNode {
  trait Position

  case object Left extends Position
  case object Right extends Position

  case class CopyTo(treeNode: ActorRef)
  case object CopyFinished

  def props(elem: Int, initiallyRemoved: Boolean) = Props(classOf[BinaryTreeNode],  elem, initiallyRemoved)
}

class BinaryTreeNode(val elem: Int, initiallyRemoved: Boolean) extends Actor {
  import BinaryTreeNode._
  import BinaryTreeSet._

  var subtrees = Map[Position, ActorRef]()
  var removed = initiallyRemoved

  // optional
  def receive = normal

  def passMsg(opt: Operation)(block: => Unit) =
    if (this.elem > elem && subtrees.contains(Left)) subtrees.get(Left).get ! opt
    else if (this.elem < elem && subtrees.contains(Left)) subtrees.get(Right).get ! opt
    else block

  // optional
  /** Handles `Operation` messages and `CopyTo` requests. */
  val normal: Receive = {
    case Insert(requester, id, theElem) =>
      if (this.elem == theElem) {
        removed = false
        requester ! OperationFinished(id)
      }
      else passMsg(Insert(requester, id, theElem)) {
        if (theElem < this.elem) subtrees += (Left -> context.actorOf(props(theElem, initiallyRemoved = false)))
        else subtrees += (Right -> context.actorOf(props(theElem, initiallyRemoved = false)))

        requester ! OperationFinished(id)
      }
    case Contains(requester, id, theElem) =>
      if (this.elem == theElem && !removed) requester ! ContainsResult(id, result = true)
      else if (this.elem > theElem && subtrees.contains(Left)) subtrees.get(Left).get ! Contains(requester, id, theElem)
      else if (this.elem < theElem && subtrees.contains(Right)) subtrees.get(Right).get ! Contains(requester, id, theElem)
      else requester ! ContainsResult(id, result = false)
    case Remove(requester, id, theElem) =>
      if (this.elem == theElem) {
        removed = true
        requester ! OperationFinished(id)
      }
      else passMsg(Remove(requester, id, theElem)) {
        requester ! OperationFinished(id)
      }
    case CopyTo(treeNode) =>
      if (!removed) treeNode ! Insert(self, 0, elem)
      var expected = Set.empty[ActorRef]
      if (subtrees.contains(Left)) {
        val left = subtrees.get(Left).get
        expected += left
        left ! CopyTo(treeNode)
      }
      if (subtrees.contains(Right)) {
        val right = subtrees.get(Right).get
        expected += right
        right ! CopyTo(treeNode)
      }
      println("expected in CopyTo" + expected)
      context.become(copying(expected, insertConfirmed = removed))
  }

  // optional
  /** `expected` is the set of ActorRefs whose replies we are waiting for,
    * `insertConfirmed` tracks whether the copy of this node to the new tree has been confirmed.
    */
  def copying(expected: Set[ActorRef], insertConfirmed: Boolean): Receive = {
    if (expected.isEmpty && insertConfirmed) {
      context.parent ! CopyFinished
      normal
    } else {
      case OperationFinished(id) => copying(expected, insertConfirmed = true)
      case CopyFinished =>
        sender ! PoisonPill
        copying(expected - sender, insertConfirmed)
    }
  }
}
