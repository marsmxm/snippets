package host.mxm.reactor.spring;

import static host.mxm.reactor.RequestContextCoreSubscriber.CONTEXT_THREAD_LOCAL;

import java.time.Duration;

import javax.annotation.PostConstruct;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.EnableAspectJAutoProxy;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import host.mxm.reactor.HooksTest;
import host.mxm.reactor.RequestContextCoreSubscriber;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Hooks;
import reactor.core.publisher.Mono;
import reactor.core.publisher.Operators;

@SpringBootApplication
@RestController
public class Application {
    @Configuration
    static class Config {
        @PostConstruct
        public void init() {
            Hooks.onEachOperator(HooksTest.class.getName(), Operators.lift(
                    (scannable, subscriber) -> new RequestContextCoreSubscriber<>(subscriber)));
        }
    }

    @GetMapping("hello/v{version:\\d+}/{who}")
    public Mono<String> hello(@PathVariable String who, @PathVariable String version) {
        System.err.println("version: " + version);
        return Mono.just(who)
                   .map(w -> {
                       return "Hello " + w + '!';
                   });
    }

    @GetMapping("helloDelay/{who}")
    public Mono<String> helloDelay(@PathVariable String who) {
        System.err.println("helloDelay() thread: " + Thread.currentThread().getName());
        System.err.println("helloDelay() context: " + CONTEXT_THREAD_LOCAL.get());
        return Mono.delay(Duration.ofMillis(1000)).map(ignore -> {
            System.err.println("helloDelay().map thread: " + Thread.currentThread().getName());
            System.err.println("helloDelay().map context: " + CONTEXT_THREAD_LOCAL.get());
            return "Hello " + who + "!!";
        });
    }

    @PostMapping("heyMister")
    public Flux<String> hey(@RequestBody Mono<Sir> body) {
        return Mono.just("Hey mister ")
                   .concatWith(body.flatMapMany(sir -> Flux.fromArray(sir.getLastName().split("")))
                                   .map(String::toUpperCase)
                                   .take(1))
                   .concatWith(Mono.just(". how are you?"));
    }

    public static void main(String[] args) {
        SpringApplication.run(Application.class);
    }


}
