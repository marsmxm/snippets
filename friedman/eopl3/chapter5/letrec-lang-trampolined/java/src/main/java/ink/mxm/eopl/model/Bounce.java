package ink.mxm.eopl.model;

import lombok.Value;

/**
 *
 * @author Mu Xian Ming (Sam)
 */
public interface Bounce {

    @Value
    class Snapshot implements Bounce {
        Bounce bounce;
    }
}
