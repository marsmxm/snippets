// Generated from /Users/mxm/learn/snippets/antlr-code/original/reference/AltLabels.g4 by ANTLR 4.13.1
import org.antlr.v4.runtime.tree.ParseTreeVisitor;

/**
 * This interface defines a complete generic visitor for a parse tree produced
 * by {@link AltLabelsParser}.
 *
 * @param <T> The return type of the visit operation. Use {@link Void} for
 * operations with no return type.
 */
public interface AltLabelsVisitor<T> extends ParseTreeVisitor<T> {
	/**
	 * Visit a parse tree produced by the {@code Return}
	 * labeled alternative in {@link AltLabelsParser#stat}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitReturn(AltLabelsParser.ReturnContext ctx);
	/**
	 * Visit a parse tree produced by the {@code Break}
	 * labeled alternative in {@link AltLabelsParser#stat}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitBreak(AltLabelsParser.BreakContext ctx);
	/**
	 * Visit a parse tree produced by the {@code Add}
	 * labeled alternative in {@link AltLabelsParser#e}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitAdd(AltLabelsParser.AddContext ctx);
	/**
	 * Visit a parse tree produced by the {@code Mult}
	 * labeled alternative in {@link AltLabelsParser#e}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitMult(AltLabelsParser.MultContext ctx);
	/**
	 * Visit a parse tree produced by the {@code Int}
	 * labeled alternative in {@link AltLabelsParser#e}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitInt(AltLabelsParser.IntContext ctx);
}