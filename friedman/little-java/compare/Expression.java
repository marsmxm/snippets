public final class Expression {
    static class BadResultException extends RuntimeException {
        private static final long serialVersionUID = -7471855055854681068L;
        BadResultException(String s) { super(s); }
    }

    interface Exp {
        Exp eval();
        boolean hasZero();
        @Override
        String toString();
    }

    static class Int implements Exp {
        final int value;
        Int(int value) { this.value = value; }

        @Override
        public Exp eval() {
            return this;
        }
        @Override
        public boolean hasZero() {
            return value == 0;
        }
        @Override
        public String toString() {
            return String.valueOf(value);
        }
    }

    static class Negate implements Exp {
        final Exp exp;
        Negate(Int exp) { this.exp = exp; }

        @Override
        public Exp eval() {
            Int intExp = (Int) exp.eval();
            try {
                return new Int(-intExp.value);
            } catch (ClassCastException cce) {
                throw new BadResultException("non-int in negation");
            }
        }
        @Override
        public boolean hasZero() {
            return exp.hasZero();
        }
        @Override
        public String toString() {
            return "-(" + exp.toString() + ")";
        }
    }

    static class Add implements Exp {
        final Exp e1;
        final Exp e2;
        Add(Exp e1, Exp e2) { this.e1 = e1; this.e2 = e2; }

        @Override
        public Exp eval() {
            try {
                Int i1 = (Int) e1.eval();
                Int i2 = (Int) e2.eval();
                return new Int(i1.value + i2.value);
            } catch (ClassCastException e) {
                throw new BadResultException("non-ints in addition");
            }
        }
        @Override
        public boolean hasZero() {
            return e1.hasZero() || e2.hasZero();
        }
        @Override
        public String toString() {
            return "(" + e1.toString() + ") + (" + e2.toString() + ")";
        }
    }

    static class Mult implements Exp {
        final Exp e1;
        final Exp e2;
        Mult(Exp e1, Exp e2) { this.e1 = e1; this.e2 = e2; }

        @Override
        public Exp eval() {
            try {
                Int i1 = (Int) e1.eval();
                Int i2 = (Int) e2.eval();
                return new Int(i1.value * i2.value);
            } catch (ClassCastException e) {
                throw new BadResultException("non-ints in addition");
            }
        }
        @Override
        public boolean hasZero() {
            return e1.hasZero() || e2.hasZero();
        }
        @Override
        public String toString() {
            return "(" + e1.toString() + ") * (" + e2.toString() + ")";
        }
    }

    public static void main(String[] args) {
        System.out.println(new Add(new Negate(new Int(5)), new Int(6)).eval());
    }
}