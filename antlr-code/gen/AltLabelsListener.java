// Generated from /Users/mxm/learn/snippets/antlr-code/original/reference/AltLabels.g4 by ANTLR 4.13.1
import org.antlr.v4.runtime.tree.ParseTreeListener;

/**
 * This interface defines a complete listener for a parse tree produced by
 * {@link AltLabelsParser}.
 */
public interface AltLabelsListener extends ParseTreeListener {
	/**
	 * Enter a parse tree produced by the {@code Return}
	 * labeled alternative in {@link AltLabelsParser#stat}.
	 * @param ctx the parse tree
	 */
	void enterReturn(AltLabelsParser.ReturnContext ctx);
	/**
	 * Exit a parse tree produced by the {@code Return}
	 * labeled alternative in {@link AltLabelsParser#stat}.
	 * @param ctx the parse tree
	 */
	void exitReturn(AltLabelsParser.ReturnContext ctx);
	/**
	 * Enter a parse tree produced by the {@code Break}
	 * labeled alternative in {@link AltLabelsParser#stat}.
	 * @param ctx the parse tree
	 */
	void enterBreak(AltLabelsParser.BreakContext ctx);
	/**
	 * Exit a parse tree produced by the {@code Break}
	 * labeled alternative in {@link AltLabelsParser#stat}.
	 * @param ctx the parse tree
	 */
	void exitBreak(AltLabelsParser.BreakContext ctx);
	/**
	 * Enter a parse tree produced by the {@code Add}
	 * labeled alternative in {@link AltLabelsParser#e}.
	 * @param ctx the parse tree
	 */
	void enterAdd(AltLabelsParser.AddContext ctx);
	/**
	 * Exit a parse tree produced by the {@code Add}
	 * labeled alternative in {@link AltLabelsParser#e}.
	 * @param ctx the parse tree
	 */
	void exitAdd(AltLabelsParser.AddContext ctx);
	/**
	 * Enter a parse tree produced by the {@code Mult}
	 * labeled alternative in {@link AltLabelsParser#e}.
	 * @param ctx the parse tree
	 */
	void enterMult(AltLabelsParser.MultContext ctx);
	/**
	 * Exit a parse tree produced by the {@code Mult}
	 * labeled alternative in {@link AltLabelsParser#e}.
	 * @param ctx the parse tree
	 */
	void exitMult(AltLabelsParser.MultContext ctx);
	/**
	 * Enter a parse tree produced by the {@code Int}
	 * labeled alternative in {@link AltLabelsParser#e}.
	 * @param ctx the parse tree
	 */
	void enterInt(AltLabelsParser.IntContext ctx);
	/**
	 * Exit a parse tree produced by the {@code Int}
	 * labeled alternative in {@link AltLabelsParser#e}.
	 * @param ctx the parse tree
	 */
	void exitInt(AltLabelsParser.IntContext ctx);
}