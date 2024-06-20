// Generated from /Users/mxm/learn/snippets/antlr-code/original/extras/CExpr.g4 by ANTLR 4.13.1
import org.antlr.v4.runtime.tree.ParseTreeListener;

/**
 * This interface defines a complete listener for a parse tree produced by
 * {@link CExprParser}.
 */
public interface CExprListener extends ParseTreeListener {
	/**
	 * Enter a parse tree produced by {@link CExprParser#stat}.
	 * @param ctx the parse tree
	 */
	void enterStat(CExprParser.StatContext ctx);
	/**
	 * Exit a parse tree produced by {@link CExprParser#stat}.
	 * @param ctx the parse tree
	 */
	void exitStat(CExprParser.StatContext ctx);
	/**
	 * Enter a parse tree produced by {@link CExprParser#expr}.
	 * @param ctx the parse tree
	 */
	void enterExpr(CExprParser.ExprContext ctx);
	/**
	 * Exit a parse tree produced by {@link CExprParser#expr}.
	 * @param ctx the parse tree
	 */
	void exitExpr(CExprParser.ExprContext ctx);
}