package host.mxm.littlejava.ch8;

/**
 *
 * @author Mu Xian Ming (Sam)
 */
public class Const<T> implements ExprD<T> {
    final T c;

    public Const(T c) {this.c = c;}

    @Override
    public T accept(ExprVisitorI<T> ask) {
        return ask.forConst(c);
    }
}
