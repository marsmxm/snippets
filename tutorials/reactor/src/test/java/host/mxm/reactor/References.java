package host.mxm.reactor;

import static reactor.core.scheduler.Schedulers.elastic;

import com.google.common.collect.Lists;

import org.junit.Test;
import org.reactivestreams.Subscription;

import reactor.core.Disposable;
import reactor.core.publisher.BaseSubscriber;
import reactor.core.publisher.ConnectableFlux;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;
import reactor.core.scheduler.Schedulers;
import reactor.test.StepVerifier;

import java.time.Duration;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.atomic.AtomicBoolean;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.concurrent.atomic.AtomicLong;
import java.util.function.Function;

@SuppressWarnings("NewClassNamingConvention")
public class References {
    @Test
    public void subscribe() {
        // error
        Flux.range(1, 4)
            .map(i -> {
                if (i <= 3) {
                    return i;
                }
                throw new RuntimeException("Got to 4");
            })
            .subscribe(System.out::println,
                       error -> System.err.println("Error: " + error));

        // completion
        Flux.range(1, 4)
            .subscribe(System.out::println,
                       error -> System.err.println("Error " + error),
                       () -> System.out.println("Done"));

        Flux<Integer> ints = Flux.range(1, 4);
        ints.subscribe(System.out::println,
                       error -> System.err.println("Error " + error),
                       () -> System.out.println("Done"),
                       s -> s.request(2));
    }

    @Test
    public void customSubscriber() {
        class SampleSubscriber<T> extends BaseSubscriber<T> {
            @Override
            public void hookOnSubscribe(Subscription subscription) {
                System.out.println("Subscribed");
                request(1);
            }

            @Override
            public void hookOnNext(T value) {
                System.out.println(value);
                request(1);
            }
        }
        SampleSubscriber<Integer> ss = new SampleSubscriber<>();
        Flux.range(1, 4).subscribe(ss);
    }

    @Test
    public void generate() {
        Flux<String> flux = Flux.generate(
                () -> 0,
                (state, sink) -> {
                    sink.next("3 x " + state + " = " + 3 * state);
                    if (state == 10) {
                        sink.complete();
                    }
                    return state + 1;
                });

        flux.subscribe(System.out::println);

        System.out.println();

        // mutable state and with a state consumer (may do the cleaning job)
        Flux.generate(
                AtomicLong::new,
                (state, sink) -> {
                    long i = state.getAndIncrement();
                    sink.next("3 x " + i + " = " + 3 * i);
                    if (i == 10) {
                        sink.complete();
                    }
                    return state;
                },
                state -> System.out.println("state: " + state))
            .subscribe(System.out::println);
    }

    @Test
    public void create() {
        abstract class MyEventListener<T> {
            abstract void onDataChunk(List<T> chunk);

            abstract void processComplete();
        }
        class FakeDataSource<T> {
            private final List<MyEventListener<T>> listeners = new ArrayList<>();

            void register(MyEventListener<T> listener) {
                listeners.add(listener);
            }

            void produce(List<T> data) {
                listeners.forEach(l -> l.onDataChunk(data));
            }

            void complete() {
                listeners.forEach(MyEventListener::processComplete);
            }
        }

        FakeDataSource<String> source = new FakeDataSource<>();
        Flux<String> bridge = Flux.create(sink -> source.register(
                new MyEventListener<String>() {
                    @Override
                    public void onDataChunk(List<String> chunk) {
                        for (String s : chunk) {
                            sink.next(s);
                        }
                    }

                    @Override
                    public void processComplete() {
                        sink.complete();
                    }
                }));
        bridge.subscribe(System.out::println,
                         System.err::println,
                         () -> System.out.println("Complete."));

        System.out.println("Producing data: hello world.");
        source.produce(Lists.newArrayList("hello", "world"));
        System.out.println("Producing data: goodbye world.");
        source.produce(Lists.newArrayList("goodbye", "world"));
        System.out.println("complete");
        source.complete();

        System.out.println("Producing data: hello world again.");
        source.produce(Lists.newArrayList("hello", "world", "again"));
    }

    @Test
    public void interval() throws InterruptedException {
        Flux.interval(Duration.ofMillis(500))
            .subscribe(l -> System.out.println(Thread.currentThread().getName() + ": " + l));
        System.out.println("After interval");

        TimeUnit.SECONDS.sleep(3);
    }

