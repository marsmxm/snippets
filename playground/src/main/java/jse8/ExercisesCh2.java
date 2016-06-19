package jse8;

import com.google.common.collect.Lists;

import java.io.File;
import java.io.FileNotFoundException;
import java.net.URL;
import java.util.*;
import java.util.concurrent.CountDownLatch;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.function.*;
import java.util.stream.*;

/**
 * @author sam
 * @date 6/2/16
 */
public class ExercisesCh2 {

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

    private static List<String> e2() {
        List<String> words = Lists.newArrayList("ab", "cde", "fgh", "ig", "kl");
        return words.stream()
                .filter(word -> {
                    System.out.println("in filter");
                    return word.length() >= 3;
                })
                .limit(2)
                .collect(Collectors.toList());
    }

    private static void e3() {
        ClassLoader classloader = Thread.currentThread().getContextClassLoader();
        URL url = classloader.getResource("war_and_peace.txt");
        assert url != null : "文件不存在";
        File file = new File(url.getFile());
        List<String> words = new ArrayList<>();

        try (Scanner scanner = new Scanner(file)) {
            while (scanner.hasNextLine()) {
                String line = scanner.nextLine();
                words.addAll(Arrays.asList(line.split("\\s")));
            }
            System.out.println(words.size());
            long start = System.currentTimeMillis();
            System.out.println(words.stream().filter(word -> word.length() > 5).count());
            System.out.println("time cost: " + (System.currentTimeMillis() - start));

            long paralStart = System.currentTimeMillis();
            System.out.println(words.parallelStream().filter(word -> word.length() > 5).count());
            System.out.println("parallel time cost: " + (System.currentTimeMillis() - paralStart));
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }
    }

    private static void e4() {
        int[] values = {1, 4, 9, 16};
        Stream.of(values).forEach(System.out::println);
        Arrays.stream(values).forEach(System.out::println);
    }

    private static Stream<Double> e5() {
        return Stream.iterate(1.0, e -> {
            long a = 25214903917L;
            long c = 11;
            double m = Math.pow(2, 32);
            return (a * e + c) % m;
        });
    }

    private static Stream<Character> e6(String s) {
        return Stream.iterate(0, p -> p + 1).limit(s.length()).map(s::charAt);
    }


    public static void main(String[] args) {
        System.out.println(e6("Mu Xian Ming").collect(Collectors.toList()));
    }
}
