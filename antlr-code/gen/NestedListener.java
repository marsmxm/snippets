// Generated from /Users/mxm/learn/snippets/antlr-code/original/reference/Nested.g4 by ANTLR 4.13.1
import org.antlr.v4.runtime.tree.ParseTreeListener;

/**
 * This interface defines a complete listener for a parse tree produced by
 * {@link NestedParser}.
 */
public interface NestedListener extends ParseTreeListener {
	/**
	 * Enter a parse tree produced by {@link NestedParser#s}.
	 * @param ctx the parse tree
	 */
	void enterS(NestedParser.SContext ctx);
	/**
	 * Exit a parse tree produced by {@link NestedParser#s}.
	 * @param ctx the parse tree
	 */
	void exitS(NestedParser.SContext ctx);
	/**
	 * Enter a parse tree produced by {@link NestedParser#r}.
	 * @param ctx the parse tree
	 */
	void enterR(NestedParser.RContext ctx);
	/**
	 * Exit a parse tree produced by {@link NestedParser#r}.
	 * @param ctx the parse tree
	 */
	void exitR(NestedParser.RContext ctx);
}