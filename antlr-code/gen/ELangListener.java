// Generated from /Users/mxm/learn/snippets/antlr-code/original/reference/ELang.g4 by ANTLR 4.13.1
import org.antlr.v4.runtime.tree.ParseTreeListener;

/**
 * This interface defines a complete listener for a parse tree produced by
 * {@link ELangParser}.
 */
public interface ELangListener extends ParseTreeListener {
	/**
	 * Enter a parse tree produced by {@link ELangParser#stat}.
	 * @param ctx the parse tree
	 */
	void enterStat(ELangParser.StatContext ctx);
	/**
	 * Exit a parse tree produced by {@link ELangParser#stat}.
	 * @param ctx the parse tree
	 */
	void exitStat(ELangParser.StatContext ctx);
	/**
	 * Enter a parse tree produced by {@link ELangParser#expr}.
	 * @param ctx the parse tree
	 */
	void enterExpr(ELangParser.ExprContext ctx);
	/**
	 * Exit a parse tree produced by {@link ELangParser#expr}.
	 * @param ctx the parse tree
	 */
	void exitExpr(ELangParser.ExprContext ctx);
}