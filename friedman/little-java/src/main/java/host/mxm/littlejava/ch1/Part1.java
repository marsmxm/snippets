package host.mxm.littlejava.ch1;

import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;

/**
 *
 * @author Mu Xian Ming (Sam)
 */
public abstract class Part1 {
    public static void main(String[] args) {
        assertTrue(new Tomato(new Onion(new Skewer())).isVegetarian());
        assertFalse(new Lamb(new Onion(new Skewer())).onlyOnions());
        assertTrue(new Onion(new Onion(new Skewer())).onlyOnions());
    }


    abstract static class ShishD {
        abstract boolean onlyOnions();
        abstract boolean isVegetarian();
    }

    static class Skewer extends ShishD {
        @Override
        boolean onlyOnions() {
            return true;
        }

        @Override
        boolean isVegetarian() {
            return true;
        }
    }

    static class Onion extends ShishD {
        final ShishD s;

        Onion(ShishD s) {this.s = s;}

        @Override
        boolean onlyOnions() {
            return s.onlyOnions();
        }

        @Override
        boolean isVegetarian() {
            return s.isVegetarian();
        }
    }

    static class Lamb extends ShishD {
        final ShishD s;

        Lamb(ShishD s) {this.s = s;}

        @Override
        boolean onlyOnions() {
            return false;
        }

        @Override
        boolean isVegetarian() {
            return false;
        }
    }

    static class Tomato extends ShishD {
        final ShishD s;

        Tomato(ShishD s) {this.s = s;}

        @Override
        boolean onlyOnions() {
            return false;
        }

        @Override
        boolean isVegetarian() {
            return s.isVegetarian();
        }
    }
}