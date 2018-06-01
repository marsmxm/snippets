package host.mxm.sample;

/**
 *
 * @author Mu Xian Ming (Sam)
 */
public class Main {
    public static void main(String[] args) {
        class TestRunnable implements Runnable {
            int x = 0;
            int y = 0;
            @Override
            public void run() {
                int r = x;
                y = r;
                System.out.println(r);
            }
        }

        TestRunnable r = new TestRunnable();

        for (int i = 0; i < 100; i++) {
            new Thread(r).start();
        }
    }
}

class FinalFieldExample {
    final int x;
    int y;
    static FinalFieldExample f;

    public FinalFieldExample() {
        x = 3;
        y = new Integer(4);
    }

    static void writer() {
        f = new FinalFieldExample();
    }

    static void reader() {
        if (f != null) {
            int i = f.x; // guaranteed to see 3
            int j = f.y; // could see 0
            System.out.println(Thread.currentThread().getName() + ": x=" + i + ", y=" + j);
        }
    }
}