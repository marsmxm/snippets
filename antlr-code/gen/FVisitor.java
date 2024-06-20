// Generated from /Users/mxm/learn/snippets/antlr-code/original/errors/F.g4 by ANTLR 4.13.1
import org.antlr.v4.runtime.tree.ParseTreeVisitor;

/**
 * This interface defines a complete generic visitor for a parse tree produced
 * by {@link FParser}.
 *
 * @param <T> The return type of the visit operation. Use {@link Void} for
 * operations with no return type.
 */
public interface FVisitor<T> extends ParseTreeVisitor<T> {
	/**
	 * Visit a parse tree produced by {@link FParser#group}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitGroup(FParser.GroupContext ctx);
	/**
	 * Visit a parse tree produced by {@link FParser#expr}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitExpr(FParser.ExprContext ctx);
	/**
	 * Visit a parse tree produced by {@link FParser#atom}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitAtom(FParser.AtomContext ctx);
}