package ink.mxm

import org.scalatest.funsuite.AnyFunSuite

class DemoTest extends AnyFunSuite {
  /**
    Project [age#7L, name#8]
      +- SubqueryAlias people
         +- View (`people`, [age#7L,name#8])
            +- Relation [age#7L,name#8] json
   */
  test("people - project") {
    val sql = "SELECT name, age + 1 FROM people where age > 30"
    Demo.analyze(sql)
//    println(Demo.analyze(sql) == Demo.analyze(sql))
  }

  /**
  Project [age#7L]
    +- SubqueryAlias auto_generated_subquery_name
       +- Project [age#7L]
          +- SubqueryAlias people
             +- View (`people`, [age#7L,name#8])
                +- Relation [age#7L,name#8] json
   */
  test("people - nest") {
    val sql = "SELECT * FROM (SELECT age FROM people) where age > 0"
    Demo.analyze(sql)
  }

  test("people - insert") {
    val sql = "INSERT INTO people(name, age) VALUES ('Amy Smith', 19)"
    Demo.analyze(sql)
  }

  /**
    Project [appplatform#12]
    +- Filter (base_price#14 > cast(0 as double))
       +- SubqueryAlias food_orders
          +- View (`food_orders`, [id#11,appplatform#12,appversion#13,base_price#14,cancel_detail_reason#15,cancel_detail_reason_comment#16,cancel_detail_requestor#17,cancel_detail_source#18,cancel_detail_source_reference_id#19,cloudkitchen_id#20])
             +- Relation [id#11,appplatform#12,appversion#13,base_price#14,cancel_detail_reason#15,cancel_detail_reason_comment#16,cancel_detail_requestor#17,cancel_detail_source#18,cancel_detail_source_reference_id#19,cloudkitchen_id#20] parquet
   */
  test("food order - project") {
    val sql = "SELECT appplatform as p FROM food_orders where base_price > 0"
    Demo.analyze(sql)
  }

  test("food order - arithmetics") {
    val sql = "SELECT appplatform, base_price * 2 FROM food_orders where base_price > 0"
    Demo.analyze(sql)
  }

  /**
    Aggregate [appplatform#12], [appplatform#12, sum(base_price#14) AS platform_price#31]
    +- Filter (base_price#14 > cast(0 as double))
       +- SubqueryAlias food_orders
          +- View (`food_orders`, [id#11,appplatform#12,appversion#13,base_price#14,cancel_detail_reason#15,cancel_detail_reason_comment#16,cancel_detail_requestor#17,cancel_detail_source#18,cancel_detail_source_reference_id#19,cloudkitchen_id#20])
             +- Relation [id#11,appplatform#12,appversion#13,base_price#14,cancel_detail_reason#15,cancel_detail_reason_comment#16,cancel_detail_requestor#17,cancel_detail_source#18,cancel_detail_source_reference_id#19,cloudkitchen_id#20] parquet
   */
  test("food order - aggregate") {
    val sql = "SELECT appplatform, sum(base_price) as platform_price, avg(base_price) FROM food_orders where base_price > 0 group by appplatform"
    Demo.analyze(sql)
  }

  test("join") {
    val sql = "SELECT b.appplatform, a.age " +
      "FROM people a INNER JOIN food_orders b ON a.name = b.cancel_detail_reason "
    Demo.analyze(sql)
  }

  test("with") {
    val sql =
      """
        |with intermediate_result as (
        |      SELECT b.appplatform, a.age
        |      FROM people a INNER JOIN food_orders b ON a.name = b.cancel_detail_reason
        |    )
        |
        |    SELECT * FROM intermediate_result
        |""".stripMargin
    Demo.analyze(sql)
  }
}
