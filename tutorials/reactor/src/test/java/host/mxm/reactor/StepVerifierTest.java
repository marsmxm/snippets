package host.mxm.reactor;

import java.time.Duration;

import org.junit.Test;

import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;
import reactor.test.StepVerifier;

public class StepVerifierTest {
    @Test
    public void test1() {
        Flux<String> source = Flux.just("foo", "bar");

        StepVerifier.create(source.concatWith(Mono.error(new IllegalArgumentException("boom"))))
                    .expectNext("foo")
                    .expectNext("bar")
                    .expectErrorMessage("boom")
                    .verify();
    }

    @Test
    public void virtualTime() {
        Duration duration = StepVerifier.withVirtualTime(() -> Mono.delay(Duration.ofDays(1)))
                                        .expectSubscription()
                                        .expectNoEvent(Duration.ofDays(1))
                                        .expectNextCount(1)
                                        .verifyComplete();

        System.out.println(duration.toMillis());
    }
}
