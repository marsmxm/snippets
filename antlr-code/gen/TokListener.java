// Generated from /Users/mxm/learn/snippets/antlr-code/original/reference/Tok.g4 by ANTLR 4.13.1
import org.antlr.v4.runtime.tree.ParseTreeListener;

/**
 * This interface defines a complete listener for a parse tree produced by
 * {@link TokParser}.
 */
public interface TokListener extends ParseTreeListener {
	/**
	 * Enter a parse tree produced by {@link TokParser#a}.
	 * @param ctx the parse tree
	 */
	void enterA(TokParser.AContext ctx);
	/**
	 * Exit a parse tree produced by {@link TokParser#a}.
	 * @param ctx the parse tree
	 */
	void exitA(TokParser.AContext ctx);
}