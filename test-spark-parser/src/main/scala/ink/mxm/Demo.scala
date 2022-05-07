package ink.mxm

import org.apache.spark.sql.SparkSession
import org.apache.spark.sql.catalyst.QueryPlanningTracker
import org.apache.spark.sql.catalyst.expressions.NamedExpression
import org.apache.spark.sql.catalyst.plans.logical.{Aggregate, LogicalPlan, Project, SubqueryAlias, UnresolvedWith}

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
    val parser = spark.sessionState.sqlParser
    val plan = parser.parsePlan(sql)
    val analyzedPlan = spark.sessionState.analyzer.executeAndCheck(plan, new QueryPlanningTracker)
    println(analyzedPlan)
    extract0(analyzedPlan)
  }

  def extract0(plan: LogicalPlan): Unit = {
    var columns: Seq[NamedExpression] = Nil

    plan match {
      case Project(projectList, child) =>
        columns = projectList
        child match {
          case SubqueryAlias(identifier, child) =>
            println(child)
        }
      case Aggregate(groupingExprs, aggregateExprs, child) =>
        columns = aggregateExprs
      case _ =>
        println("unknown")
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
