// Generated from /Users/mxm/learn/snippets/antlr-code/original/reference/A.g4 by ANTLR 4.13.1
import org.antlr.v4.runtime.tree.ParseTreeListener;

/**
 * This interface defines a complete listener for a parse tree produced by
 * {@link AParser}.
 */
public interface AListener extends ParseTreeListener {
	/**
	 * Enter a parse tree produced by the {@code Return}
	 * labeled alternative in {@link AParser#stat}.
	 * @param ctx the parse tree
	 */
	void enterReturn(AParser.ReturnContext ctx);
	/**
	 * Exit a parse tree produced by the {@code Return}
	 * labeled alternative in {@link AParser#stat}.
	 * @param ctx the parse tree
	 */
	void exitReturn(AParser.ReturnContext ctx);
	/**
	 * Enter a parse tree produced by the {@code Break}
	 * labeled alternative in {@link AParser#stat}.
	 * @param ctx the parse tree
	 */
	void enterBreak(AParser.BreakContext ctx);
	/**
	 * Exit a parse tree produced by the {@code Break}
	 * labeled alternative in {@link AParser#stat}.
	 * @param ctx the parse tree
	 */
	void exitBreak(AParser.BreakContext ctx);
	/**
	 * Enter a parse tree produced by the {@code Add}
	 * labeled alternative in {@link AParser#e}.
	 * @param ctx the parse tree
	 */
	void enterAdd(AParser.AddContext ctx);
	/**
	 * Exit a parse tree produced by the {@code Add}
	 * labeled alternative in {@link AParser#e}.
	 * @param ctx the parse tree
	 */
	void exitAdd(AParser.AddContext ctx);
	/**
	 * Enter a parse tree produced by the {@code Mult}
	 * labeled alternative in {@link AParser#e}.
	 * @param ctx the parse tree
	 */
	void enterMult(AParser.MultContext ctx);
	/**
	 * Exit a parse tree produced by the {@code Mult}
	 * labeled alternative in {@link AParser#e}.
	 * @param ctx the parse tree
	 */
	void exitMult(AParser.MultContext ctx);
	/**
	 * Enter a parse tree produced by the {@code Int}
	 * labeled alternative in {@link AParser#e}.
	 * @param ctx the parse tree
	 */
	void enterInt(AParser.IntContext ctx);
	/**
	 * Exit a parse tree produced by the {@code Int}
	 * labeled alternative in {@link AParser#e}.
	 * @param ctx the parse tree
	 */
	void exitInt(AParser.IntContext ctx);
}