// Generated from /Users/mxm/learn/snippets/antlr-code/original/reference/DynScope.g4 by ANTLR 4.13.1
import org.antlr.v4.runtime.tree.ParseTreeVisitor;

/**
 * This interface defines a complete generic visitor for a parse tree produced
 * by {@link DynScopeParser}.
 *
 * @param <T> The return type of the visit operation. Use {@link Void} for
 * operations with no return type.
 */
public interface DynScopeVisitor<T> extends ParseTreeVisitor<T> {
	/**
	 * Visit a parse tree produced by {@link DynScopeParser#prog}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitProg(DynScopeParser.ProgContext ctx);
	/**
	 * Visit a parse tree produced by {@link DynScopeParser#block}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitBlock(DynScopeParser.BlockContext ctx);
	/**
	 * Visit a parse tree produced by {@link DynScopeParser#decl}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDecl(DynScopeParser.DeclContext ctx);
	/**
	 * Visit a parse tree produced by {@link DynScopeParser#stat}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitStat(DynScopeParser.StatContext ctx);
}