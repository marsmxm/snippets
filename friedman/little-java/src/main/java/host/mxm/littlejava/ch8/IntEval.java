package host.mxm.littlejava.ch8;

/**
 *
 * @author Mu Xian Ming (Sam)
 */
public class IntEval extends EvalD<Integer> {
    @Override
    public Integer plus(Integer l, Integer r) {
        return l + r;
    }

    @Override
    public Integer diff(Integer l, Integer r) {
        return l - r;
    }

    @Override
    public Integer prod(Integer l, Integer r) {
        return l * r;
    }

    public static void main(String[] args) {
        int value =
                new Plus<>(
                        new Const<>(7),
                        new Prod<>(
                                new Diff<>(
                                        new Const<>(4),
                                        new Const<>(2)),
                                new Const<>(5)))
                        .accept(new IntEval());

        System.out.println(value);
    }
}
