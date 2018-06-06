package host.mxm.littlejava.ch8;

/**
 *
 * @author Mu Xian Ming (Sam)
 */
public interface ExprD<T> {
    T accept(ExprVisitorI<T> ask);
}
