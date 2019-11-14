package ink.mxm.eopl.model;

import ink.mxm.eopl.model.ExpVal.NumVal;
import ink.mxm.eopl.model.ExpVal.ProcVal;
import ink.mxm.eopl.model.Proc.Procedure;
import lombok.Value;

/**
 *
 * @author Mu Xian Ming (Sam)
 */
public interface Environment {
    Environment INIT_ENV =
            new ExtendEnv("i", new NumVal(1),
                          new ExtendEnv("v", new NumVal(5),
                                        new ExtendEnv("x", new NumVal(10),
                                                      new EmptyEnv())));

    static ExpVal applyEnv(Environment env, String sym) {
        while (true) {
            if (env instanceof EmptyEnv) {
                throw new RuntimeException("No binding for " + sym);
            } else if (env instanceof ExtendEnv) {
                ExtendEnv extendEnv = (ExtendEnv) env;
                if (extendEnv.getVar().equals(sym)) {
                    return extendEnv.getVal();
                } else {
                    env = extendEnv.getSavedEnv();
                }
            } else {
                ExtendEnvRec envRec = (ExtendEnvRec) env;
                if (envRec.getPname().equals(sym)) {
                    return new ProcVal(new Procedure(envRec.getPvar(), envRec.getPbody(), env));
                } else {
                    env = envRec.getSavedEnv();
                }
            }
        }
    }

    @Value
    class EmptyEnv implements Environment {}

    @Value
    class ExtendEnv implements Environment {
        String var;
        ExpVal val;
        Environment savedEnv;
    }

    @Value
    class ExtendEnvRec implements Environment {
        String pname;
        String pvar;
        Expression pbody;
        Environment savedEnv;
    }
}
