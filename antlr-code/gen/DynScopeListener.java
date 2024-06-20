// Generated from /Users/mxm/learn/snippets/antlr-code/original/reference/DynScope.g4 by ANTLR 4.13.1
import org.antlr.v4.runtime.tree.ParseTreeListener;

/**
 * This interface defines a complete listener for a parse tree produced by
 * {@link DynScopeParser}.
 */
public interface DynScopeListener extends ParseTreeListener {
	/**
	 * Enter a parse tree produced by {@link DynScopeParser#prog}.
	 * @param ctx the parse tree
	 */
	void enterProg(DynScopeParser.ProgContext ctx);
	/**
	 * Exit a parse tree produced by {@link DynScopeParser#prog}.
	 * @param ctx the parse tree
	 */
	void exitProg(DynScopeParser.ProgContext ctx);
	/**
	 * Enter a parse tree produced by {@link DynScopeParser#block}.
	 * @param ctx the parse tree
	 */
	void enterBlock(DynScopeParser.BlockContext ctx);
	/**
	 * Exit a parse tree produced by {@link DynScopeParser#block}.
	 * @param ctx the parse tree
	 */
	void exitBlock(DynScopeParser.BlockContext ctx);
	/**
	 * Enter a parse tree produced by {@link DynScopeParser#decl}.
	 * @param ctx the parse tree
	 */
	void enterDecl(DynScopeParser.DeclContext ctx);
	/**
	 * Exit a parse tree produced by {@link DynScopeParser#decl}.
	 * @param ctx the parse tree
	 */
	void exitDecl(DynScopeParser.DeclContext ctx);
	/**
	 * Enter a parse tree produced by {@link DynScopeParser#stat}.
	 * @param ctx the parse tree
	 */
	void enterStat(DynScopeParser.StatContext ctx);
	/**
	 * Exit a parse tree produced by {@link DynScopeParser#stat}.
	 * @param ctx the parse tree
	 */
	void exitStat(DynScopeParser.StatContext ctx);
}