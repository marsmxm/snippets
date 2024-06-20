// Generated from /Users/mxm/learn/snippets/antlr-code/original/lexmagic/SimplePy.g4 by ANTLR 4.13.1
import org.antlr.v4.runtime.tree.ParseTreeVisitor;

/**
 * This interface defines a complete generic visitor for a parse tree produced
 * by {@link SimplePyParser}.
 *
 * @param <T> The return type of the visit operation. Use {@link Void} for
 * operations with no return type.
 */
public interface SimplePyVisitor<T> extends ParseTreeVisitor<T> {
	/**
	 * Visit a parse tree produced by {@link SimplePyParser#file}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitFile(SimplePyParser.FileContext ctx);
	/**
	 * Visit a parse tree produced by {@link SimplePyParser#stat}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitStat(SimplePyParser.StatContext ctx);
	/**
	 * Visit a parse tree produced by {@link SimplePyParser#assign}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitAssign(SimplePyParser.AssignContext ctx);
	/**
	 * Visit a parse tree produced by {@link SimplePyParser#expr}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitExpr(SimplePyParser.ExprContext ctx);
	/**
	 * Visit a parse tree produced by {@link SimplePyParser#call}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitCall(SimplePyParser.CallContext ctx);
	/**
	 * Visit a parse tree produced by {@link SimplePyParser#list}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitList(SimplePyParser.ListContext ctx);
}