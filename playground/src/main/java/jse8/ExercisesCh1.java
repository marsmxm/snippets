package jse8;

import java.io.File;
import java.util.Arrays;

/**
 * @author sam
 * @date 6/2/16
 */
public class ExercisesCh1 {
    public static File[] e2(String dir) {
        File directory = new File(dir);
        return directory.listFiles((parent, filename) -> new File(parent, filename).isDirectory());
    }

    public static void main(String[] args) {
        System.out.println(Arrays.toString(e2("/home/sam/src")));
    }
}
