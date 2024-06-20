// Generated from /Users/mxm/learn/snippets/antlr-code/original/extras/C.g4 by ANTLR 4.13.1
import org.antlr.v4.runtime.tree.ParseTreeListener;

/**
 * This interface defines a complete listener for a parse tree produced by
 * {@link CParser}.
 */
public interface CListener extends ParseTreeListener {
	/**
	 * Enter a parse tree produced by {@link CParser#file}.
	 * @param ctx the parse tree
	 */
	void enterFile(CParser.FileContext ctx);
	/**
	 * Exit a parse tree produced by {@link CParser#file}.
	 * @param ctx the parse tree
	 */
	void exitFile(CParser.FileContext ctx);
	/**
	 * Enter a parse tree produced by {@link CParser#func}.
	 * @param ctx the parse tree
	 */
	void enterFunc(CParser.FuncContext ctx);
	/**
	 * Exit a parse tree produced by {@link CParser#func}.
	 * @param ctx the parse tree
	 */
	void exitFunc(CParser.FuncContext ctx);
	/**
	 * Enter a parse tree produced by {@link CParser#var}.
	 * @param ctx the parse tree
	 */
	void enterVar(CParser.VarContext ctx);
	/**
	 * Exit a parse tree produced by {@link CParser#var}.
	 * @param ctx the parse tree
	 */
	void exitVar(CParser.VarContext ctx);
	/**
	 * Enter a parse tree produced by {@link CParser#type}.
	 * @param ctx the parse tree
	 */
	void enterType(CParser.TypeContext ctx);
	/**
	 * Exit a parse tree produced by {@link CParser#type}.
	 * @param ctx the parse tree
	 */
	void exitType(CParser.TypeContext ctx);
}