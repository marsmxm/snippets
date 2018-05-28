package host.mxm.reactor;

import static org.junit.Assert.*;

import java.time.Duration;

import org.junit.Test;

import reactor.test.StepVerifier;

public class MyReactiveLibraryTest {
    private final MyReactiveLibrary library = new MyReactiveLibrary();

    @Test
    public void testAlphabet5LimitsToZ() {
        StepVerifier.create(library.alphabet5('x'))
                    .expectNext("x", "y", "z")
                    .expectComplete()
                    .verify();
    }

    @Test
    public void testAlphabet5LastItemIsAlphabeticalChar() {
        MyReactiveLibrary library = new MyReactiveLibrary();
        StepVerifier.create(library.alphabet5('x'))
                    .consumeNextWith(c -> assertTrue(c.matches("[a-z]")))
                    .consumeNextWith(c -> assertTrue(c.matches("[a-z]")))
                    .consumeNextWith(c -> assertTrue(c.matches("[a-z]")))
                    .consumeNextWith(c -> assertTrue(c.matches("[a-z]")))
                    .expectComplete()
                    .verify();
    }

    @Test
    public void testWithDelay() {
        Duration testDuration =
                StepVerifier.withVirtualTime(() -> library.withDelay("foo", 30))
                            .expectSubscription()
                            .thenAwait(Duration.ofSeconds(10))
                            .expectNoEvent(Duration.ofSeconds(10))
                            .thenAwait(Duration.ofSeconds(10))
                            .expectNext("foo")
                            .expectComplete()
                            .verify();
        System.out.println(testDuration.toMillis() + "ms");
    }
}