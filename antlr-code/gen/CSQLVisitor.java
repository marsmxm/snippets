// Generated from /Users/mxm/learn/snippets/antlr-code/original/extras/CSQL.g4 by ANTLR 4.13.1

import java.util.Set;
import java.util.HashSet;

import org.antlr.v4.runtime.tree.ParseTreeVisitor;

/**
 * This interface defines a complete generic visitor for a parse tree produced
 * by {@link CSQL}.
 *
 * @param <T> The return type of the visit operation. Use {@link Void} for
 * operations with no return type.
 */
public interface CSQLVisitor<T> extends ParseTreeVisitor<T> {
	/**
	 * Visit a parse tree produced by {@link CSQL#prog}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitProg(CSQL.ProgContext ctx);
	/**
	 * Visit a parse tree produced by {@link CSQL#type}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitType(CSQL.TypeContext ctx);
	/**
	 * Visit a parse tree produced by {@link CSQL#var}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitVar(CSQL.VarContext ctx);
	/**
	 * Visit a parse tree produced by {@link CSQL#func}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitFunc(CSQL.FuncContext ctx);
	/**
	 * Visit a parse tree produced by {@link CSQL#args}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitArgs(CSQL.ArgsContext ctx);
	/**
	 * Visit a parse tree produced by {@link CSQL#arg}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitArg(CSQL.ArgContext ctx);
	/**
	 * Visit a parse tree produced by {@link CSQL#body}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitBody(CSQL.BodyContext ctx);
	/**
	 * Visit a parse tree produced by {@link CSQL#stat}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitStat(CSQL.StatContext ctx);
	/**
	 * Visit a parse tree produced by {@link CSQL#expr}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitExpr(CSQL.ExprContext ctx);
	/**
	 * Visit a parse tree produced by {@link CSQL#sqlselect}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitSqlselect(CSQL.SqlselectContext ctx);
	/**
	 * Visit a parse tree produced by {@link CSQL#condition}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitCondition(CSQL.ConditionContext ctx);
	/**
	 * Visit a parse tree produced by {@link CSQL#kselect}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitKselect(CSQL.KselectContext ctx);
	/**
	 * Visit a parse tree produced by {@link CSQL#kfrom}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitKfrom(CSQL.KfromContext ctx);
	/**
	 * Visit a parse tree produced by {@link CSQL#kwhere}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitKwhere(CSQL.KwhereContext ctx);
	/**
	 * Visit a parse tree produced by {@link CSQL#kand}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitKand(CSQL.KandContext ctx);
	/**
	 * Visit a parse tree produced by {@link CSQL#idlist}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitIdlist(CSQL.IdlistContext ctx);
	/**
	 * Visit a parse tree produced by {@link CSQL#sqlexpr}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitSqlexpr(CSQL.SqlexprContext ctx);
	/**
	 * Visit a parse tree produced by {@link CSQL#sqlstring}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitSqlstring(CSQL.SqlstringContext ctx);
	/**
	 * Visit a parse tree produced by {@link CSQL#sqleq}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitSqleq(CSQL.SqleqContext ctx);
	/**
	 * Visit a parse tree produced by {@link CSQL#sqlneq}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitSqlneq(CSQL.SqlneqContext ctx);
	/**
	 * Visit a parse tree produced by {@link CSQL#id}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitId(CSQL.IdContext ctx);
	/**
	 * Visit a parse tree produced by {@link CSQL#squote}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitSquote(CSQL.SquoteContext ctx);
	/**
	 * Visit a parse tree produced by {@link CSQL#lc}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitLc(CSQL.LcContext ctx);
	/**
	 * Visit a parse tree produced by {@link CSQL#rc}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitRc(CSQL.RcContext ctx);
	/**
	 * Visit a parse tree produced by {@link CSQL#lp}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitLp(CSQL.LpContext ctx);
	/**
	 * Visit a parse tree produced by {@link CSQL#rp}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitRp(CSQL.RpContext ctx);
	/**
	 * Visit a parse tree produced by {@link CSQL#star}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitStar(CSQL.StarContext ctx);
	/**
	 * Visit a parse tree produced by {@link CSQL#plus}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitPlus(CSQL.PlusContext ctx);
	/**
	 * Visit a parse tree produced by {@link CSQL#ass}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitAss(CSQL.AssContext ctx);
	/**
	 * Visit a parse tree produced by {@link CSQL#eq}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitEq(CSQL.EqContext ctx);
	/**
	 * Visit a parse tree produced by {@link CSQL#neq}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitNeq(CSQL.NeqContext ctx);
	/**
	 * Visit a parse tree produced by {@link CSQL#colon}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitColon(CSQL.ColonContext ctx);
	/**
	 * Visit a parse tree produced by {@link CSQL#semi}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitSemi(CSQL.SemiContext ctx);
	/**
	 * Visit a parse tree produced by {@link CSQL#kint}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitKint(CSQL.KintContext ctx);
	/**
	 * Visit a parse tree produced by {@link CSQL#kvoid}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitKvoid(CSQL.KvoidContext ctx);
	/**
	 * Visit a parse tree produced by {@link CSQL#kreturn}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitKreturn(CSQL.KreturnContext ctx);
	/**
	 * Visit a parse tree produced by {@link CSQL#cchar}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitCchar(CSQL.CcharContext ctx);
	/**
	 * Visit a parse tree produced by {@link CSQL#integer}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitInteger(CSQL.IntegerContext ctx);
	/**
	 * Visit a parse tree produced by {@link CSQL#digit}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDigit(CSQL.DigitContext ctx);
	/**
	 * Visit a parse tree produced by {@link CSQL#letter}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitLetter(CSQL.LetterContext ctx);
	/**
	 * Visit a parse tree produced by {@link CSQL#ws}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitWs(CSQL.WsContext ctx);
	/**
	 * Visit a parse tree produced by {@link CSQL#comment}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitComment(CSQL.CommentContext ctx);
}