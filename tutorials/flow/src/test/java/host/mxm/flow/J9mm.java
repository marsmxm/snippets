package host.mxm.flow;

import java.lang.invoke.MethodHandles;
import java.lang.invoke.VarHandle;
import java.math.BigInteger;
import java.util.Arrays;
import java.util.Objects;
import java.util.concurrent.CountDownLatch;

import org.junit.Test;

/**
 *
 * @author Mu Xian Ming (Sam)
 */
public class J9mm {

    @Test
    public void plain() throws InterruptedException {
        Point point = new Point();
        int count = 100;
        long factor = 1000000000000000L;
        var startLatch = new CountDownLatch(1);
        var stopLatch = new CountDownLatch(count);

        for (int i = 0; i < count; i++) {
            if (i % 2 == 0) {
                int finalI = i;
                new Thread(() -> {
                    try {
                        startLatch.await();
                    } catch (InterruptedException e) {
                        e.printStackTrace();
                    }
                    if (finalI % 4 == 0) {
                        point.writePlain(
                                BigInteger.valueOf(Long.MAX_VALUE ).multiply(BigInteger.TWO),
                                BigInteger.valueOf(Long.MAX_VALUE ).multiply(BigInteger.TWO));
                    } else {
                        point.writePlain(BigInteger.ZERO, BigInteger.ZERO);
                    }
                    stopLatch.countDown();
                }).start();
            } else {
                new Thread(() -> {
                    try {
                        startLatch.await();
                    } catch (InterruptedException e) {
                        e.printStackTrace();
                    }
                    BigInteger[] axises = point.readPlain();
                    if (!Objects.equals(axises[0], axises[1])) {
                        System.out.println(Arrays.toString(axises));
                    }
                    stopLatch.countDown();
                }).start();
            }
        }

        startLatch.countDown();
        stopLatch.await();
    }
}

class Point {
    BigInteger x, y;
    private static final VarHandle X;
    private static final VarHandle Y;

    static {
        try {
            X = MethodHandles.lookup().findVarHandle(Point.class, "x", BigInteger.class);
            Y = MethodHandles.lookup().findVarHandle(Point.class, "y", BigInteger.class);
        } catch (ReflectiveOperationException e) {
            throw new Error(e);
        }
    }

    public void writePlain(BigInteger x, BigInteger y) {
        X.set(this, x);
        Y.set(this, y);
    }

    public BigInteger[] readPlain() {
        return new BigInteger[] { (BigInteger) X.get(this), (BigInteger) Y.get(this) };
    }

}