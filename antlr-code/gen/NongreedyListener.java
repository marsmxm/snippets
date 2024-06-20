// Generated from /Users/mxm/learn/snippets/antlr-code/original/reference/Nongreedy.g4 by ANTLR 4.13.1
import org.antlr.v4.runtime.tree.ParseTreeListener;

/**
 * This interface defines a complete listener for a parse tree produced by
 * {@link NongreedyParser}.
 */
public interface NongreedyListener extends ParseTreeListener {
	/**
	 * Enter a parse tree produced by {@link NongreedyParser#s}.
	 * @param ctx the parse tree
	 */
	void enterS(NongreedyParser.SContext ctx);
	/**
	 * Exit a parse tree produced by {@link NongreedyParser#s}.
	 * @param ctx the parse tree
	 */
	void exitS(NongreedyParser.SContext ctx);
}