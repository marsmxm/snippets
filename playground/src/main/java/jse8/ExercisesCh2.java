package jse8;

import io.codearte.jfairy.Fairy;

import java.util.*;
import java.util.concurrent.CountDownLatch;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.atomic.AtomicInteger;

/**
 * @author sam
 * @date 6/2/16
 */
public class ExercisesCh2 {
    static class RandomString {
        private static final char[] symbols;

        static {
            StringBuilder tmp = new StringBuilder();
            for (char ch = '0'; ch <= '9'; ++ch)
                tmp.append(ch);
            for (char ch = 'a'; ch <= 'z'; ++ch)
                tmp.append(ch);
            symbols = tmp.toString().toCharArray();
        }

        private final Random random = new Random();

        private final char[] buf;

        public RandomString(int length) {
            if (length < 1)
                throw new IllegalArgumentException("length < 1: " + length);
            buf = new char[length];
        }

        public String nextString() {
            for (int idx = 0; idx < buf.length; ++idx)
                buf[idx] = symbols[random.nextInt(symbols.length)];
            return new String(buf);
        }
    }

    public static int e1Normal(String[] words) {
        int count = 0;
        for (String w : words) {
            if (w.length() > 4) count++;
        }
        return count;
    }

    public static int e1(String[] words) throws InterruptedException {
        AtomicInteger total = new AtomicInteger(0);
        int cores = Runtime.getRuntime().availableProcessors();
        int subLen = words.length / cores;
        ExecutorService pool = Executors.newFixedThreadPool(cores);
        CountDownLatch latch = new CountDownLatch(cores);

        for (int i = 0; i < cores; i++) {
            final int index = i;
            new Thread(() -> {
                long start = System.currentTimeMillis();
                int count = 0;
                for (int j = index * subLen;
                     j < (index + 1) * subLen && j < words.length || (index == cores - 1 && j < words.length);
                     j++) {
                    if (words[j].length() > 4) count++;
                }
                total.addAndGet(count);
                latch.countDown();
                System.out.println(System.currentTimeMillis() - start);
            }).start();
        }
        latch.await();
        return total.get();
    }

    public static void main(String[] args) {

    }
}
