// Generated from /Users/mxm/learn/snippets/antlr-code/original/errors/Call.g4 by ANTLR 4.13.1
import org.antlr.v4.runtime.tree.ParseTreeListener;

/**
 * This interface defines a complete listener for a parse tree produced by
 * {@link CallParser}.
 */
public interface CallListener extends ParseTreeListener {
	/**
	 * Enter a parse tree produced by {@link CallParser#stat}.
	 * @param ctx the parse tree
	 */
	void enterStat(CallParser.StatContext ctx);
	/**
	 * Exit a parse tree produced by {@link CallParser#stat}.
	 * @param ctx the parse tree
	 */
	void exitStat(CallParser.StatContext ctx);
	/**
	 * Enter a parse tree produced by {@link CallParser#fcall}.
	 * @param ctx the parse tree
	 */
	void enterFcall(CallParser.FcallContext ctx);
	/**
	 * Exit a parse tree produced by {@link CallParser#fcall}.
	 * @param ctx the parse tree
	 */
	void exitFcall(CallParser.FcallContext ctx);
	/**
	 * Enter a parse tree produced by {@link CallParser#expr}.
	 * @param ctx the parse tree
	 */
	void enterExpr(CallParser.ExprContext ctx);
	/**
	 * Exit a parse tree produced by {@link CallParser#expr}.
	 * @param ctx the parse tree
	 */
	void exitExpr(CallParser.ExprContext ctx);
}