    @Test
    public void publishOn() throws InterruptedException {
        Flux.range(1, 100)
            .doOnNext(i -> System.out.println("Before publishOn:" + Thread.currentThread().getName() + ": " + i))
            .publishOn(Schedulers.parallel())
            .subscribe(i -> System.out.println("After publishOn:" + Thread.currentThread().getName() + ": " + i));
        System.out.println(Thread.currentThread().getName() + ":publishOn!");

        TimeUnit.SECONDS.sleep(1);
    }

    @Test
    public void subscribeOn() throws InterruptedException {
        Flux.range(1, 100)
            .doOnNext(i -> System.out.println("Before subscribeOn:" + Thread.currentThread().getName() + ": " + i))
            .subscribeOn(Schedulers.parallel())
            .doOnNext(i -> System.out.println("After subscribeOn:" + Thread.currentThread().getName() + ": " + i))
            .subscribe();
        System.out.println(Thread.currentThread().getName() + ":subscribeOn!");

        TimeUnit.SECONDS.sleep(1);
    }

    @Test
    public void using() {
        AtomicBoolean isDisposed = new AtomicBoolean();
        Disposable disposableInstance = new Disposable() {
            @Override
            public void dispose() {
                isDisposed.set(true);
                System.out.println("disposed");
            }

            @Override
            public String toString() {
                return "DISPOSABLE";
            }
        };

        Flux<String> flux = Flux.using(
                () -> disposableInstance,
                disposable -> Flux.just(disposable.toString()),
                Disposable::dispose);

        flux.subscribe(System.out::println);
        flux.doOnNext(s -> {
            throw new RuntimeException(s);
        }).subscribe();
    }

    @Test
    public void errorTerminal() throws InterruptedException {
        Flux<String> flux =
                Flux.interval(Duration.ofMillis(250))
                    .map(input -> {
                        if (input < 3) {
                            return "tick " + input;
                        }
                        throw new RuntimeException("boom");
                    })
                    .onErrorReturn("Uh oh");

        flux.subscribe(System.out::println);
        Thread.sleep(2100);
    }

    @Test
    public void retry() throws InterruptedException {
        Flux.interval(Duration.ofMillis(250))
            .map(input -> {
                if (input < 3) {
                    return "tick " + input;
                }
                throw new RuntimeException("boom");
            })
            .elapsed()
            .retry(1)
            .subscribe(System.out::println, System.err::println);

        Thread.sleep(2100);
    }

    @Test
    public void retryWhen() {
        // Simply completing the companion would effectively swallow an error
        Flux.error(new IllegalArgumentException())
            .doOnError(System.out::println)
            .retryWhen(companion -> companion.take(3))
            .subscribe();
    }

    @Test
    public void transform() {
        Function<Flux<String>, Flux<String>> filterAndMap =
                f -> f.filter(color -> !color.equals("orange"))
                      .map(String::toUpperCase);

        Flux.fromIterable(Arrays.asList("blue", "green", "orange", "purple"))
            .doOnNext(System.out::println)
            .transform(filterAndMap)
            .subscribe(d -> System.out.println("Subscriber to Transformed MapAndFilter: " + d));
    }

    @Test
    public void compose() {
        AtomicInteger ai = new AtomicInteger();
        Function<Flux<String>, Flux<String>> filterAndMap = f -> {
            if (ai.incrementAndGet() == 1) {
                return f.filter(color -> !color.equals("orange"))
                        .map(String::toUpperCase);
            }
            return f.filter(color -> !color.equals("purple"))
                    .map(String::toUpperCase);
        };

        Flux<String> composedFlux =
                Flux.fromIterable(Arrays.asList("blue", "green", "orange", "purple"))
                    .doOnNext(System.out::println)
                    .compose(filterAndMap);

        composedFlux.subscribe(d -> System.out.println("Subscriber 1 to Composed MapAndFilter :" + d));
        composedFlux.subscribe(d -> System.out.println("Subscriber 2 to Composed MapAndFilter: " + d));
    }

    @Test
    public void publish() throws InterruptedException {
        Flux<Integer> source = Flux.range(1, 3)
                                   .doOnSubscribe(s -> System.out.println("subscribed to source"));

        ConnectableFlux<Integer> co = source.publish();

        co.subscribe(System.out::println, e -> { }, () -> { });
        co.subscribe(System.out::println, e -> { }, () -> { });

        System.out.println("done subscribing");
        Thread.sleep(500);
        System.out.println("will now connect");

        co.connect();
    }

