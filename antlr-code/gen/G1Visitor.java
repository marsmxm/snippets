// Generated from /Users/mxm/learn/snippets/antlr-code/original/reference/G1.g4 by ANTLR 4.13.1
import org.antlr.v4.runtime.tree.ParseTreeVisitor;

/**
 * This interface defines a complete generic visitor for a parse tree produced
 * by {@link G1Parser}.
 *
 * @param <T> The return type of the visit operation. Use {@link Void} for
 * operations with no return type.
 */
public interface G1Visitor<T> extends ParseTreeVisitor<T> {
	/**
	 * Visit a parse tree produced by {@link G1Parser#r}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitR(G1Parser.RContext ctx);
}