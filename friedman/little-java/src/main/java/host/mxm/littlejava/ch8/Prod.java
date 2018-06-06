package host.mxm.littlejava.ch8;

/**
 *
 * @author Mu Xian Ming (Sam)
 */
public class Prod<T> implements ExprD<T> {
    final ExprD<T> l;
    final ExprD<T> r;

    public Prod(ExprD<T> l, ExprD<T> r) {
        this.l = l;
        this.r = r;
    }

    @Override
    public T accept(ExprVisitorI<T> ask) {
        return ask.forProd(l, r);
    }
}
