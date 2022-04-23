package ink.mxm

import org.apache.spark.sql.catalyst.plans.logical.{LogicalPlan, Project}
import org.apache.spark.sql.execution.SparkSqlParser

object Demo {
  def main(args: Array[String]): Unit = {
    val parser = new SparkSqlParser
    val plan = parser.parsePlan("SELECT SUM(a+b) FROM t")
    plan match {
      case Project(projectList, child) =>
        println(projectList)
        println(child)
      case _ =>
        println("illegal")
    }
  }
}