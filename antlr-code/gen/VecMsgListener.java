// Generated from /Users/mxm/learn/snippets/antlr-code/original/errors/VecMsg.g4 by ANTLR 4.13.1
import org.antlr.v4.runtime.tree.ParseTreeListener;

/**
 * This interface defines a complete listener for a parse tree produced by
 * {@link VecMsgParser}.
 */
public interface VecMsgListener extends ParseTreeListener {
	/**
	 * Enter a parse tree produced by {@link VecMsgParser#vec4}.
	 * @param ctx the parse tree
	 */
	void enterVec4(VecMsgParser.Vec4Context ctx);
	/**
	 * Exit a parse tree produced by {@link VecMsgParser#vec4}.
	 * @param ctx the parse tree
	 */
	void exitVec4(VecMsgParser.Vec4Context ctx);
	/**
	 * Enter a parse tree produced by {@link VecMsgParser#ints}.
	 * @param ctx the parse tree
	 */
	void enterInts(VecMsgParser.IntsContext ctx);
	/**
	 * Exit a parse tree produced by {@link VecMsgParser#ints}.
	 * @param ctx the parse tree
	 */
	void exitInts(VecMsgParser.IntsContext ctx);
}