package host.mxm.littlejava.ch8.set;

/**
 *
 * @author Mu Xian Ming (Sam)
 */
public class Empty extends SetD {
    @Override
    boolean mem(Integer i) {
        return false;
    }

    @Override
    SetD plus(SetD s) {
        return s;
    }

    @Override
    SetD diff(SetD s) {
        return new Empty();
    }

    @Override
    SetD prod(SetD s) {
        return new Empty();
    }

    @Override
    public String toString() {
        return "Ø";
    }
}
