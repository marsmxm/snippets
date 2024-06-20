// Generated from /Users/mxm/learn/snippets/antlr-code/original/lexmagic/PredKeyword.g4 by ANTLR 4.13.1
import org.antlr.v4.runtime.tree.ParseTreeListener;

/**
 * This interface defines a complete listener for a parse tree produced by
 * {@link PredKeywordParser}.
 */
public interface PredKeywordListener extends ParseTreeListener {
	/**
	 * Enter a parse tree produced by {@link PredKeywordParser#prog}.
	 * @param ctx the parse tree
	 */
	void enterProg(PredKeywordParser.ProgContext ctx);
	/**
	 * Exit a parse tree produced by {@link PredKeywordParser#prog}.
	 * @param ctx the parse tree
	 */
	void exitProg(PredKeywordParser.ProgContext ctx);
	/**
	 * Enter a parse tree produced by {@link PredKeywordParser#stat}.
	 * @param ctx the parse tree
	 */
	void enterStat(PredKeywordParser.StatContext ctx);
	/**
	 * Exit a parse tree produced by {@link PredKeywordParser#stat}.
	 * @param ctx the parse tree
	 */
	void exitStat(PredKeywordParser.StatContext ctx);
	/**
	 * Enter a parse tree produced by {@link PredKeywordParser#expr}.
	 * @param ctx the parse tree
	 */
	void enterExpr(PredKeywordParser.ExprContext ctx);
	/**
	 * Exit a parse tree produced by {@link PredKeywordParser#expr}.
	 * @param ctx the parse tree
	 */
	void exitExpr(PredKeywordParser.ExprContext ctx);
	/**
	 * Enter a parse tree produced by {@link PredKeywordParser#keyIF}.
	 * @param ctx the parse tree
	 */
	void enterKeyIF(PredKeywordParser.KeyIFContext ctx);
	/**
	 * Exit a parse tree produced by {@link PredKeywordParser#keyIF}.
	 * @param ctx the parse tree
	 */
	void exitKeyIF(PredKeywordParser.KeyIFContext ctx);
	/**
	 * Enter a parse tree produced by {@link PredKeywordParser#keyCALL}.
	 * @param ctx the parse tree
	 */
	void enterKeyCALL(PredKeywordParser.KeyCALLContext ctx);
	/**
	 * Exit a parse tree produced by {@link PredKeywordParser#keyCALL}.
	 * @param ctx the parse tree
	 */
	void exitKeyCALL(PredKeywordParser.KeyCALLContext ctx);
}