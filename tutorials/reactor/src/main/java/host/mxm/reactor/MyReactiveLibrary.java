package host.mxm.reactor;

import java.time.Duration;

import org.springframework.stereotype.Component;

import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

@Component
public class MyReactiveLibrary {

    public Flux<String> alphabet5(char from) {
        return Flux.range(from, 5)
                   .map(i -> "" + (char) i.intValue());
    }

    public Mono<String> withDelay(String value, int delaySeconds) {
        return Mono.just(value)
                   .delaySubscription(Duration.ofSeconds(delaySeconds));
    }
}