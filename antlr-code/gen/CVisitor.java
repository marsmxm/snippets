// Generated from /Users/mxm/learn/snippets/antlr-code/original/extras/C.g4 by ANTLR 4.13.1
import org.antlr.v4.runtime.tree.ParseTreeVisitor;

/**
 * This interface defines a complete generic visitor for a parse tree produced
 * by {@link CParser}.
 *
 * @param <T> The return type of the visit operation. Use {@link Void} for
 * operations with no return type.
 */
public interface CVisitor<T> extends ParseTreeVisitor<T> {
	/**
	 * Visit a parse tree produced by {@link CParser#file}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitFile(CParser.FileContext ctx);
	/**
	 * Visit a parse tree produced by {@link CParser#func}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitFunc(CParser.FuncContext ctx);
	/**
	 * Visit a parse tree produced by {@link CParser#var}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitVar(CParser.VarContext ctx);
	/**
	 * Visit a parse tree produced by {@link CParser#type}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitType(CParser.TypeContext ctx);
}