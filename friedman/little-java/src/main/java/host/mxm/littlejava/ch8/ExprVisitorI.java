package host.mxm.littlejava.ch8;

/**
 *
 * @author Mu Xian Ming (Sam)
 */
public interface ExprVisitorI<T> {
    T forPlus(ExprD<T> l, ExprD<T> r);
    T forDiff(ExprD<T> l, ExprD<T> r);
    T forProd(ExprD<T> l, ExprD<T> r);
    T forConst(T c);
}
