package host.mxm.flow;

import java.lang.invoke.MethodHandles;
import java.lang.invoke.VarHandle;
import java.util.concurrent.CountDownLatch;

import org.junit.Test;

/**
 *
 * @author Mu Xian Ming (Sam)
 */
public class J9mm {

    @Test
    public void plain() throws InterruptedException {
        Shared shared = new Shared();
        System.out.println(shared.value);
        int count = 2;
        var startLatch = new CountDownLatch(1);
        var stopLatch = new CountDownLatch(count);

        for (int i = 0; i < count; i++) {
            if (i % 2 == 0) {
                new Thread(() -> {
                    try {
                        startLatch.await();
                    } catch (InterruptedException e) {
                        e.printStackTrace();
                    }
                    shared.writePlain(Long.MAX_VALUE);
                    stopLatch.countDown();
                }).start();
            } else {
                new Thread(() -> {
                    try {
                        startLatch.await();
                    } catch (InterruptedException e) {
                        e.printStackTrace();
                    }
                    while (shared.readPlain() == 0) {}
                    stopLatch.countDown();
                }).start();
            }
        }

        startLatch.countDown();
        stopLatch.await();
    }
}

class Shared {
    long value;
    private static final VarHandle VALUE;

    static {
        try {
            VALUE = MethodHandles.lookup().findVarHandle(Shared.class, "value", long.class);
        } catch (ReflectiveOperationException e) {
            throw new Error(e);
        }
    }

    public void writePlain(long value) {
//        VALUE.set(this, value);
        this.value = value;
    }

    public long readPlain() {
//        return (long) VALUE.get(this);
        return value;
    }

}