    @Test
    public void autoConnect() throws InterruptedException {
        Flux<Integer> source = Flux.range(1, 3)
                                   .doOnSubscribe(s -> System.out.println("subscribed to source"));

        Flux<Integer> autoCo = source.publish().autoConnect(2);

        autoCo.subscribe(System.out::println, e -> { }, () -> { });
        System.out.println("subscribed first");
        Thread.sleep(500);
        System.out.println("subscribing second");
        autoCo.subscribe(System.out::println, e -> { }, () -> { });
    }

    @Test
    public void replay() throws InterruptedException {
        Flux<Integer> source = Flux.range(1, 3)
                                   .concatWith(Mono.delay(Duration.ofSeconds(1)).map(i -> 42))
                                   .doOnSubscribe(s -> System.out.println(Thread.currentThread().getName() + ": subscribed to source"));
        ConnectableFlux<Integer> co = source.replay();

        co.subscribe(i -> System.out.println(Thread.currentThread().getName() + ": " + i), e -> { }, () -> { });
        System.out.println(Thread.currentThread().getName() + ": subscribed first");
        co.connect();
        Thread.sleep(500);
        System.out.println(Thread.currentThread().getName() + ": subscribing second");
        co.subscribe(i -> System.out.println(Thread.currentThread().getName() + ": " + i), e -> { }, () -> { });

        TimeUnit.SECONDS.sleep(2);
    }

    @Test
    public void groupBy() {
        StepVerifier.create(
                Flux.just(1, 3, 5, 2, 4, 6, 11, 12, 13)
                    .groupBy(i -> i % 2 == 0 ? "even" : "odd")
                    .concatMap(g -> g.defaultIfEmpty(-1) //if empty groups, show them
                                     .map(String::valueOf) //map to string
                                     .startWith(g.key()))) //start with the group's key
                    .expectNext("odd", "1", "3", "5", "11", "13")
                    .expectNext("even", "2", "4", "6", "12")
                    .verifyComplete();
    }

    @Test
    public void window() {
        StepVerifier.create(
                Flux.range(1, 10)
                    .window(5, 3) //overlapping windows
                    .concatMap(g -> g.defaultIfEmpty(-1))) //show empty windows as -1
                    .expectNext(1, 2, 3, 4, 5)
                    .expectNext(4, 5, 6, 7, 8)
                    .expectNext(7, 8, 9, 10)
                    .expectNext(10)
                    .verifyComplete();

        StepVerifier.create(
                Flux.just(1, 3, 5, 2, 4, 6, 11, 12, 13)
                    .windowWhile(i -> i % 2 == 0)
                    .concatMap(g -> g.defaultIfEmpty(-1)))
                    .expectNext(-1, -1, -1) //respectively triggered by odd 1 3 5
                    .expectNext(2, 4, 6) // triggered by 11
                    .expectNext(12) // triggered by 13
                    .expectNext(-1) // empty completion window, would have been omitted if all matched before onComplete
                    .verifyComplete();
    }

    @Test
    public void buffer() {
        StepVerifier.create(
                Flux.range(1, 10)
                    .buffer(5, 3)) //overlapping buffers
                    .expectNext(Arrays.asList(1, 2, 3, 4, 5))
                    .expectNext(Arrays.asList(4, 5, 6, 7, 8))
                    .expectNext(Arrays.asList(7, 8, 9, 10))
                    .expectNext(Collections.singletonList(10))
                    .verifyComplete();

        StepVerifier.create(
                Flux.just(1, 3, 5, 2, 4, 6, 11, 12, 13)
                    .bufferWhile(i -> i % 2 == 0)
        )
                    .expectNext(Arrays.asList(2, 4, 6)) // triggered by 11
                    .expectNext(Collections.singletonList(12)) // triggered by 13
                    .verifyComplete();
    }

    @Test
    public void parallel() {
        Flux.range(1, 10)
            .parallel(2)
            .subscribe(i -> System.out.println(Thread.currentThread().getName() + " -> " + i));

        Flux.range(1, 10)
            .parallel(2)
            .runOn(Schedulers.parallel())
            .subscribe(i -> System.out.println(Thread.currentThread().getName() + " -> " + i));
    }

    @Test
    public void toFuture() throws InterruptedException {
        Mono.just(0)
            .publishOn(elastic())
            .doOnNext(i -> System.err.println(i + " " + Thread.currentThread().getName()))
            .toFuture();

        System.err.println("end");
        Thread.sleep(2000);
    }

}