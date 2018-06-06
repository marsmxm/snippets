package host.mxm.littlejava.ch8.set;

/**
 *
 * @author Mu Xian Ming (Sam)
 */
abstract class SetD {
    SetD add(Integer i) {
        if (mem(i)) { return this; } else { return new Add(i, this); }
    }

    abstract boolean mem(Integer i);

    abstract SetD plus(SetD s);

    abstract SetD diff(SetD s);

    abstract SetD prod(SetD s);
}