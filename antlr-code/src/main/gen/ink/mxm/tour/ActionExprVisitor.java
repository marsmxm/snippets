// Generated from /Users/mxm/learn/snippets/antlr-code/src/main/java/ink/mxm/tour/ActionExpr.g4 by ANTLR 4.12.0
package ink.mxm.tour;
import org.antlr.v4.runtime.tree.ParseTreeVisitor;

/**
 * This interface defines a complete generic visitor for a parse tree produced
 * by {@link ActionExprParser}.
 *
 * @param <T> The return type of the visit operation. Use {@link Void} for
 * operations with no return type.
 */
public interface ActionExprVisitor<T> extends ParseTreeVisitor<T> {
	/**
	 * Visit a parse tree produced by {@link ActionExprParser#prog}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitProg(ActionExprParser.ProgContext ctx);
	/**
	 * Visit a parse tree produced by {@link ActionExprParser#stat}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitStat(ActionExprParser.StatContext ctx);
	/**
	 * Visit a parse tree produced by {@link ActionExprParser#expr}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitExpr(ActionExprParser.ExprContext ctx);
}