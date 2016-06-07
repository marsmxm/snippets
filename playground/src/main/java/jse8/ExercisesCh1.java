package jse8;

import java.io.File;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.List;
import java.util.function.Consumer;
import java.util.function.Predicate;

/**
 * @author sam
 * @date 6/2/16
 */
public class ExercisesCh1 {
    private static File[] e2(String dir) {
        File directory = new File(dir);
        return directory.listFiles((parent, filename) -> new File(parent, filename).isDirectory());
    }

    private static String[] e3(String dir, String ext) {
        File directory = new File(dir);
        return directory.list((parent, filename) -> {
            String[] parts = filename.split("\\.");
            return parts[parts.length - 1].equals(ext);
        });
    }

    private static File[] e4(File[] files) {
        Arrays.sort(files, (f1, f2) -> {
            if (f1.isDirectory() && !f2.isDirectory()) {
                return -1;
            } else if (!f1.isDirectory() && f2.isDirectory()) {
                return 1;
            } else {
                return f1.getName().compareTo(f2.getName());
            }
        });
        return files;
    }


    private interface RunnableEx {
        void run() throws Exception;
    }

    private static Runnable uncheck(RunnableEx runner) {
        return () -> {
            try {
                runner.run();
            } catch (Exception e) {
                throw new RuntimeException(e);
            }
        };
    }

    private static void e8() {
        String[] names = { "Peter", "Paul", "Mary" };
        List<Runnable> runners = new ArrayList<>();
        for (String name : names) {
            runners.add(() -> System.out.println(name));
        }
        // illegal
//        for (int i = 0; i < names.length; i++) {
//            runners.add(() -> System.out.println(names[i]));
//        }
        for (Runnable runner : runners) {
            new Thread(runner).start();
        }
    }

    private interface Collection2<T> extends Collection<T> {
        default void forEachIf(Consumer<T> action, Predicate<T> filter) {
            this.forEach(e -> {if (filter.test(e)) action.accept(e);});
        }
    }


    public static void main(String[] args) {
        new Thread(uncheck(
                () -> { System.out.println("Zzz"); Thread.sleep(1000); })).start();
        e8();
    }
}
