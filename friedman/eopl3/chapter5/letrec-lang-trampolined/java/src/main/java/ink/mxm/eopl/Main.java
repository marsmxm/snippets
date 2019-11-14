package ink.mxm.eopl;

import static ink.mxm.eopl.Interpreter.valueOfExpression;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertTrue;

import ink.mxm.eopl.model.ExpVal.NumVal;
import ink.mxm.eopl.model.Expression;
import ink.mxm.eopl.model.Expression.CallExp;
import ink.mxm.eopl.model.Expression.ConstExp;
import ink.mxm.eopl.model.Expression.DiffExp;
import ink.mxm.eopl.model.Expression.IfExp;
import ink.mxm.eopl.model.Expression.IsZeroExp;
import ink.mxm.eopl.model.Expression.LetExp;
import ink.mxm.eopl.model.Expression.ProcExp;
import ink.mxm.eopl.model.Expression.VarExp;

public final class Main {

    public static void main(String[] args) {
        Expression exp;

        //  (simple-arith-1 "-(44,33)" 11)
        exp = new DiffExp(new ConstExp(44),
                          new ConstExp(33));
        test(exp, 11);

        // (if-true "if zero?(0) then 3 else 4" 3)
        exp = new IfExp(new IsZeroExp(new ConstExp(0)),
                        new ConstExp(3),
                        new ConstExp(4));
        test(exp, 3);

        // (test-unbound-var-1 "foo" error)
        exp = new VarExp("foo");
        testError(exp);

        // (no-bool-to-diff-1 "-(zero?(0),1)" error)
        exp = new DiffExp(new IsZeroExp(new ConstExp(0)),
                          new ConstExp(1));
        testError(exp);

        /*
         (y-combinator-1 "
let fix =  proc (f)
            let d = proc (x) proc (z) ((f (x x)) z)
            in proc (n) ((f (d d)) n)
in let
    t4m = proc (f) proc(x) if zero?(x) then 0 else -((f -(x,1)),-4)
in let times4 = (fix t4m)
   in (times4 3)" 12)
         */
        exp = new LetExp("fix", new ProcExp("f",
                                            new LetExp("d", new ProcExp("x",
                                                                        new ProcExp("z",
                                                                                    new CallExp(new CallExp(new VarExp("f"),
                                                                                                            new CallExp(new VarExp("x"),
                                                                                                                        new VarExp("x"))),
                                                                                                new VarExp("z")))),
                                                       new ProcExp("n",
                                                                   new CallExp(new CallExp(new VarExp("f"),
                                                                                           new CallExp(new VarExp("d"),
                                                                                                       new VarExp("d"))),
                                                                               new VarExp("n"))))),
                         new LetExp("t4m", new ProcExp("f",
                                                       new ProcExp("x",
                                                                   new IfExp(new IsZeroExp(new VarExp("x")),
                                                                             new ConstExp(0),
                                                                             new DiffExp(new CallExp(new VarExp("f"),
                                                                                                     new DiffExp(new VarExp("x"),
                                                                                                                 new ConstExp(1))),
                                                                                         new ConstExp(-4))))),
                                    new LetExp("times4", new CallExp(new VarExp("fix"), new VarExp("t4m")),
                                               new CallExp(new VarExp("times4"), new ConstExp(3)))));
        test(exp, 12);
    }

    private static void test(Expression exp, int expected) {
        System.out.println("Testing: " + exp);
        assertEquals(valueOfExpression(exp), new NumVal(expected));
        System.out.println();
    }

    private static void testError(Expression exp) {
        System.out.println("Testing: " + exp);
        boolean error = false;
        try {
            valueOfExpression(exp);
        } catch (RuntimeException e) {
            error = true;
            System.out.println(e.getMessage());
        }
        assertTrue(error);
        System.out.println();
    }
}
