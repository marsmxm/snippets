package host.mxm.flow;

import static org.junit.Assert.assertTrue;

import java.io.IOException;
import java.lang.invoke.MethodHandle;
import java.lang.invoke.MethodHandles;
import java.lang.invoke.MethodType;
import java.lang.reflect.Method;
import java.util.Arrays;

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
