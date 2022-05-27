package ink.mxm;

import org.apache.spark.sql.catalyst.expressions.Expression;
import org.apache.spark.sql.catalyst.expressions.GreaterThan;
import org.apache.spark.sql.catalyst.plans.logical.LogicalPlan;
import org.apache.spark.sql.execution.SparkSqlParser;

public class Main {
    public static void main(String[] args) {
        SparkSqlParser parser = new SparkSqlParser();
        LogicalPlan plan = parser.parsePlan("SELECT a FROM t");
        System.out.println(plan);
        GreaterThan gt = new GreaterThan(null, null);
        System.out.println(gt);
    }
}
