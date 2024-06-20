// Generated from /Users/mxm/learn/snippets/antlr-code/original/reference/Hi.g4 by ANTLR 4.13.1
import org.antlr.v4.runtime.tree.ParseTreeListener;

/**
 * This interface defines a complete listener for a parse tree produced by
 * {@link HiParser}.
 */
public interface HiListener extends ParseTreeListener {
	/**
	 * Enter a parse tree produced by {@link HiParser#a}.
	 * @param ctx the parse tree
	 */
	void enterA(HiParser.AContext ctx);
	/**
	 * Exit a parse tree produced by {@link HiParser#a}.
	 * @param ctx the parse tree
	 */
	void exitA(HiParser.AContext ctx);
}