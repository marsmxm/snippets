package host.mxm.flow;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertTrue;

import java.io.IOException;
import java.io.PrintStream;
import java.lang.invoke.MethodHandle;
import java.lang.invoke.MethodHandles;
import java.lang.invoke.MethodType;
import java.lang.reflect.Method;
import java.util.Arrays;
import java.util.List;

import org.junit.Test;

public class MethodHandleTest {
    int i;

    MethodHandles.Lookup lookup = MethodHandles.lookup();
    MethodType mt = MethodType.methodType(void.class);
    MethodHandle fHandle = lookup.findVirtual(MethodHandleTest.class, "f", mt);

    Method f = MethodHandleTest.class.getDeclaredMethod("f");

    public MethodHandleTest() throws NoSuchMethodException, IllegalAccessException {}

    private void f() {
        i++;
//        System.out.println("f():" + i);
    }

    @Test
    public void test1() throws Throwable {
        long start = System.currentTimeMillis();
        for (int i = 0; i < 10_000_000; i++) {
            fHandle.invoke(this);
        }

        System.out.println(i);
        System.out.println("time used: " + (System.currentTimeMillis() - start));
    }

    @Test
    public void test2() throws Throwable {
        long start = System.currentTimeMillis();
        for (int i = 0; i < 10_000_000; i++) {
            f();
        }

        System.out.println(i);
        System.out.println("time used: " + (System.currentTimeMillis() - start));
    }

    @Test
    public void test3() throws Throwable {
        long start = System.currentTimeMillis();
        for (int i = 0; i < 10_000_000; i++) {
            f.invoke(this);
        }

        System.out.println(i);
        System.out.println("time used: " + (System.currentTimeMillis() - start));
    }

    @Test
    public void official() throws Throwable {
        Object x, y;
        String s;
        int i;
        MethodType mt;
        MethodHandle mh;
        MethodHandles.Lookup lookup = MethodHandles.lookup();

        // mt is (char,char)String
        mt = MethodType.methodType(String.class, char.class, char.class);
        mh = lookup.findVirtual(String.class, "replace", mt);
        s = (String) mh.invokeExact("daddy", 'd', 'n');
        // invokeExact(Ljava/lang/String;CC)Ljava/lang/String;
        assertEquals("nanny", s);

        // weakly typed invocation (using MHs.invoke)
        s = (String) mh.invokeWithArguments("sappy", 'p', 'v');
        assertEquals("savvy", s);

        // mt is (Object[])List
        mt = MethodType.methodType(List.class, Object[].class);
        mh = lookup.findStatic(Arrays.class, "asList", mt);
        assert mh.isVarargsCollector();
        x = mh.invoke("one", "two");
        // invoke(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/Object;
        assertEquals(Arrays.asList("one", "two"), x);

        // mt is (Object,Object,Object)Object
        mt = MethodType.genericMethodType(3);
        mh = mh.asType(mt);
        x = mh.invokeExact((Object) 1, (Object) 2, (Object) 3);
        // invokeExact(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
        assertEquals(Arrays.asList(1, 2, 3), x);

        // mt is ()int
        mt = MethodType.methodType(int.class);
        mh = lookup.findVirtual(List.class, "size", mt);
        i = (int) mh.invokeExact(Arrays.asList(1, 2, 3));
        // invokeExact(Ljava/util/List;)I
        assert i == 3;

        mt = MethodType.methodType(void.class, String.class);
        mh = lookup.findVirtual(PrintStream.class, "println", mt);
        mh.invokeExact(System.out, "Hello, world.");
        // invokeExact(Ljava/io/PrintStream;Ljava/lang/String;)V
    }

    @Test
    public void givenCurrentProcess_whenInvokeGetInfo_thenSuccess()
            throws IOException {

        ProcessHandle processHandle = ProcessHandle.current();
        ProcessHandle.Info processInfo = processHandle.info();

        System.out.println(processHandle.pid());
        System.out.println(processInfo.command().get());
        System.out.println(Arrays.toString(processInfo.arguments().get()));
        System.out.println(processInfo.user().get());

//        assertFalse(processInfo.arguments().isPresent());
        assertTrue(processInfo.command().isPresent());
        assertTrue(processInfo.command().get().contains("java"));
        assertTrue(processInfo.startInstant().isPresent());
        assertTrue(processInfo.totalCpuDuration().isPresent());
        assertTrue(processInfo.user().isPresent());
    }

    @Test
    public void spawn() throws IOException {
        String javaCmd = "/Library/Java/JavaVirtualMachines/jdk-10.0.1.jdk/Contents/Home/bin/java";
        ProcessBuilder processBuilder = new ProcessBuilder(javaCmd, "-version");
        Process process = processBuilder.inheritIO().start();
        ProcessHandle processHandle = process.toHandle();
        ProcessHandle.Info info = processHandle.info();

        System.out.println(info.command().get());
        System.out.println(Arrays.toString(info.arguments().get()));
        System.out.println(info.user().get());
    }
}
