package ink.mxm

import org.apache.spark.sql.catalyst.expressions.{Expression, NamedExpression}
import org.apache.spark.sql.catalyst.plans.logical.{Aggregate, LogicalPlan, Project}
import org.apache.spark.sql.execution.SparkSqlParser

object Demo {
  def parse(sql: String): Unit = {
    val parser = new SparkSqlParser
    val plan = parser.parsePlan(sql)
    plan match {
      case Project(projectList, child) =>
        println("Project contains:")
        println("projectList: " + projectList)
        println("child: " + child)
      case Aggregate(groupingExps, aggregateExps, child) =>
        println("Aggregate contains:")
        println("groupingExps: " + groupingExps)
        println("aggregateExps: " + aggregateExps)
        println("child: " + child)
      case _ =>
        println("illegal")
    }
  }

  def main(args: Array[String]): Unit = {
    val parser = new SparkSqlParser
    val sqlSimple =
      """
        |SELECT
        |    transactions_accepted_driver_driver_id id,
        |    cast(floor(sum(distance) / sum(floor(cast(driver_times_completed as double) - cast(driver_times_delivering as double))) * 1000000) / 1000000 as double) rider_overall_speed,
        |    '20220401' as dt
        |FROM lineman_beta.lmwh_food_orders_daily
        |where dt <= replace('2022-04-01', '-', '')
        |    and dt > replace(date_sub('2022-04-01', 8), '-', '')
        |    and date_format(from_utc_timestamp(to_utc_timestamp(from_unixtime(unix_timestamp(driver_times_completed)), from_unixtime(unix_timestamp(), "z")), "GMT+7"),'yyyy-MM-dd') <= '2022-04-01'
        |    and date_format(from_utc_timestamp(to_utc_timestamp(from_unixtime(unix_timestamp(driver_times_completed)), from_unixtime(unix_timestamp(), "z")), "GMT+7"),'yyyy-MM-dd') > date_sub('2022-04-01',7)
        |    and isNotNull(driver_times_delivering)
        |    and isNotNull(driver_times_completed)
        |    and (delivery_status = 'COMPLETED')
        |    and (status = 'COMPLETED')
        |    and (delivery_supplier = 'lineman_driver')
        |    and floor((cast(driver_times_completed as double) - cast(created_at as double))) > (5 * 60)
        |    and floor((cast(driver_times_completed as double) - cast(created_at as double))) < ((2 * 60) * 60)
        |    and (distance >= 200)
        |    and ((distance / floor((cast(driver_times_completed as double) - cast(driver_times_delivering as double)))) < 20)
        |    and ((distance / floor((cast(driver_times_completed as double) - cast(driver_times_delivering as double)))) > 2)
        |    and (computed_rms_cooking_time_second > (2 * 60))
        |    and (computed_rms_cooking_time_second < (40 * 60))
        |    group by transactions_accepted_driver_driver_id
        |""".stripMargin
    val plan = parser.parsePlan(sqlSimple)
    plan match {
      case Project(projectList, child) =>
        println(projectList)
        println(child)
      case _ =>
        println("illegal")
    }
  }
}
