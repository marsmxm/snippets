// Generated from /Users/mxm/learn/snippets/antlr-code/original/extras/CSQL.g4 by ANTLR 4.13.1

import java.util.Set;
import java.util.HashSet;

import org.antlr.v4.runtime.tree.ParseTreeListener;

/**
 * This interface defines a complete listener for a parse tree produced by
 * {@link CSQL}.
 */
public interface CSQLListener extends ParseTreeListener {
	/**
	 * Enter a parse tree produced by {@link CSQL#prog}.
	 * @param ctx the parse tree
	 */
	void enterProg(CSQL.ProgContext ctx);
	/**
	 * Exit a parse tree produced by {@link CSQL#prog}.
	 * @param ctx the parse tree
	 */
	void exitProg(CSQL.ProgContext ctx);
	/**
	 * Enter a parse tree produced by {@link CSQL#type}.
	 * @param ctx the parse tree
	 */
	void enterType(CSQL.TypeContext ctx);
	/**
	 * Exit a parse tree produced by {@link CSQL#type}.
	 * @param ctx the parse tree
	 */
	void exitType(CSQL.TypeContext ctx);
	/**
	 * Enter a parse tree produced by {@link CSQL#var}.
	 * @param ctx the parse tree
	 */
	void enterVar(CSQL.VarContext ctx);
	/**
	 * Exit a parse tree produced by {@link CSQL#var}.
	 * @param ctx the parse tree
	 */
	void exitVar(CSQL.VarContext ctx);
	/**
	 * Enter a parse tree produced by {@link CSQL#func}.
	 * @param ctx the parse tree
	 */
	void enterFunc(CSQL.FuncContext ctx);
	/**
	 * Exit a parse tree produced by {@link CSQL#func}.
	 * @param ctx the parse tree
	 */
	void exitFunc(CSQL.FuncContext ctx);
	/**
	 * Enter a parse tree produced by {@link CSQL#args}.
	 * @param ctx the parse tree
	 */
	void enterArgs(CSQL.ArgsContext ctx);
	/**
	 * Exit a parse tree produced by {@link CSQL#args}.
	 * @param ctx the parse tree
	 */
	void exitArgs(CSQL.ArgsContext ctx);
	/**
	 * Enter a parse tree produced by {@link CSQL#arg}.
	 * @param ctx the parse tree
	 */
	void enterArg(CSQL.ArgContext ctx);
	/**
	 * Exit a parse tree produced by {@link CSQL#arg}.
	 * @param ctx the parse tree
	 */
	void exitArg(CSQL.ArgContext ctx);
	/**
	 * Enter a parse tree produced by {@link CSQL#body}.
	 * @param ctx the parse tree
	 */
	void enterBody(CSQL.BodyContext ctx);
	/**
	 * Exit a parse tree produced by {@link CSQL#body}.
	 * @param ctx the parse tree
	 */
	void exitBody(CSQL.BodyContext ctx);
	/**
	 * Enter a parse tree produced by {@link CSQL#stat}.
	 * @param ctx the parse tree
	 */
	void enterStat(CSQL.StatContext ctx);
	/**
	 * Exit a parse tree produced by {@link CSQL#stat}.
	 * @param ctx the parse tree
	 */
	void exitStat(CSQL.StatContext ctx);
	/**
	 * Enter a parse tree produced by {@link CSQL#expr}.
	 * @param ctx the parse tree
	 */
	void enterExpr(CSQL.ExprContext ctx);
	/**
	 * Exit a parse tree produced by {@link CSQL#expr}.
	 * @param ctx the parse tree
	 */
	void exitExpr(CSQL.ExprContext ctx);
	/**
	 * Enter a parse tree produced by {@link CSQL#sqlselect}.
	 * @param ctx the parse tree
	 */
	void enterSqlselect(CSQL.SqlselectContext ctx);
	/**
	 * Exit a parse tree produced by {@link CSQL#sqlselect}.
	 * @param ctx the parse tree
	 */
	void exitSqlselect(CSQL.SqlselectContext ctx);
	/**
	 * Enter a parse tree produced by {@link CSQL#condition}.
	 * @param ctx the parse tree
	 */
	void enterCondition(CSQL.ConditionContext ctx);
	/**
	 * Exit a parse tree produced by {@link CSQL#condition}.
	 * @param ctx the parse tree
	 */
	void exitCondition(CSQL.ConditionContext ctx);
	/**
	 * Enter a parse tree produced by {@link CSQL#kselect}.
	 * @param ctx the parse tree
	 */
	void enterKselect(CSQL.KselectContext ctx);
	/**
	 * Exit a parse tree produced by {@link CSQL#kselect}.
	 * @param ctx the parse tree
	 */
	void exitKselect(CSQL.KselectContext ctx);
	/**
	 * Enter a parse tree produced by {@link CSQL#kfrom}.
	 * @param ctx the parse tree
	 */
	void enterKfrom(CSQL.KfromContext ctx);
	/**
	 * Exit a parse tree produced by {@link CSQL#kfrom}.
	 * @param ctx the parse tree
	 */
	void exitKfrom(CSQL.KfromContext ctx);
	/**
	 * Enter a parse tree produced by {@link CSQL#kwhere}.
	 * @param ctx the parse tree
	 */
	void enterKwhere(CSQL.KwhereContext ctx);
	/**
	 * Exit a parse tree produced by {@link CSQL#kwhere}.
	 * @param ctx the parse tree
	 */
	void exitKwhere(CSQL.KwhereContext ctx);
	/**
	 * Enter a parse tree produced by {@link CSQL#kand}.
	 * @param ctx the parse tree
	 */
	void enterKand(CSQL.KandContext ctx);
	/**
	 * Exit a parse tree produced by {@link CSQL#kand}.
	 * @param ctx the parse tree
	 */
	void exitKand(CSQL.KandContext ctx);
	/**
	 * Enter a parse tree produced by {@link CSQL#idlist}.
	 * @param ctx the parse tree
	 */
	void enterIdlist(CSQL.IdlistContext ctx);
	/**
	 * Exit a parse tree produced by {@link CSQL#idlist}.
	 * @param ctx the parse tree
	 */
	void exitIdlist(CSQL.IdlistContext ctx);
	/**
	 * Enter a parse tree produced by {@link CSQL#sqlexpr}.
	 * @param ctx the parse tree
	 */
	void enterSqlexpr(CSQL.SqlexprContext ctx);
	/**
	 * Exit a parse tree produced by {@link CSQL#sqlexpr}.
	 * @param ctx the parse tree
	 */
	void exitSqlexpr(CSQL.SqlexprContext ctx);
	/**
	 * Enter a parse tree produced by {@link CSQL#sqlstring}.
	 * @param ctx the parse tree
	 */
	void enterSqlstring(CSQL.SqlstringContext ctx);
	/**
	 * Exit a parse tree produced by {@link CSQL#sqlstring}.
	 * @param ctx the parse tree
	 */
	void exitSqlstring(CSQL.SqlstringContext ctx);
	/**
	 * Enter a parse tree produced by {@link CSQL#sqleq}.
	 * @param ctx the parse tree
	 */
	void enterSqleq(CSQL.SqleqContext ctx);
	/**
	 * Exit a parse tree produced by {@link CSQL#sqleq}.
	 * @param ctx the parse tree
	 */
	void exitSqleq(CSQL.SqleqContext ctx);
	/**
	 * Enter a parse tree produced by {@link CSQL#sqlneq}.
	 * @param ctx the parse tree
	 */
	void enterSqlneq(CSQL.SqlneqContext ctx);
	/**
	 * Exit a parse tree produced by {@link CSQL#sqlneq}.
	 * @param ctx the parse tree
	 */
	void exitSqlneq(CSQL.SqlneqContext ctx);
	/**
	 * Enter a parse tree produced by {@link CSQL#id}.
	 * @param ctx the parse tree
	 */
	void enterId(CSQL.IdContext ctx);
	/**
	 * Exit a parse tree produced by {@link CSQL#id}.
	 * @param ctx the parse tree
	 */
	void exitId(CSQL.IdContext ctx);
	/**
	 * Enter a parse tree produced by {@link CSQL#squote}.
	 * @param ctx the parse tree
	 */
	void enterSquote(CSQL.SquoteContext ctx);
	/**
	 * Exit a parse tree produced by {@link CSQL#squote}.
	 * @param ctx the parse tree
	 */
	void exitSquote(CSQL.SquoteContext ctx);
	/**
	 * Enter a parse tree produced by {@link CSQL#lc}.
	 * @param ctx the parse tree
	 */
	void enterLc(CSQL.LcContext ctx);
	/**
	 * Exit a parse tree produced by {@link CSQL#lc}.
	 * @param ctx the parse tree
	 */
	void exitLc(CSQL.LcContext ctx);
	/**
	 * Enter a parse tree produced by {@link CSQL#rc}.
	 * @param ctx the parse tree
	 */
	void enterRc(CSQL.RcContext ctx);
	/**
	 * Exit a parse tree produced by {@link CSQL#rc}.
	 * @param ctx the parse tree
	 */
	void exitRc(CSQL.RcContext ctx);
	/**
	 * Enter a parse tree produced by {@link CSQL#lp}.
	 * @param ctx the parse tree
	 */
	void enterLp(CSQL.LpContext ctx);
	/**
	 * Exit a parse tree produced by {@link CSQL#lp}.
	 * @param ctx the parse tree
	 */
	void exitLp(CSQL.LpContext ctx);
	/**
	 * Enter a parse tree produced by {@link CSQL#rp}.
	 * @param ctx the parse tree
	 */
	void enterRp(CSQL.RpContext ctx);
	/**
	 * Exit a parse tree produced by {@link CSQL#rp}.
	 * @param ctx the parse tree
	 */
	void exitRp(CSQL.RpContext ctx);
	/**
	 * Enter a parse tree produced by {@link CSQL#star}.
	 * @param ctx the parse tree
	 */
	void enterStar(CSQL.StarContext ctx);
	/**
	 * Exit a parse tree produced by {@link CSQL#star}.
	 * @param ctx the parse tree
	 */
	void exitStar(CSQL.StarContext ctx);
	/**
	 * Enter a parse tree produced by {@link CSQL#plus}.
	 * @param ctx the parse tree
	 */
	void enterPlus(CSQL.PlusContext ctx);
	/**
	 * Exit a parse tree produced by {@link CSQL#plus}.
	 * @param ctx the parse tree
	 */
	void exitPlus(CSQL.PlusContext ctx);
	/**
	 * Enter a parse tree produced by {@link CSQL#ass}.
	 * @param ctx the parse tree
	 */
	void enterAss(CSQL.AssContext ctx);
	/**
	 * Exit a parse tree produced by {@link CSQL#ass}.
	 * @param ctx the parse tree
	 */
	void exitAss(CSQL.AssContext ctx);
	/**
	 * Enter a parse tree produced by {@link CSQL#eq}.
	 * @param ctx the parse tree
	 */
	void enterEq(CSQL.EqContext ctx);
	/**
	 * Exit a parse tree produced by {@link CSQL#eq}.
	 * @param ctx the parse tree
	 */
	void exitEq(CSQL.EqContext ctx);
	/**
	 * Enter a parse tree produced by {@link CSQL#neq}.
	 * @param ctx the parse tree
	 */
	void enterNeq(CSQL.NeqContext ctx);
	/**
	 * Exit a parse tree produced by {@link CSQL#neq}.
	 * @param ctx the parse tree
	 */
	void exitNeq(CSQL.NeqContext ctx);
	/**
	 * Enter a parse tree produced by {@link CSQL#colon}.
	 * @param ctx the parse tree
	 */
	void enterColon(CSQL.ColonContext ctx);
	/**
	 * Exit a parse tree produced by {@link CSQL#colon}.
	 * @param ctx the parse tree
	 */
	void exitColon(CSQL.ColonContext ctx);
	/**
	 * Enter a parse tree produced by {@link CSQL#semi}.
	 * @param ctx the parse tree
	 */
	void enterSemi(CSQL.SemiContext ctx);
	/**
	 * Exit a parse tree produced by {@link CSQL#semi}.
	 * @param ctx the parse tree
	 */
	void exitSemi(CSQL.SemiContext ctx);
	/**
	 * Enter a parse tree produced by {@link CSQL#kint}.
	 * @param ctx the parse tree
	 */
	void enterKint(CSQL.KintContext ctx);
	/**
	 * Exit a parse tree produced by {@link CSQL#kint}.
	 * @param ctx the parse tree
	 */
	void exitKint(CSQL.KintContext ctx);
	/**
	 * Enter a parse tree produced by {@link CSQL#kvoid}.
	 * @param ctx the parse tree
	 */
	void enterKvoid(CSQL.KvoidContext ctx);
	/**
	 * Exit a parse tree produced by {@link CSQL#kvoid}.
	 * @param ctx the parse tree
	 */
	void exitKvoid(CSQL.KvoidContext ctx);
	/**
	 * Enter a parse tree produced by {@link CSQL#kreturn}.
	 * @param ctx the parse tree
	 */
	void enterKreturn(CSQL.KreturnContext ctx);
	/**
	 * Exit a parse tree produced by {@link CSQL#kreturn}.
	 * @param ctx the parse tree
	 */
	void exitKreturn(CSQL.KreturnContext ctx);
	/**
	 * Enter a parse tree produced by {@link CSQL#cchar}.
	 * @param ctx the parse tree
	 */
	void enterCchar(CSQL.CcharContext ctx);
	/**
	 * Exit a parse tree produced by {@link CSQL#cchar}.
	 * @param ctx the parse tree
	 */
	void exitCchar(CSQL.CcharContext ctx);
	/**
	 * Enter a parse tree produced by {@link CSQL#integer}.
	 * @param ctx the parse tree
	 */
	void enterInteger(CSQL.IntegerContext ctx);
	/**
	 * Exit a parse tree produced by {@link CSQL#integer}.
	 * @param ctx the parse tree
	 */
	void exitInteger(CSQL.IntegerContext ctx);
	/**
	 * Enter a parse tree produced by {@link CSQL#digit}.
	 * @param ctx the parse tree
	 */
	void enterDigit(CSQL.DigitContext ctx);
	/**
	 * Exit a parse tree produced by {@link CSQL#digit}.
	 * @param ctx the parse tree
	 */
	void exitDigit(CSQL.DigitContext ctx);
	/**
	 * Enter a parse tree produced by {@link CSQL#letter}.
	 * @param ctx the parse tree
	 */
	void enterLetter(CSQL.LetterContext ctx);
	/**
	 * Exit a parse tree produced by {@link CSQL#letter}.
	 * @param ctx the parse tree
	 */
	void exitLetter(CSQL.LetterContext ctx);
	/**
	 * Enter a parse tree produced by {@link CSQL#ws}.
	 * @param ctx the parse tree
	 */
	void enterWs(CSQL.WsContext ctx);
	/**
	 * Exit a parse tree produced by {@link CSQL#ws}.
	 * @param ctx the parse tree
	 */
	void exitWs(CSQL.WsContext ctx);
	/**
	 * Enter a parse tree produced by {@link CSQL#comment}.
	 * @param ctx the parse tree
	 */
	void enterComment(CSQL.CommentContext ctx);
	/**
	 * Exit a parse tree produced by {@link CSQL#comment}.
	 * @param ctx the parse tree
	 */
	void exitComment(CSQL.CommentContext ctx);
}