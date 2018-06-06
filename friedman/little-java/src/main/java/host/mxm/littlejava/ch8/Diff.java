package host.mxm.littlejava.ch8;

/**
 *
 * @author Mu Xian Ming (Sam)
 */
public class Diff<T> implements ExprD<T> {
    final ExprD<T> l;
    final ExprD<T> r;

    public Diff(ExprD<T> l, ExprD<T> r) {
        this.l = l;
        this.r = r;
    }

    @Override
    public T accept(ExprVisitorI<T> ask) {
        return ask.forDiff(l, r);
    }
}
