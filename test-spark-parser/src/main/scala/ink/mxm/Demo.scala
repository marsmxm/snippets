package ink.mxm

import org.apache.spark.sql.SparkSession
import org.apache.spark.sql.catalyst.QueryPlanningTracker
import org.apache.spark.sql.catalyst.expressions.{Alias, AttributeReference, BinaryExpression, Expression}
import org.apache.spark.sql.catalyst.plans.logical._
import org.apache.spark.sql.execution.command.DataWritingCommand

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

  def extract0(plan: LogicalPlan): Set[String] = {
    plan match {
      case Project(projectList, child) =>
        extractChild(child, extractExpressions(projectList, Set.empty))

      case Aggregate(groupingExprs, aggregateExprs, child) =>
        extractChild(child, extractExpressions(groupingExprs ++ aggregateExprs, Set.empty))

      case _: DataWritingCommand =>
        println("insert is not allowed")
        Set.empty

      case otherPlan =>
        println(s"unknown top level plan: $otherPlan")
        Set.empty
    }
  }

  @tailrec
  def extractChild(child: LogicalPlan, columns: Set[String]): Set[String] = {
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

  def extractExpressions(exprs: Seq[Expression], columns: Set[String]): Set[String] = {
    exprs.foldLeft(columns)((cols, expr) => extractExpression(expr, cols))
  }

  def extractExpression(expr: Expression, columns: Set[String]): Set[String] = {
    expr match {
      case b @ BinaryExpression(left, right) =>
        println(s"Binary Expr: $b")
        val cols = extractExpression(left, columns)
        extractExpression(right, cols)

      case attr: AttributeReference =>
        println(s"Attribute Ref: $attr")
        columns + attr.name

      case a @ Alias(_, name) =>
        println(s"Alias: $a")
        columns + name

      case o =>
        println(s"Other Expr: $o")
        columns
    }
  }
}
