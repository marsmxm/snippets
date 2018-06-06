package host.mxm.littlejava.ch8.set;

/**
 *
 * @author Mu Xian Ming (Sam)
 */
public class Add extends SetD {
    final Integer i;
    final SetD s;

    public Add(Integer i, SetD s) {
        this.i = i;
        this.s = s;
    }

    @Override
    boolean mem(Integer n) {
        return i.equals(n) || s.mem(n);
    }

    @Override
    SetD plus(SetD t) {
        return s.plus(t.add(i));
    }

    @Override
    SetD diff(SetD t) {
        return t.mem(i) ? s.diff(t) : s.diff(t).add(i);
    }

    @Override
    SetD prod(SetD t) {
        return t.mem(i) ? s.prod(t).add(i) : s.prod(t);
    }

    @Override
    public String toString() {
        return "Add(" + i + ", " + s + ')';
    }
}
