package host.mxm.littlejava.ch8;

/**
 *
 * @author Mu Xian Ming (Sam)
 */
public class Plus<T> implements ExprD<T> {
    final ExprD<T> l;
    final ExprD<T> r;

    public Plus(ExprD<T> l, ExprD<T> r) {
        this.l = l;
        this.r = r;
    }

    @Override
    public T accept(ExprVisitorI<T> ask) {
        return ask.forPlus(l, r);
    }
}
