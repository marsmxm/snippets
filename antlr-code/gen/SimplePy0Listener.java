// Generated from /Users/mxm/learn/snippets/antlr-code/original/lexmagic/SimplePy0.g4 by ANTLR 4.13.1
import org.antlr.v4.runtime.tree.ParseTreeListener;

/**
 * This interface defines a complete listener for a parse tree produced by
 * {@link SimplePy0Parser}.
 */
public interface SimplePy0Listener extends ParseTreeListener {
	/**
	 * Enter a parse tree produced by {@link SimplePy0Parser#file}.
	 * @param ctx the parse tree
	 */
	void enterFile(SimplePy0Parser.FileContext ctx);
	/**
	 * Exit a parse tree produced by {@link SimplePy0Parser#file}.
	 * @param ctx the parse tree
	 */
	void exitFile(SimplePy0Parser.FileContext ctx);
	/**
	 * Enter a parse tree produced by {@link SimplePy0Parser#stat}.
	 * @param ctx the parse tree
	 */
	void enterStat(SimplePy0Parser.StatContext ctx);
	/**
	 * Exit a parse tree produced by {@link SimplePy0Parser#stat}.
	 * @param ctx the parse tree
	 */
	void exitStat(SimplePy0Parser.StatContext ctx);
	/**
	 * Enter a parse tree produced by {@link SimplePy0Parser#assign}.
	 * @param ctx the parse tree
	 */
	void enterAssign(SimplePy0Parser.AssignContext ctx);
	/**
	 * Exit a parse tree produced by {@link SimplePy0Parser#assign}.
	 * @param ctx the parse tree
	 */
	void exitAssign(SimplePy0Parser.AssignContext ctx);
	/**
	 * Enter a parse tree produced by {@link SimplePy0Parser#expr}.
	 * @param ctx the parse tree
	 */
	void enterExpr(SimplePy0Parser.ExprContext ctx);
	/**
	 * Exit a parse tree produced by {@link SimplePy0Parser#expr}.
	 * @param ctx the parse tree
	 */
	void exitExpr(SimplePy0Parser.ExprContext ctx);
	/**
	 * Enter a parse tree produced by {@link SimplePy0Parser#call}.
	 * @param ctx the parse tree
	 */
	void enterCall(SimplePy0Parser.CallContext ctx);
	/**
	 * Exit a parse tree produced by {@link SimplePy0Parser#call}.
	 * @param ctx the parse tree
	 */
	void exitCall(SimplePy0Parser.CallContext ctx);
	/**
	 * Enter a parse tree produced by {@link SimplePy0Parser#list}.
	 * @param ctx the parse tree
	 */
	void enterList(SimplePy0Parser.ListContext ctx);
	/**
	 * Exit a parse tree produced by {@link SimplePy0Parser#list}.
	 * @param ctx the parse tree
	 */
	void exitList(SimplePy0Parser.ListContext ctx);
}