package host.mxm.littlejava.ch8.set;

import host.mxm.littlejava.ch8.Const;
import host.mxm.littlejava.ch8.EvalD;
import host.mxm.littlejava.ch8.Plus;
import host.mxm.littlejava.ch8.Prod;

/**
 *
 * @author Mu Xian Ming (Sam)
 */
public class SetEval extends EvalD<SetD> {
    @Override
    public SetD plus(SetD l, SetD r) {
        return l.plus(r);
    }

    @Override
    public SetD diff(SetD l, SetD r) {
        return l.diff(r);
    }

    @Override
    public SetD prod(SetD l, SetD r) {
        return l.prod(r);
    }

    public static void main(String[] args) {
        SetD s = new Plus<>(new Prod<>(new Const<>(new Empty().add(7)),
                                       new Const<>(new Empty().add(3))),
                            new Const<>(new Empty().add(42)))
                .accept(new SetEval());

        System.out.println(s);
    }
}
