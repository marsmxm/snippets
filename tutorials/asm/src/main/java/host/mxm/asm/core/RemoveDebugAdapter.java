package host.mxm.asm.core;

import static org.objectweb.asm.Opcodes.ASM4;

import java.io.IOException;

import org.objectweb.asm.ClassReader;
import org.objectweb.asm.ClassVisitor;
import org.objectweb.asm.ClassWriter;

/**
 *
 * @author Mu Xian Ming (Sam)
 */
public class RemoveDebugAdapter extends ClassVisitor {
    public RemoveDebugAdapter(ClassVisitor cv) {
        super(ASM4, cv);
    }

    @Override
    public void visitSource(String source, String debug) {
        System.out.println("source: " + source);
    }

    @Override
    public void visitOuterClass(String owner, String name, String desc) {
        System.out.printf("outer: %s, %s, %s\n", owner, name, desc);
    }

    @Override
    public void visitInnerClass(String name, String outerName,
                                String innerName, int access) {
        System.out.printf("inner: %s, %s, %s, %d\n", name, outerName, innerName, access);

    }

    public static void main(String[] args) throws IOException {
        ClassWriter cw = new ClassWriter(0);
        ClassReader cr = new ClassReader("host.mxm.asm.core.ClassGenerator");
        cr.accept(new RemoveDebugAdapter(cw), 0);


    }
}
