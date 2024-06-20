// Generated from /Users/mxm/learn/snippets/antlr-code/original/errors/Vec.g4 by ANTLR 4.13.1
import org.antlr.v4.runtime.tree.ParseTreeVisitor;

/**
 * This interface defines a complete generic visitor for a parse tree produced
 * by {@link VecParser}.
 *
 * @param <T> The return type of the visit operation. Use {@link Void} for
 * operations with no return type.
 */
public interface VecVisitor<T> extends ParseTreeVisitor<T> {
	/**
	 * Visit a parse tree produced by {@link VecParser#vec4}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitVec4(VecParser.Vec4Context ctx);
	/**
	 * Visit a parse tree produced by {@link VecParser#ints}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitInts(VecParser.IntsContext ctx);
}