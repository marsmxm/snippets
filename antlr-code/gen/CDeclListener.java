// Generated from /Users/mxm/learn/snippets/antlr-code/original/extras/CDecl.g4 by ANTLR 4.13.1
import org.antlr.v4.runtime.tree.ParseTreeListener;

/**
 * This interface defines a complete listener for a parse tree produced by
 * {@link CDeclParser}.
 */
public interface CDeclListener extends ParseTreeListener {
	/**
	 * Enter a parse tree produced by {@link CDeclParser#decl}.
	 * @param ctx the parse tree
	 */
	void enterDecl(CDeclParser.DeclContext ctx);
	/**
	 * Exit a parse tree produced by {@link CDeclParser#decl}.
	 * @param ctx the parse tree
	 */
	void exitDecl(CDeclParser.DeclContext ctx);
	/**
	 * Enter a parse tree produced by {@link CDeclParser#declarator}.
	 * @param ctx the parse tree
	 */
	void enterDeclarator(CDeclParser.DeclaratorContext ctx);
	/**
	 * Exit a parse tree produced by {@link CDeclParser#declarator}.
	 * @param ctx the parse tree
	 */
	void exitDeclarator(CDeclParser.DeclaratorContext ctx);
	/**
	 * Enter a parse tree produced by {@link CDeclParser#expr}.
	 * @param ctx the parse tree
	 */
	void enterExpr(CDeclParser.ExprContext ctx);
	/**
	 * Exit a parse tree produced by {@link CDeclParser#expr}.
	 * @param ctx the parse tree
	 */
	void exitExpr(CDeclParser.ExprContext ctx);
}