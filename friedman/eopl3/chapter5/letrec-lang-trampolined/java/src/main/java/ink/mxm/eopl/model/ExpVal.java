package ink.mxm.eopl.model;

import lombok.EqualsAndHashCode;
import lombok.Value;

/**
 *
 * @author Mu Xian Ming (Sam)
 */
public interface ExpVal extends Bounce {

    default int toNum() {
        return ((NumVal) this).num;
    }

    default boolean toBool() {
        return ((BoolVal) this).bool;
    }

    default Proc toProc() {
        return ((ProcVal) this).proc;
    }

    @Value
    class NumVal implements ExpVal {
        private int num;
    }

    @Value
    class BoolVal implements ExpVal {
        private boolean bool;
    }

    @Value
    class ProcVal implements ExpVal {
        private Proc proc;
    }
}
