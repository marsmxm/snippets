// Generated from /Users/mxm/learn/snippets/antlr-code/original/reference/A.g4 by ANTLR 4.13.1
import org.antlr.v4.runtime.tree.ParseTreeVisitor;

/**
 * This interface defines a complete generic visitor for a parse tree produced
 * by {@link AParser}.
 *
 * @param <T> The return type of the visit operation. Use {@link Void} for
 * operations with no return type.
 */
public interface AVisitor<T> extends ParseTreeVisitor<T> {
	/**
	 * Visit a parse tree produced by the {@code Return}
	 * labeled alternative in {@link AParser#stat}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitReturn(AParser.ReturnContext ctx);
	/**
	 * Visit a parse tree produced by the {@code Break}
	 * labeled alternative in {@link AParser#stat}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitBreak(AParser.BreakContext ctx);
	/**
	 * Visit a parse tree produced by the {@code Add}
	 * labeled alternative in {@link AParser#e}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitAdd(AParser.AddContext ctx);
	/**
	 * Visit a parse tree produced by the {@code Mult}
	 * labeled alternative in {@link AParser#e}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitMult(AParser.MultContext ctx);
	/**
	 * Visit a parse tree produced by the {@code Int}
	 * labeled alternative in {@link AParser#e}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitInt(AParser.IntContext ctx);
}