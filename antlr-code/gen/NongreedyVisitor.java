// Generated from /Users/mxm/learn/snippets/antlr-code/original/reference/Nongreedy.g4 by ANTLR 4.13.1
import org.antlr.v4.runtime.tree.ParseTreeVisitor;

/**
 * This interface defines a complete generic visitor for a parse tree produced
 * by {@link NongreedyParser}.
 *
 * @param <T> The return type of the visit operation. Use {@link Void} for
 * operations with no return type.
 */
public interface NongreedyVisitor<T> extends ParseTreeVisitor<T> {
	/**
	 * Visit a parse tree produced by {@link NongreedyParser#s}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitS(NongreedyParser.SContext ctx);
}