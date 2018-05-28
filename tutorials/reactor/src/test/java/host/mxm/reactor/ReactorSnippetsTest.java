package host.mxm.reactor;

import java.time.Duration;
import java.util.Arrays;
import java.util.List;
import java.util.regex.Pattern;

import org.junit.Test;

import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

public class ReactorSnippetsTest {
    private static final List<String> words = Arrays.asList(
            "the", "quick", "brown", "fox", "jumped", "over", "the", "lazy", "dog");
    private static final Pattern EMPTY_STRING = Pattern.compile("");

    @Test
    public void simpleCreation() {
        Flux<String> fewWords = Flux.just("Hello", "World");
        Flux<String> manyWords = Flux.fromIterable(words);

        fewWords.subscribe(System.out::println);
        System.out.println();
        manyWords.subscribe(System.out::println);
    }

    @Test
    public void findingMissingLetter() {
        Flux<String> manyLetters = Flux
                .fromIterable(words)
                .flatMap(word -> Flux.fromArray(EMPTY_STRING.split(word)))
                .distinct()
                .sort()
                .zipWith(Flux.range(1, Integer.MAX_VALUE),
                         (string, count) -> String.format("%2d. %s", count, string));

        manyLetters.subscribe(System.out::println);
    }

    @Test
    public void restoringMissingLetter() {
        Mono<String> missing = Mono.just("s");
        Flux<String> allLetters = Flux
                .fromIterable(words)
                .flatMap(word -> Flux.fromArray(EMPTY_STRING.split(word)))
                .concatWith(missing)
                .distinct()
                .sort()
                .zipWith(Flux.range(1, Integer.MAX_VALUE),
                         (string, count) -> String.format("%2d. %s", count, string));

        allLetters.subscribe(System.out::println);
    }

    @Test
    public void shortCircuit() {
        Flux<String> helloPauseWorld =
                Mono.just("Hello")
                    .concatWith(Mono.just("world")
                                    .delaySubscription(Duration.ofMillis(500)));

        helloPauseWorld.subscribe(System.out::println);
    }

    @Test
    public void blocks() {
        Flux<String> helloPauseWorld =
                Mono.just("Hello")
                    .concatWith(Mono.just("world")
                                    .delaySubscription(Duration.ofMillis(500)));

        helloPauseWorld.toStream()
                       .forEach(System.out::println);
    }

    @Test
    public void firstEmitting() {
        Mono<String> a = Mono.just("oops I'm late")
                             .delaySubscription(Duration.ofMillis(500));
        Flux<String> b = Flux.just("let's get", "the party", "started")
                             .delayElements(Duration.ofMillis(400));

        Flux.first(a, b)
            .toIterable()
            .forEach(System.out::println);
    }
}
