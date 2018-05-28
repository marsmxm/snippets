package host.mxm.flow;

import java.util.concurrent.Executor;
import java.util.concurrent.Flow;
import java.util.concurrent.Flow.Subscriber;
import java.util.concurrent.atomic.AtomicLongFieldUpdater;

public final class FlowRange implements Flow.Publisher<Integer> {
    final int start;
    final int end;
    final Executor executor;

    public FlowRange(int start, int count, Executor executor) {
        this.start = start;
        this.end = start + count;
        this.executor = executor;
    }

    @Override
    public void subscribe(Flow.Subscriber<? super Integer> subscriber) {
        RangeSubscription sub = new RangeSubscription(subscriber, start, end, executor);
        sub.request(1);
    }


    static final class RangeSubscription implements Flow.Subscription, Runnable              // (2)
    {
        final Flow.Subscriber<? super Integer> actual;
        final int end;
        final Executor executor;
        private volatile long requested;
        private static final AtomicLongFieldUpdater<RangeSubscription> REQUESTED =
                AtomicLongFieldUpdater.newUpdater(RangeSubscription.class, "requested");
        int index;                                              // (3)
        boolean hasSubscribed;                                  // (4)

        volatile boolean cancelled;
        volatile boolean badRequest;                            // (5)

        RangeSubscription(
                Flow.Subscriber<? super Integer> actual,
                int start, int end,
                Executor executor) {
            this.actual = actual;
            this.index = start;
            this.end = end;
            this.executor = executor;
        }

        @Override
        public void request(long n) {
            if (n <= 0L) {
                badRequest = true;
                n = 1;
            }
            for (;;) {
                long r = requested;
                long u = r + n;
                if (u < 0L) {
                    u = Long.MAX_VALUE;
                }
                if (REQUESTED.compareAndSet(this, r, u)) {
                    if (r == 0L) {
                        executor.execute(this);
                    }
                    break;
                }
            }
        }

        @Override
        public void cancel() {
            cancelled = true;
        }

        @Override
        public void run() {
            Subscriber<? super Integer> a = actual;

            if (!hasSubscribed) {                        // (1)
                hasSubscribed = true;
                a.onSubscribe(this);
                if (REQUESTED.decrementAndGet(this) == 0) {            // (2)
                    return;
                }
            }

            long r = requested;                              // (3)
            int idx = index;
            int f = end;
            long e = 0L;

            for (;;) {
                while (e != r && idx != f) {             // (4)
                    if (cancelled) {
                        return;
                    }
                    if (badRequest) {                    // (5)
                        cancelled = true;
                        a.onError(new IllegalStateException(
                                "§3.9 violated: non-positive request received"));
                        return;
                    }

                    a.onNext(idx);

                    idx++;                               // (6)
                    e++;
                }

                if (idx == f) {                          // (7)
                    if (!cancelled) {
                        a.onComplete();
                    }
                    return;
                }

                r = requested;                               // (8)
                if (e == r) {
                    index = idx;
                    r = REQUESTED.addAndGet(this, -e);
                    if (r == 0L) {
                        break;
                    }
                    e = 0L;
                }
            }
        }
    }
}
