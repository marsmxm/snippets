package host.mxm.sample;

import java.util.List;

import com.google.common.collect.Lists;

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

    public static void main(String[] args) {
        List<Speaker> speakers = Lists.newArrayList(new Speaker(), new Speaker1(), new Speaker2());
        speakers.forEach(s -> System.out.println(s.speak(new Word()).word));
    }
}
