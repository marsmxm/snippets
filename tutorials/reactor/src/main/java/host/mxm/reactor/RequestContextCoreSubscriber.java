/*
 * Copyright (c) 2019 LINE Corporation. All rights reserved.
 * LINE Corporation PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
 */

package host.mxm.reactor;

import java.util.function.Consumer;

import org.reactivestreams.Subscriber;
import org.reactivestreams.Subscription;

import reactor.core.CoreSubscriber;
import reactor.util.context.Context;

public class RequestContextCoreSubscriber<T> implements CoreSubscriber<T> {
    public static final ThreadLocal<Context> CONTEXT_THREAD_LOCAL = new ThreadLocal<>();
    private Context context;
    private final Subscriber<? super T> subscriber;

    public RequestContextCoreSubscriber(CoreSubscriber<? super T> subscriber) {
        context = Context.empty();
        Context parentContext = subscriber.currentContext();
        context = context.putAll(parentContext);
        this.subscriber = subscriber;
    }

    @Override
    public void onSubscribe(Subscription subscription) {
        withMDC(subscriber -> subscriber.onSubscribe(subscription));
    }

    @Override
    public void onNext(T o) {
        withMDC(subscriber -> subscriber.onNext(o));
    }

    @Override
    public void onError(Throwable throwable) {
        withMDC(subscriber -> subscriber.onError(throwable));
    }

    @Override
    public void onComplete() {
        withMDC(Subscriber::onComplete);
    }

    @Override
    public Context currentContext() {
        return context;
    }

    private void withMDC(Consumer<Subscriber<? super T>> consumer) {
        if (context.hasKey("world")) {
            CONTEXT_THREAD_LOCAL.set(context);
        }
        consumer.accept(subscriber);
    }
}
