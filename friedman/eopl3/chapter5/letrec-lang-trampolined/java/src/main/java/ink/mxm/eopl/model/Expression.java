package ink.mxm.eopl.model;

import lombok.Value;

/**
 *
 * @author Mu Xian Ming (Sam)
 */
public interface Expression {

    @Value
    class ConstExp implements Expression {
        int num;
    }

    @Value
    class VarExp implements Expression {
        String var;
    }

    @Value
    class DiffExp implements Expression {
        Expression exp1;
        Expression exp2;
    }

    @Value
    class IsZeroExp implements Expression {
        Expression exp1;
    }

    @Value
    class IfExp implements Expression {
        Expression exp1;
        Expression exp2;
        Expression exp3;
    }

    @Value
    class LetExp implements Expression {
        String var;
        Expression exp1;
        Expression body;
    }

    @Value
    class ProcExp implements Expression {
        String var;
        Expression body;
    }

    @Value
    class CallExp implements Expression {
        Expression exp1;
        Expression exp2;
    }

    @Value
    class LetrecExp implements Expression {
        String pname;
        String pvar;
        Expression pbody;
        Expression body;
    }
}
