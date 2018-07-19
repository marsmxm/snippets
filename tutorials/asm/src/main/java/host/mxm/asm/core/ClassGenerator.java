package host.mxm.asm.core;

import static org.objectweb.asm.Opcodes.ACC_ABSTRACT;
import static org.objectweb.asm.Opcodes.ACC_FINAL;
import static org.objectweb.asm.Opcodes.ACC_INTERFACE;
import static org.objectweb.asm.Opcodes.ACC_PUBLIC;
import static org.objectweb.asm.Opcodes.ACC_STATIC;
import static org.objectweb.asm.Opcodes.V1_5;

import java.io.PrintWriter;
import java.util.Arrays;

import org.objectweb.asm.ClassWriter;
import org.objectweb.asm.util.CheckClassAdapter;
import org.objectweb.asm.util.TraceClassVisitor;

/**
 *
 * @author Mu Xian Ming (Sam)
 */
//interface ComparableI extends MesurableI {
//    int LESS = -1;
//    int EQUAL = 0;
//    int GREATER = 1;
//
//    int compareTo(Object o);
//}
//
public final class ClassGenerator {
    public interface MesurableI { }
    static class MyClassLoader extends ClassLoader {
        public Class<?> defineClass(String name, byte[] b) {
            return defineClass(name, b, 0, b.length);
        }
    }

    public static void main(String[] args) {
        ClassWriter cw = new ClassWriter(0);
        TraceClassVisitor tcv = new TraceClassVisitor(cw, new PrintWriter(System.out));
        CheckClassAdapter cv = new CheckClassAdapter(tcv);

        cv.visit(V1_5, ACC_PUBLIC + ACC_ABSTRACT + ACC_INTERFACE,
                 "host/mxm/asm/core/ComparableI", null, "java/lang/Object",
                 new String[] { "host/mxm/asm/core/ClassGenerator$MesurableI" });
        cv.visitField(ACC_PUBLIC + ACC_FINAL + ACC_STATIC, "LESS", "I",
                      null, new Integer(-1)).visitEnd();
        cv.visitField(ACC_PUBLIC + ACC_FINAL + ACC_STATIC, "EQUAL", "I",
                      null, new Integer(0)).visitEnd();
        cv.visitField(ACC_PUBLIC + ACC_FINAL + ACC_STATIC, "GREATER", "I",
                      null, new Integer(1)).visitEnd();
        cv.visitMethod(ACC_PUBLIC + ACC_ABSTRACT, "compareTo",
                       "(Ljava/lang/Object;)I", null, null).visitEnd();
        cv.visitEnd();
        byte[] b = cw.toByteArray();

        Class<?> c = new MyClassLoader().defineClass("host.mxm.asm.core.ComparableI", b);
        System.out.println(Arrays.toString(c.getDeclaredFields()));
        System.out.println(Arrays.toString(c.getDeclaredMethods()));
    }
}


