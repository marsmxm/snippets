package ink.mxm.eopl.model;

import lombok.Value;

/**
 *
 * @author Mu Xian Ming (Sam)
 */
public interface Proc {

    @Value
    class Procedure implements Proc {
        String var;
        Expression body;
        Environment env;
    }
}
