package ink.mxm

import org.scalatest.funsuite.AnyFunSuite

class DemoTest extends AnyFunSuite {

  test("food order - project") {
    val sql = "SELECT appplatform FROM food_orders where base_price > 0"
    Demo.analyze(sql)
  }

  test("food order - aggregate") {
    val sql = "SELECT appplatform, sum(base_price) as platform_price FROM food_orders where base_price > 0 group by appplatform"
    Demo.analyze(sql)
  }

  test("aggregate") {
    val sql =
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
    Demo.parse(sql)
  }

  test("with") {
    val sql =
      """
        |with base_rtt_tbl as (
        |        select
        |            from_place_id,
        |            datediff('2022-04-01', date_format(from_utc_timestamp(to_utc_timestamp(from_unixtime(unix_timestamp(driver_times_completed)), from_unixtime(unix_timestamp(), "z")), "GMT+7"),'yyyy-MM-dd')) date_interval,
        |            computed_rms_cooking_time_second,
        |            driver_times_completed,
        |            sum_item_price,
        |            distance,
        |            created_at
        |        FROM
        |           lineman_beta.lmwh_food_orders_daily
        |        where
        |            isNotNull(driver_times_delivering)
        |            and isNotNull(driver_times_completed)
        |            and (delivery_status = 'COMPLETED')
        |            and (status = 'COMPLETED')
        |            and (delivery_supplier = 'lineman_driver')
        |            and floor((cast(driver_times_completed as double) - cast(created_at as double))) > (5 * 60)
        |            and floor((cast(driver_times_completed as double) - cast(created_at as double))) < ((2 * 60) * 60)
        |            and (distance >= 200)
        |            and ((distance / floor((cast(driver_times_completed as double) - cast(driver_times_delivering as double)))) < 20)
        |            and ((distance / floor((cast(driver_times_completed as double) - cast(driver_times_delivering as double)))) > 2)
        |            and (computed_rms_cooking_time_second > (2 * 60))
        |            and (computed_rms_cooking_time_second < (40 * 60))
        |            and date_format(from_utc_timestamp(to_utc_timestamp(from_unixtime(unix_timestamp(driver_times_completed)), from_unixtime(unix_timestamp(), "z")), "GMT+7"),'yyyy-MM-dd') <= '2022-04-01'
        |            and date_format(from_utc_timestamp(to_utc_timestamp(from_unixtime(unix_timestamp(driver_times_completed)), from_unixtime(unix_timestamp(), "z")), "GMT+7"),'yyyy-MM-dd') > date_sub('2022-04-01',7)
        |            and dt <= date_format('2022-04-01','yyyyMMdd')
        |            and dt > date_format(date_sub('2022-04-01',8),'yyyyMMdd')
        |            and from_place_id not like 'FS%'
        |    ),
        |    raw_rtt_tbl as (
        |        select from_place_id,
        |            group_type,
        |            computed_rms_cooking_time_second,
        |            driver_times_completed,
        |            sum_item_price,
        |            distance,
        |            created_at
        |        from (
        |          select from_place_id,
        |                computed_rms_cooking_time_second,
        |                driver_times_completed,
        |                sum_item_price,
        |                distance,
        |                created_at,
        |                 CASE
        |                     WHEN (date_interval=0) THEN '1,7'
        |                     WHEN (date_interval>0 and date_interval<=6) THEN '7'
        |                     ELSE null
        |                     END AS intervals
        |          from base_rtt_tbl
        |        ) LATERAL VIEW explode(split(intervals, ',')) alias as group_type
        |    ),
        |    full_feature as (
        |      select
        |      * from
        |      (
        |        select cast(substr(from_place_id, 1, length(from_place_id)-2) as bigint) id,
        |                group_type,
        |                avg(floor(cast(driver_times_completed as double) - cast(created_at as double))) uwt,
        |                avg(sum_item_price) sip,
        |                avg(computed_rms_cooking_time_second) ckt
        |            from raw_rtt_tbl
        |            where group_type in ('1','7')
        |            group by from_place_id, group_type
        |      ) PIVOT (
        |            max(cast(floor(sip * 1000000) / 1000000 as double)) avg_sum_item_price,
        |            max(cast(floor(ckt * 1000000) / 1000000 as double)) avg_cooking_time,
        |            max(cast(floor(uwt * 1000000) / 1000000 as double)) avg_uwt
        |            FOR group_type IN ('1' AS rtt_last_1_day, '7' AS rtt_last_7_day)
        |      )
        |    ),
        |    intermediate_result as (
        |        select
        |            id,
        |            rtt_last_1_day_avg_uwt,
        |            rtt_last_7_day_avg_cooking_time,
        |            rtt_last_7_day_avg_sum_item_price,
        |            rtt_last_7_day_avg_uwt
        |        from
        |            full_feature
        |    )
        |
        |    SELECT *, '20220401' as dt FROM intermediate_result
        |""".stripMargin
    Demo.parse(sql)
  }
}
