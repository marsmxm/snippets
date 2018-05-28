package host.mxm.flow;

import static java.lang.invoke.MethodHandles.privateLookupIn;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertSame;

import java.lang.invoke.MethodHandles;
import java.lang.invoke.VarHandle;
import java.util.concurrent.CountDownLatch;

import org.junit.Test;

public class VariableHandlesTest {
    public int publicTestVariable = 1;
    private int privateTestVariable = 1;
    public int variableToCompareAndSet = 1;
    public int variableToGetAndAdd = 0;
    public byte variableToBitwiseOr = 0;

    @Test
    public void test1() throws Exception {
        VarHandle publicIntHandle = MethodHandles
                .lookup()
                .in(VariableHandlesTest.class)
                .findVarHandle(VariableHandlesTest.class, "publicTestVariable", int.class);

        assertEquals(1, publicIntHandle.coordinateTypes().size());
        assertSame(VariableHandlesTest.class, publicIntHandle.coordinateTypes().get(0));

        assertEquals(1, publicIntHandle.get(this));
        publicIntHandle.set(this, 15);
        assertEquals(15, publicIntHandle.get(this));

    }

    @Test
    public void test2() throws Exception {
        VarHandle privateIntHandle =
                privateLookupIn(VariableHandlesTest.class, MethodHandles.lookup())
                .findVarHandle(VariableHandlesTest.class, "privateTestVariable", int.class);

        assertEquals(1, privateIntHandle.coordinateTypes().size());
        assertSame(VariableHandlesTest.class, privateIntHandle.coordinateTypes().get(0));

        privateIntHandle.set(this, 15);
        assertEquals(15, privateIntHandle.get(this));
    }

    @Test
    public void test3() {
        VarHandle arrayVarHandle = MethodHandles.arrayElementVarHandle(int[].class);

        System.out.println(arrayVarHandle.coordinateTypes());
        assertEquals(2, arrayVarHandle.coordinateTypes().size());
        assertSame(int[].class, arrayVarHandle.coordinateTypes().get(0));
    }

    @Test
    public void test4() throws Exception {
        VarHandle handle = MethodHandles
                .lookup()
                .in(VariableHandlesTest.class)
                .findVarHandle(VariableHandlesTest.class, "variableToCompareAndSet", int.class);

        CountDownLatch latch = new CountDownLatch(2);

        new Thread(() -> {
            while (!handle.compareAndSet(this, 1, 100)) { }
            latch.countDown();
        }).start();

        new Thread(() -> {
            while (!handle.compareAndSet(this, 100, 200)) { }
            latch.countDown();
        }).start();

        latch.await();
        assertEquals(200, handle.get(this));
    }

    @Test
    public void test5() throws Exception {
        VarHandle handle = MethodHandles
                .lookup()
                .in(VariableHandlesTest.class)
                .findVarHandle(VariableHandlesTest.class, "variableToGetAndAdd", int.class);

        CountDownLatch latch = new CountDownLatch(2);

        new Thread(() -> {
            handle.getAndAdd(this, 100);
            latch.countDown();
        }).start();

        new Thread(() -> {
            handle.getAndAdd(this, 100);
            latch.countDown();
        }).start();

        latch.await();
        assertEquals(200, handle.get(this));
    }

    @Test
    public void test6() throws Exception {
        VarHandle handle = MethodHandles
                .lookup()
                .in(VariableHandlesTest.class)
                .findVarHandle(VariableHandlesTest.class, "variableToBitwiseOr", byte.class);

        byte before = (byte) handle.getAndBitwiseOr(this, (byte) 127);

        assertEquals(0, before);
        assertEquals(127, variableToBitwiseOr);
    }
}
