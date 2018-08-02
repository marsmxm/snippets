/**
 *
 * @author Mu Xian Ming (Sam)
 */
@SuppressWarnings("InterfaceMayBeAnnotatedFunctional")
public final class ExpressionVisitor {
    static class BadResultException extends RuntimeException {
        private static final long serialVersionUID = -7471855055854681068L;
        BadResultException(String s) { super(s); }
    }

    interface Exp {
        <T> T accept(ExpVisitor<T> ask);
    }

    interface ExpVisitor<T> {
        T forInt(int value);
        T forNegate(Exp exp);
        T forAdd(Exp e1, Exp e2);
    }

    static class Int implements Exp {
        final int value;
        Int(int value) { this.value = value; }

        @Override
        public <T> T accept(ExpVisitor<T> ask) {
            return ask.forInt(value);
        }
    }

    static class Negate implements Exp {
        final Exp e;
        Negate(Exp e) { this.e = e; }

        @Override
        public <T> T accept(ExpVisitor<T> ask) {
            return ask.forNegate(e);
        }
    }

    static class Add implements Exp {
        final Exp e1;
        final Exp e2;
        Add(Exp e1, Exp e2) {
            this.e1 = e1;
            this.e2 = e2;
        }

        @Override
        public <T> T accept(ExpVisitor<T> ask) {
            return ask.forAdd(e1, e2);
        }
    }

    static class EvalVisitor implements ExpVisitor<Exp> {
        @Override
        public Exp forInt(int value) {
            return new Int(value);
        }

        @Override
        public Exp forNegate(Exp exp) {
            Int intExp = (Int) exp.accept(this);
            try {
                return new Int(-intExp.value);
            } catch (ClassCastException cce) {
                throw new BadResultException("non-int in negation");
            }
        }

        @Override
        public Exp forAdd(Exp e1, Exp e2) {
            try {
                Int i1 = (Int) e1.accept(this);
                Int i2 = (Int) e2.accept(this);
                return new Int(i1.value + i2.value);
            } catch (ClassCastException e) {
                throw new BadResultException("non-ints in addition");
            }
        }
    }

    static class HasZeroVisitor implements ExpVisitor<Boolean> {
        @Override
        public Boolean forInt(int value) {
            return value == 0;
        }

        @Override
        public Boolean forNegate(Exp e) {
            return e.accept(this);
        }

        @Override
        public Boolean forAdd(Exp e1, Exp e2) {
            return e1.accept(this) || e2.accept(this);
        }
    }

    static class ToStringVisitor implements ExpVisitor<String> {
        @Override
        public String forInt(int value) {
            return String.valueOf(value);
        }

        @Override
        public String forNegate(Exp e) {
            return "-(" + e.accept(this) + ")";
        }

        @Override
        public String forAdd(Exp e1, Exp e2) {
            return "(" + e1.accept(this) + ") + (" + e2.accept(this) + ")";
        }
    }

    static class NoNegConstantsVisitor implements ExpVisitor<Exp> {

        @Override
        public Exp forInt(int value) {
            if (value < 0) {
                return new Negate(new Int(-value));
            } else {
                return new Int(value);
            }
        }

        @Override
        public Exp forNegate(Exp e) {
            return new Negate(e.accept(this));
        }

        @Override
        public Exp forAdd(Exp e1, Exp e2) {
            return new Add(e1.accept(this), e2.accept(this));
        }
    }

    public static void main(String[] args) {
        System.out.println(new Add(new Negate(new Int(5)), new Int(6))
                                   .accept(new EvalVisitor())
                                   .accept(new ToStringVisitor()));
    }
}
