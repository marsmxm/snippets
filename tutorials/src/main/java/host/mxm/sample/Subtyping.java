package host.mxm.sample;

import java.awt.Color;
import java.util.List;

import com.google.common.collect.Lists;

import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;

/**
 *
 * @author Mu Xian Ming (Sam)
 */
public class Subtyping {
    static class Word {
        String word = "word";
    }

    static class WordMore extends Word {
        String wordMore = "more";
    }

    static class Speaker {
        Word speak(Word w) {
            w.word += w.word;
            return w;
        }
    }

    static class Speaker1 extends Speaker {
        Word speak(Object o) {
            Word w = new Word();
            w.word = o.toString();
            return w;
        }
    }

    static class Speaker2 extends Speaker {
        @Override
        WordMore speak(Word w) {
            return new WordMore();
        }
    }

    @AllArgsConstructor
    static class Point {
        int x;
        int y;
    }

    static class ColorPoint extends Point {
        String color;

        ColorPoint(int x, int y, String color) {
            super(x, y);
            this.color = color;
        }
    }

    public static void main(String[] args) {
        List<Point> pts = Lists.newArrayList(new Point(1, 2));
        List<ColorPoint> cpts = Lists.newArrayList(new ColorPoint(1, 2, "red"));
        List<? super ColorPoint> ps = pts;
        ps.add(new ColorPoint(1,2,"red"));

        List<? extends Point> ps1 = cpts;
        Point p = ps1.get(0);
    }
}
