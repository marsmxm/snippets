package host.mxm.reactor;

import static host.mxm.reactor.RequestContextCoreSubscriber.CONTEXT_THREAD_LOCAL;

import reactor.core.publisher.Hooks;
import reactor.core.publisher.Mono;
import reactor.core.publisher.Operators;
import reactor.core.scheduler.Schedulers;
import reactor.util.context.Context;

/**
 *
 * @author Mu Xian Ming (Sam)
 */
public class HooksTest {
    static {
        Hooks.onEachOperator(HooksTest.class.getName(), Operators.lift(
                (scannable, subscriber) -> new RequestContextCoreSubscriber<>(subscriber)));
    }

    public static void main(String[] args) throws InterruptedException {
        Mono.just("hello")
            .doOnNext(s -> {
                Mono.just("publish")
                    .publishOn(Schedulers.elastic())
                    .flatMap(ss -> {
                        System.err.println(".flatMap thread: " + Thread.currentThread().getName());
                        System.err.println(".flatMap context: " + CONTEXT_THREAD_LOCAL.get());
                        return Mono.just(ss + "haha");
                    })
                    .subscribe();

                System.out.println("doOnNext: " + Thread.currentThread().getName());
                Context ctx = CONTEXT_THREAD_LOCAL.get();
                System.out.println(ctx);
            })
            .subscriberContext(context -> {
                System.out.println("context thread: " + Thread.currentThread().getName());
                Context newCtx = context.put("world", "world");
                CONTEXT_THREAD_LOCAL.set(newCtx);
                return newCtx;
            })
            .subscribe(s -> System.out.println("complete"));

        Thread.sleep(500);
    }
}
