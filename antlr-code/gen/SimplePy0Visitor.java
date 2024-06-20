// Generated from /Users/mxm/learn/snippets/antlr-code/original/lexmagic/SimplePy0.g4 by ANTLR 4.13.1
import org.antlr.v4.runtime.tree.ParseTreeVisitor;

/**
 * This interface defines a complete generic visitor for a parse tree produced
 * by {@link SimplePy0Parser}.
 *
 * @param <T> The return type of the visit operation. Use {@link Void} for
 * operations with no return type.
 */
public interface SimplePy0Visitor<T> extends ParseTreeVisitor<T> {
	/**
	 * Visit a parse tree produced by {@link SimplePy0Parser#file}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitFile(SimplePy0Parser.FileContext ctx);
	/**
	 * Visit a parse tree produced by {@link SimplePy0Parser#stat}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitStat(SimplePy0Parser.StatContext ctx);
	/**
	 * Visit a parse tree produced by {@link SimplePy0Parser#assign}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitAssign(SimplePy0Parser.AssignContext ctx);
	/**
	 * Visit a parse tree produced by {@link SimplePy0Parser#expr}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitExpr(SimplePy0Parser.ExprContext ctx);
	/**
	 * Visit a parse tree produced by {@link SimplePy0Parser#call}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitCall(SimplePy0Parser.CallContext ctx);
	/**
	 * Visit a parse tree produced by {@link SimplePy0Parser#list}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitList(SimplePy0Parser.ListContext ctx);
}