// Generated from /Users/mxm/learn/snippets/antlr-code/original/lexmagic/PredKeyword.g4 by ANTLR 4.13.1
import org.antlr.v4.runtime.tree.ParseTreeVisitor;

/**
 * This interface defines a complete generic visitor for a parse tree produced
 * by {@link PredKeywordParser}.
 *
 * @param <T> The return type of the visit operation. Use {@link Void} for
 * operations with no return type.
 */
public interface PredKeywordVisitor<T> extends ParseTreeVisitor<T> {
	/**
	 * Visit a parse tree produced by {@link PredKeywordParser#prog}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitProg(PredKeywordParser.ProgContext ctx);
	/**
	 * Visit a parse tree produced by {@link PredKeywordParser#stat}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitStat(PredKeywordParser.StatContext ctx);
	/**
	 * Visit a parse tree produced by {@link PredKeywordParser#expr}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitExpr(PredKeywordParser.ExprContext ctx);
	/**
	 * Visit a parse tree produced by {@link PredKeywordParser#keyIF}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitKeyIF(PredKeywordParser.KeyIFContext ctx);
	/**
	 * Visit a parse tree produced by {@link PredKeywordParser#keyCALL}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitKeyCALL(PredKeywordParser.KeyCALLContext ctx);
}