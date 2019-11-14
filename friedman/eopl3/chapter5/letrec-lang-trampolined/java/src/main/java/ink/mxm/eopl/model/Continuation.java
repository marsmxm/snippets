package ink.mxm.eopl.model;

import lombok.Value;

/**
 *
 * @author Mu Xian Ming (Sam)
 */
public interface Continuation {

    @Value
    class EndCont implements Continuation {}

    @Value
    class Zero1Cont implements Continuation {
        Continuation savedCont;
    }

    @Value
    class LetExpCont implements Continuation {
        String var;
        Expression body;
        Environment savedEnv;
        Continuation savedCont;
    }

    @Value
    class IfTestCont implements Continuation {
        Expression exp2;
        Expression exp3;
        Environment savedEnv;
        Continuation savedCont;
    }

    @Value
    class Diff1Cont implements Continuation {
        Expression exp2;
        Environment savedEnv;
        Continuation savedCont;
    }

    @Value
    class Diff2Cont implements Continuation {
        ExpVal val1;
        Continuation savedCont;
    }

    @Value
    class RatorCont implements Continuation {
        Expression rand;
        Environment savedEnv;
        Continuation savedCont;
    }

    @Value
    class RandCont implements Continuation {
        ExpVal val1;
        Continuation savedCont;
    }
}
