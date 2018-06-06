package host.mxm.littlejava.ch8;

/**
 *
 * @author Mu Xian Ming (Sam)
 */
public abstract class EvalD<T> implements ExprVisitorI<T> {
    @Override
    public T forPlus(ExprD<T> l, ExprD<T> r) {
        return plus(l.accept(this), r.accept(this));
    }

    @Override
    public T forDiff(ExprD<T> l, ExprD<T> r) {
        return diff(l.accept(this), r.accept(this));
    }

    @Override
    public T forProd(ExprD<T> l, ExprD<T> r) {
        return prod(l.accept(this), r.accept(this));
    }

    @Override
    public T forConst(T c) {
        return c;
    }

    public abstract T plus(T l, T r);
    public abstract T diff(T l, T r);
    public abstract T prod(T l, T r);
}
