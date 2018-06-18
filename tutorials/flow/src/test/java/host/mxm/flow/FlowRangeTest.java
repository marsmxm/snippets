package host.mxm.flow;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertTrue;

import java.util.Arrays;
import java.util.concurrent.ForkJoinPool;
import java.util.concurrent.TimeUnit;

import org.junit.Test;

public class FlowRangeTest {

    @Test
    public void normal() {
        FlowRange source = new FlowRange(1, 5, Runnable::run);

        TestFlowSubscriber<Integer> ts = new TestFlowSubscriber<>();

        source.subscribe(ts);

        assertEquals(Arrays.asList(1, 2, 3, 4, 5), ts.values());
        assertEquals(1, ts.completions());
        assertTrue(ts.errors().isEmpty());
    }

    @Test
    public void async() throws InterruptedException {
        FlowRange source = new FlowRange(1, 5, ForkJoinPool.commonPool());
        TestFlowSubscriber<Integer> ts = new TestFlowSubscriber<>();

        source.subscribe(ts);

        assertTrue(ts.await(5, TimeUnit.SECONDS));
        assertEquals(Arrays.asList(1, 2, 3, 4, 5), ts.values());
        assertEquals(1, ts.completions());
        assertTrue(ts.errors().isEmpty());
    }
}