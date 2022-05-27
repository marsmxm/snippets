package ink.mxm

import org.apache.spark.sql.SparkSession
import org.apache.spark.sql.catalyst.QueryPlanningTracker
import org.apache.spark.sql.catalyst.expressions.{AttributeReference, BinaryExpression, Expression}
import org.apache.spark.sql.catalyst.plans.logical._

import scala.annotation.tailrec

object Demo {
  lazy val spark: SparkSession = {
    SparkSession
      .builder()
      .master("local")
      .appName("spark test")
      .getOrCreate()
  }

  spark.read.json("src/main/resources/people.json").createOrReplaceTempView("people")
  spark.read.parquet("src/main/resources/food_order.parquet").createOrReplaceTempView("food_orders")

  def main(args: Array[String]): Unit = {
  }

  def analyze(sql: String): Unit = {
    val plan = spark.sessionState.sqlParser.parsePlan(sql)
    val analyzedPlan = spark.sessionState.analyzer.executeAndCheck(plan, new QueryPlanningTracker)
    println(analyzedPlan)
    println(s"columns: ${extract0(analyzedPlan)}")
  }

  def extract0(plan: LogicalPlan): List[String] = {
    plan match {
      case Project(projectList, child) =>
        extractChild(child, extractExpressions(projectList, Nil))

      case Aggregate(groupingExprs, aggregateExprs, child) =>
        println(groupingExprs)
        println(aggregateExprs)
        println(child)
        Nil

      case otherPlan =>
        println(s"unknown top level plan: $otherPlan")
        Nil
    }
  }

  @tailrec
  def extractChild(child: LogicalPlan, columns: List[String]): List[String] = {
    child match {
      case s @ SubqueryAlias(_, child) =>
        println(s"SubQuery: $s")
        extractChild(child, columns)

      case f @ Filter(condition, child) =>
        println(s"Filter: $f")
        val cols = extractExpression(condition, columns)
        extractChild(child, cols)

      case p @ Project(projectList, child) =>
        println(s"Project: $p")
        extractChild(child, columns ++ projectList.map(p => p.name))

      case otherCase =>
        println(s"Other child: $otherCase")
        columns
    }
  }

  def extractExpressions(exprs: Seq[Expression], columns: List[String]): List[String] = {
    exprs.foldLeft(columns)((cols, expr) => extractExpression(expr, cols))
  }

  def extractExpression(expr: Expression, columns: List[String]): List[String] = {
    expr match {
      case BinaryExpression(left, right) =>
        val cols = extractExpression(left, columns)
        extractExpression(right, cols)

      case a: AttributeReference =>
        a.name :: columns

      case _ =>
        columns
    }
  }

  def parse(sql: String): Unit = {
    val parser = spark.sessionState.sqlParser
    val plan = parser.parsePlan(sql)

    plan match {
      case Project(projectList, child) =>
        println("Project contains:---")
        println("projectList: " + projectList)
        println("child: " + child)
      case Aggregate(groupingExps, aggregateExps, child) =>
        println("Aggregate contains:---")
        println("groupingExps: " + groupingExps)
        println("aggregateExps: " + aggregateExps)
        println("child: " + child)
      case UnresolvedWith(child, cteRelations) =>
        println("UnresolvedWith contains:---")
        println("child: " + child)
        println("cteRelations: " + cteRelations)
      case _ =>
        println("unknown")
    }
  }
}
