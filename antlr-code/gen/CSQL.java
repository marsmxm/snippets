// Generated from /Users/mxm/learn/snippets/antlr-code/original/extras/CSQL.g4 by ANTLR 4.13.1

import java.util.Set;
import java.util.HashSet;

import org.antlr.v4.runtime.atn.*;
import org.antlr.v4.runtime.dfa.DFA;
import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.misc.*;
import org.antlr.v4.runtime.tree.*;
import java.util.List;
import java.util.Iterator;
import java.util.ArrayList;

@SuppressWarnings({"all", "warnings", "unchecked", "unused", "cast", "CheckReturnValue"})
public class CSQL extends Parser {
	static { RuntimeMetaData.checkVersion("4.13.1", RuntimeMetaData.VERSION); }

	protected static final DFA[] _decisionToDFA;
	protected static final PredictionContextCache _sharedContextCache =
		new PredictionContextCache();
	public static final int
		RULE_prog = 0, RULE_type = 1, RULE_var = 2, RULE_func = 3, RULE_args = 4, 
		RULE_arg = 5, RULE_body = 6, RULE_stat = 7, RULE_expr = 8, RULE_sqlselect = 9, 
		RULE_condition = 10, RULE_kselect = 11, RULE_kfrom = 12, RULE_kwhere = 13, 
		RULE_kand = 14, RULE_idlist = 15, RULE_sqlexpr = 16, RULE_sqlstring = 17, 
		RULE_sqleq = 18, RULE_sqlneq = 19, RULE_id = 20, RULE_squote = 21, RULE_lc = 22, 
		RULE_rc = 23, RULE_lp = 24, RULE_rp = 25, RULE_star = 26, RULE_plus = 27, 
		RULE_ass = 28, RULE_eq = 29, RULE_neq = 30, RULE_colon = 31, RULE_semi = 32, 
		RULE_kint = 33, RULE_kvoid = 34, RULE_kreturn = 35, RULE_cchar = 36, RULE_integer = 37, 
		RULE_digit = 38, RULE_letter = 39, RULE_ws = 40, RULE_comment = 41;
	private static String[] makeRuleNames() {
		return new String[] {
			"prog", "type", "var", "func", "args", "arg", "body", "stat", "expr", 
			"sqlselect", "condition", "kselect", "kfrom", "kwhere", "kand", "idlist", 
			"sqlexpr", "sqlstring", "sqleq", "sqlneq", "id", "squote", "lc", "rc", 
			"lp", "rp", "star", "plus", "ass", "eq", "neq", "colon", "semi", "kint", 
			"kvoid", "kreturn", "cchar", "integer", "digit", "letter", "ws", "comment"
		};
	}
	public static final String[] ruleNames = makeRuleNames();

	private static String[] makeLiteralNames() {
		return new String[] {
			null, null, null, null, null, null, null, null, null, "'\\t'", "'\\n'", 
			null, null, "'\\r'", null, null, null, null, null, null, null, null, 
			null, null, null, null, null, null, null, null, null, null, "' '", "'!'", 
			"'\"'", "'#'", "'$'", "'%'", "'&'", "'''", "'('", "')'", "'*'", "'+'", 
			"','", "'-'", "'.'", "'/'", "'0'", "'1'", "'2'", "'3'", "'4'", "'5'", 
			"'6'", "'7'", "'8'", "'9'", "':'", "';'", "'<'", "'='", "'>'", "'?'", 
			"'@'", "'A'", "'B'", "'C'", "'D'", "'E'", "'F'", "'G'", "'H'", "'I'", 
			"'J'", "'K'", "'L'", "'M'", "'N'", "'O'", "'P'", "'Q'", "'R'", "'S'", 
			"'T'", "'U'", "'V'", "'W'", "'X'", "'Y'", "'Z'", "'['", "'\\'", "']'", 
			"'^'", "'_'", "'`'", "'a'", "'b'", "'c'", "'d'", "'e'", "'f'", "'g'", 
			"'h'", "'i'", "'j'", "'k'", "'l'", "'m'", "'n'", "'o'", "'p'", "'q'", 
			"'r'", "'s'", "'t'", "'u'", "'v'", "'w'", "'x'", "'y'", "'z'", "'{'", 
			"'|'", "'}'", "'~'"
		};
	}
	private static final String[] _LITERAL_NAMES = makeLiteralNames();
	private static String[] makeSymbolicNames() {
		return new String[] {
			null, null, null, null, null, null, null, null, null, "'\\t'", "'\\n'", 
			null, null, "'\\r'", null, null, null, null, null, null, null, null, 
			null, null, null, null, null, null, null, null, null, null, "' '", "'!'", 
			"'\"'", "'#'", "'$'", "'%'", "'&'", "'''", "'('", "')'", "'*'", "'+'", 
			"','", "'-'", "'.'", "'/'", "'0'", "'1'", "'2'", "'3'", "'4'", "'5'", 
			"'6'", "'7'", "'8'", "'9'", "':'", "';'", "'<'", "'='", "'>'", "'?'", 
			"'@'", "'A'", "'B'", "'C'", "'D'", "'E'", "'F'", "'G'", "'H'", "'I'", 
			"'J'", "'K'", "'L'", "'M'", "'N'", "'O'", "'P'", "'Q'", "'R'", "'S'", 
			"'T'", "'U'", "'V'", "'W'", "'X'", "'Y'", "'Z'", "'['", "'\\'", "']'", 
			"'^'", "'_'", "'`'", "'a'", "'b'", "'c'", "'d'", "'e'", "'f'", "'g'", 
			"'h'", "'i'", "'j'", "'k'", "'l'", "'m'", "'n'", "'o'", "'p'", "'q'", 
			"'r'", "'s'", "'t'", "'u'", "'v'", "'w'", "'x'", "'y'", "'z'", "'{'", 
			"'|'", "'}'", "'~'"
		};
	}
	private static final String[] _SYMBOLIC_NAMES = makeSymbolicNames();
	public static final Vocabulary VOCABULARY = new VocabularyImpl(_LITERAL_NAMES, _SYMBOLIC_NAMES);

	/**
	 * @deprecated Use {@link #VOCABULARY} instead.
	 */
	@Deprecated
	public static final String[] tokenNames;
	static {
		tokenNames = new String[_SYMBOLIC_NAMES.length];
		for (int i = 0; i < tokenNames.length; i++) {
			tokenNames[i] = VOCABULARY.getLiteralName(i);
			if (tokenNames[i] == null) {
				tokenNames[i] = VOCABULARY.getSymbolicName(i);
			}

			if (tokenNames[i] == null) {
				tokenNames[i] = "<INVALID>";
			}
		}
	}

	@Override
	@Deprecated
	public String[] getTokenNames() {
		return tokenNames;
	}

	@Override

	public Vocabulary getVocabulary() {
		return VOCABULARY;
	}

	@Override
	public String getGrammarFileName() { return "CSQL.g4"; }

	@Override
	public String[] getRuleNames() { return ruleNames; }

	@Override
	public String getSerializedATN() { return _serializedATN; }

	@Override
	public ATN getATN() { return _ATN; }


	public static Set<String> keywords = new HashSet<String>() {{
	    add("void");
	    add("int");
	    add("return");
	}};
	boolean notLetterOrDigit(int la) {
	    return !Character.isLetterOrDigit(_input.LA(la));
	}

	public CSQL(TokenStream input) {
		super(input);
		_interp = new ParserATNSimulator(this,_ATN,_decisionToDFA,_sharedContextCache);
	}

	@SuppressWarnings("CheckReturnValue")
	public static class ProgContext extends ParserRuleContext {
		public TerminalNode EOF() { return getToken(CSQL.EOF, 0); }
		public WsContext ws() {
			return getRuleContext(WsContext.class,0);
		}
		public List<VarContext> var() {
			return getRuleContexts(VarContext.class);
		}
		public VarContext var(int i) {
			return getRuleContext(VarContext.class,i);
		}
		public List<FuncContext> func() {
			return getRuleContexts(FuncContext.class);
		}
		public FuncContext func(int i) {
			return getRuleContext(FuncContext.class,i);
		}
		public ProgContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_prog; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof CSQLListener ) ((CSQLListener)listener).enterProg(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof CSQLListener ) ((CSQLListener)listener).exitProg(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof CSQLVisitor ) return ((CSQLVisitor<? extends T>)visitor).visitProg(this);
			else return visitor.visitChildren(this);
		}
	}

	public final ProgContext prog() throws RecognitionException {
		ProgContext _localctx = new ProgContext(_ctx, getState());
		enterRule(_localctx, 0, RULE_prog);
		try {
			int _alt;
			enterOuterAlt(_localctx, 1);
			{
			setState(85);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,0,_ctx) ) {
			case 1:
				{
				setState(84);
				ws();
				}
				break;
			}
			setState(89); 
			_errHandler.sync(this);
			_alt = 1;
			do {
				switch (_alt) {
				case 1:
					{
					setState(89);
					_errHandler.sync(this);
					switch ( getInterpreter().adaptivePredict(_input,1,_ctx) ) {
					case 1:
						{
						setState(87);
						var();
						}
						break;
					case 2:
						{
						setState(88);
						func();
						}
						break;
					}
					}
					break;
				default:
					throw new NoViableAltException(this);
				}
				setState(91); 
				_errHandler.sync(this);
				_alt = getInterpreter().adaptivePredict(_input,2,_ctx);
			} while ( _alt!=2 && _alt!=org.antlr.v4.runtime.atn.ATN.INVALID_ALT_NUMBER );
			setState(93);
			match(EOF);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	@SuppressWarnings("CheckReturnValue")
	public static class TypeContext extends ParserRuleContext {
		public KintContext kint() {
			return getRuleContext(KintContext.class,0);
		}
		public KvoidContext kvoid() {
			return getRuleContext(KvoidContext.class,0);
		}
		public IdContext id() {
			return getRuleContext(IdContext.class,0);
		}
		public TypeContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_type; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof CSQLListener ) ((CSQLListener)listener).enterType(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof CSQLListener ) ((CSQLListener)listener).exitType(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof CSQLVisitor ) return ((CSQLVisitor<? extends T>)visitor).visitType(this);
			else return visitor.visitChildren(this);
		}
	}

	public final TypeContext type() throws RecognitionException {
		TypeContext _localctx = new TypeContext(_ctx, getState());
		enterRule(_localctx, 2, RULE_type);
		try {
			setState(98);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,3,_ctx) ) {
			case 1:
				enterOuterAlt(_localctx, 1);
				{
				setState(95);
				kint();
				}
				break;
			case 2:
				enterOuterAlt(_localctx, 2);
				{
				setState(96);
				kvoid();
				}
				break;
			case 3:
				enterOuterAlt(_localctx, 3);
				{
				setState(97);
				id();
				}
				break;
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	@SuppressWarnings("CheckReturnValue")
	public static class VarContext extends ParserRuleContext {
		public TypeContext type() {
			return getRuleContext(TypeContext.class,0);
		}
		public IdContext id() {
			return getRuleContext(IdContext.class,0);
		}
		public SemiContext semi() {
			return getRuleContext(SemiContext.class,0);
		}
		public AssContext ass() {
			return getRuleContext(AssContext.class,0);
		}
		public ExprContext expr() {
			return getRuleContext(ExprContext.class,0);
		}
		public VarContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_var; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof CSQLListener ) ((CSQLListener)listener).enterVar(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof CSQLListener ) ((CSQLListener)listener).exitVar(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof CSQLVisitor ) return ((CSQLVisitor<? extends T>)visitor).visitVar(this);
			else return visitor.visitChildren(this);
		}
	}

	public final VarContext var() throws RecognitionException {
		VarContext _localctx = new VarContext(_ctx, getState());
		enterRule(_localctx, 4, RULE_var);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(100);
			type();
			setState(101);
			id();
			setState(105);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if (_la=='=') {
				{
				setState(102);
				ass();
				setState(103);
				expr(0);
				}
			}

			setState(107);
			semi();
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	@SuppressWarnings("CheckReturnValue")
	public static class FuncContext extends ParserRuleContext {
		public TypeContext type() {
			return getRuleContext(TypeContext.class,0);
		}
		public IdContext id() {
			return getRuleContext(IdContext.class,0);
		}
		public LpContext lp() {
			return getRuleContext(LpContext.class,0);
		}
		public RpContext rp() {
			return getRuleContext(RpContext.class,0);
		}
		public BodyContext body() {
			return getRuleContext(BodyContext.class,0);
		}
		public ArgsContext args() {
			return getRuleContext(ArgsContext.class,0);
		}
		public FuncContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_func; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof CSQLListener ) ((CSQLListener)listener).enterFunc(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof CSQLListener ) ((CSQLListener)listener).exitFunc(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof CSQLVisitor ) return ((CSQLVisitor<? extends T>)visitor).visitFunc(this);
			else return visitor.visitChildren(this);
		}
	}

	public final FuncContext func() throws RecognitionException {
		FuncContext _localctx = new FuncContext(_ctx, getState());
		enterRule(_localctx, 6, RULE_func);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(109);
			type();
			setState(110);
			id();
			setState(111);
			lp();
			setState(113);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,5,_ctx) ) {
			case 1:
				{
				setState(112);
				args();
				}
				break;
			}
			setState(115);
			rp();
			setState(116);
			body();
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	@SuppressWarnings("CheckReturnValue")
	public static class ArgsContext extends ParserRuleContext {
		public List<ArgContext> arg() {
			return getRuleContexts(ArgContext.class);
		}
		public ArgContext arg(int i) {
			return getRuleContext(ArgContext.class,i);
		}
		public List<TerminalNode> ','() { return getTokens(CSQL.','); }
		public TerminalNode ','(int i) {
			return getToken(CSQL.',', i);
		}
		public ArgsContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_args; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof CSQLListener ) ((CSQLListener)listener).enterArgs(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof CSQLListener ) ((CSQLListener)listener).exitArgs(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof CSQLVisitor ) return ((CSQLVisitor<? extends T>)visitor).visitArgs(this);
			else return visitor.visitChildren(this);
		}
	}

	public final ArgsContext args() throws RecognitionException {
		ArgsContext _localctx = new ArgsContext(_ctx, getState());
		enterRule(_localctx, 8, RULE_args);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(118);
			arg();
			setState(123);
			_errHandler.sync(this);
			_la = _input.LA(1);
			while (_la==',') {
				{
				{
				setState(119);
				match(',');
				setState(120);
				arg();
				}
				}
				setState(125);
				_errHandler.sync(this);
				_la = _input.LA(1);
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	@SuppressWarnings("CheckReturnValue")
	public static class ArgContext extends ParserRuleContext {
		public TypeContext type() {
			return getRuleContext(TypeContext.class,0);
		}
		public IdContext id() {
			return getRuleContext(IdContext.class,0);
		}
		public ArgContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_arg; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof CSQLListener ) ((CSQLListener)listener).enterArg(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof CSQLListener ) ((CSQLListener)listener).exitArg(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof CSQLVisitor ) return ((CSQLVisitor<? extends T>)visitor).visitArg(this);
			else return visitor.visitChildren(this);
		}
	}

	public final ArgContext arg() throws RecognitionException {
		ArgContext _localctx = new ArgContext(_ctx, getState());
		enterRule(_localctx, 10, RULE_arg);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(126);
			type();
			setState(127);
			id();
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	@SuppressWarnings("CheckReturnValue")
	public static class BodyContext extends ParserRuleContext {
		public LcContext lc() {
			return getRuleContext(LcContext.class,0);
		}
		public RcContext rc() {
			return getRuleContext(RcContext.class,0);
		}
		public List<StatContext> stat() {
			return getRuleContexts(StatContext.class);
		}
		public StatContext stat(int i) {
			return getRuleContext(StatContext.class,i);
		}
		public BodyContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_body; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof CSQLListener ) ((CSQLListener)listener).enterBody(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof CSQLListener ) ((CSQLListener)listener).exitBody(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof CSQLVisitor ) return ((CSQLVisitor<? extends T>)visitor).visitBody(this);
			else return visitor.visitChildren(this);
		}
	}

	public final BodyContext body() throws RecognitionException {
		BodyContext _localctx = new BodyContext(_ctx, getState());
		enterRule(_localctx, 12, RULE_body);
		try {
			int _alt;
			enterOuterAlt(_localctx, 1);
			{
			setState(129);
			lc();
			setState(131); 
			_errHandler.sync(this);
			_alt = 1;
			do {
				switch (_alt) {
				case 1:
					{
					{
					setState(130);
					stat();
					}
					}
					break;
				default:
					throw new NoViableAltException(this);
				}
				setState(133); 
				_errHandler.sync(this);
				_alt = getInterpreter().adaptivePredict(_input,7,_ctx);
			} while ( _alt!=2 && _alt!=org.antlr.v4.runtime.atn.ATN.INVALID_ALT_NUMBER );
			setState(135);
			rc();
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	@SuppressWarnings("CheckReturnValue")
	public static class StatContext extends ParserRuleContext {
		public VarContext var() {
			return getRuleContext(VarContext.class,0);
		}
		public KreturnContext kreturn() {
			return getRuleContext(KreturnContext.class,0);
		}
		public ExprContext expr() {
			return getRuleContext(ExprContext.class,0);
		}
		public SemiContext semi() {
			return getRuleContext(SemiContext.class,0);
		}
		public IdContext id() {
			return getRuleContext(IdContext.class,0);
		}
		public AssContext ass() {
			return getRuleContext(AssContext.class,0);
		}
		public ColonContext colon() {
			return getRuleContext(ColonContext.class,0);
		}
		public StatContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_stat; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof CSQLListener ) ((CSQLListener)listener).enterStat(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof CSQLListener ) ((CSQLListener)listener).exitStat(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof CSQLVisitor ) return ((CSQLVisitor<? extends T>)visitor).visitStat(this);
			else return visitor.visitChildren(this);
		}
	}

	public final StatContext stat() throws RecognitionException {
		StatContext _localctx = new StatContext(_ctx, getState());
		enterRule(_localctx, 14, RULE_stat);
		try {
			setState(150);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,8,_ctx) ) {
			case 1:
				enterOuterAlt(_localctx, 1);
				{
				setState(137);
				var();
				}
				break;
			case 2:
				enterOuterAlt(_localctx, 2);
				{
				setState(138);
				kreturn();
				setState(139);
				expr(0);
				setState(140);
				semi();
				}
				break;
			case 3:
				enterOuterAlt(_localctx, 3);
				{
				setState(142);
				id();
				setState(143);
				ass();
				setState(144);
				expr(0);
				setState(145);
				semi();
				}
				break;
			case 4:
				enterOuterAlt(_localctx, 4);
				{
				setState(147);
				id();
				setState(148);
				colon();
				}
				break;
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	@SuppressWarnings("CheckReturnValue")
	public static class ExprContext extends ParserRuleContext {
		public IntegerContext integer() {
			return getRuleContext(IntegerContext.class,0);
		}
		public CcharContext cchar() {
			return getRuleContext(CcharContext.class,0);
		}
		public IdContext id() {
			return getRuleContext(IdContext.class,0);
		}
		public SqlselectContext sqlselect() {
			return getRuleContext(SqlselectContext.class,0);
		}
		public List<ExprContext> expr() {
			return getRuleContexts(ExprContext.class);
		}
		public ExprContext expr(int i) {
			return getRuleContext(ExprContext.class,i);
		}
		public EqContext eq() {
			return getRuleContext(EqContext.class,0);
		}
		public NeqContext neq() {
			return getRuleContext(NeqContext.class,0);
		}
		public StarContext star() {
			return getRuleContext(StarContext.class,0);
		}
		public PlusContext plus() {
			return getRuleContext(PlusContext.class,0);
		}
		public ExprContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_expr; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof CSQLListener ) ((CSQLListener)listener).enterExpr(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof CSQLListener ) ((CSQLListener)listener).exitExpr(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof CSQLVisitor ) return ((CSQLVisitor<? extends T>)visitor).visitExpr(this);
			else return visitor.visitChildren(this);
		}
	}

	public final ExprContext expr() throws RecognitionException {
		return expr(0);
	}

	private ExprContext expr(int _p) throws RecognitionException {
		ParserRuleContext _parentctx = _ctx;
		int _parentState = getState();
		ExprContext _localctx = new ExprContext(_ctx, _parentState);
		ExprContext _prevctx = _localctx;
		int _startState = 16;
		enterRecursionRule(_localctx, 16, RULE_expr, _p);
		try {
			int _alt;
			enterOuterAlt(_localctx, 1);
			{
			setState(157);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,9,_ctx) ) {
			case 1:
				{
				setState(153);
				integer();
				}
				break;
			case 2:
				{
				setState(154);
				cchar();
				}
				break;
			case 3:
				{
				setState(155);
				id();
				}
				break;
			case 4:
				{
				setState(156);
				sqlselect();
				}
				break;
			}
			_ctx.stop = _input.LT(-1);
			setState(176);
			_errHandler.sync(this);
			_alt = getInterpreter().adaptivePredict(_input,12,_ctx);
			while ( _alt!=2 && _alt!=org.antlr.v4.runtime.atn.ATN.INVALID_ALT_NUMBER ) {
				if ( _alt==1 ) {
					if ( _parseListeners!=null ) triggerExitRuleEvent();
					_prevctx = _localctx;
					{
					setState(174);
					_errHandler.sync(this);
					switch ( getInterpreter().adaptivePredict(_input,11,_ctx) ) {
					case 1:
						{
						_localctx = new ExprContext(_parentctx, _parentState);
						pushNewRecursionContext(_localctx, _startState, RULE_expr);
						setState(159);
						if (!(precpred(_ctx, 7))) throw new FailedPredicateException(this, "precpred(_ctx, 7)");
						setState(162);
						_errHandler.sync(this);
						switch (_input.LA(1)) {
						case '=':
							{
							setState(160);
							eq();
							}
							break;
						case '!':
							{
							setState(161);
							neq();
							}
							break;
						default:
							throw new NoViableAltException(this);
						}
						setState(164);
						expr(8);
						}
						break;
					case 2:
						{
						_localctx = new ExprContext(_parentctx, _parentState);
						pushNewRecursionContext(_localctx, _startState, RULE_expr);
						setState(166);
						if (!(precpred(_ctx, 6))) throw new FailedPredicateException(this, "precpred(_ctx, 6)");
						setState(167);
						star();
						setState(168);
						expr(7);
						}
						break;
					case 3:
						{
						_localctx = new ExprContext(_parentctx, _parentState);
						pushNewRecursionContext(_localctx, _startState, RULE_expr);
						setState(170);
						if (!(precpred(_ctx, 5))) throw new FailedPredicateException(this, "precpred(_ctx, 5)");
						setState(171);
						plus();
						setState(172);
						expr(6);
						}
						break;
					}
					} 
				}
				setState(178);
				_errHandler.sync(this);
				_alt = getInterpreter().adaptivePredict(_input,12,_ctx);
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			unrollRecursionContexts(_parentctx);
		}
		return _localctx;
	}

	@SuppressWarnings("CheckReturnValue")
	public static class SqlselectContext extends ParserRuleContext {
		public KselectContext kselect() {
			return getRuleContext(KselectContext.class,0);
		}
		public KfromContext kfrom() {
			return getRuleContext(KfromContext.class,0);
		}
		public SqlexprContext sqlexpr() {
			return getRuleContext(SqlexprContext.class,0);
		}
		public StarContext star() {
			return getRuleContext(StarContext.class,0);
		}
		public IdlistContext idlist() {
			return getRuleContext(IdlistContext.class,0);
		}
		public KwhereContext kwhere() {
			return getRuleContext(KwhereContext.class,0);
		}
		public ConditionContext condition() {
			return getRuleContext(ConditionContext.class,0);
		}
		public SqlselectContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_sqlselect; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof CSQLListener ) ((CSQLListener)listener).enterSqlselect(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof CSQLListener ) ((CSQLListener)listener).exitSqlselect(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof CSQLVisitor ) return ((CSQLVisitor<? extends T>)visitor).visitSqlselect(this);
			else return visitor.visitChildren(this);
		}
	}

	public final SqlselectContext sqlselect() throws RecognitionException {
		SqlselectContext _localctx = new SqlselectContext(_ctx, getState());
		enterRule(_localctx, 18, RULE_sqlselect);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(179);
			kselect();
			setState(182);
			_errHandler.sync(this);
			switch (_input.LA(1)) {
			case '*':
				{
				setState(180);
				star();
				}
				break;
			case 'A':
			case 'B':
			case 'C':
			case 'D':
			case 'E':
			case 'F':
			case 'G':
			case 'H':
			case 'I':
			case 'J':
			case 'K':
			case 'L':
			case 'M':
			case 'N':
			case 'O':
			case 'P':
			case 'Q':
			case 'R':
			case 'S':
			case 'T':
			case 'U':
			case 'V':
			case 'W':
			case 'X':
			case 'Y':
			case 'Z':
			case 'a':
			case 'b':
			case 'c':
			case 'd':
			case 'e':
			case 'f':
			case 'g':
			case 'h':
			case 'i':
			case 'j':
			case 'k':
			case 'l':
			case 'm':
			case 'n':
			case 'o':
			case 'p':
			case 'q':
			case 'r':
			case 's':
			case 't':
			case 'u':
			case 'v':
			case 'w':
			case 'x':
			case 'y':
			case 'z':
				{
				setState(181);
				idlist();
				}
				break;
			default:
				throw new NoViableAltException(this);
			}
			setState(184);
			kfrom();
			setState(185);
			sqlexpr();
			setState(189);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,14,_ctx) ) {
			case 1:
				{
				setState(186);
				kwhere();
				setState(187);
				condition(0);
				}
				break;
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	@SuppressWarnings("CheckReturnValue")
	public static class ConditionContext extends ParserRuleContext {
		public IdContext id() {
			return getRuleContext(IdContext.class,0);
		}
		public SqlneqContext sqlneq() {
			return getRuleContext(SqlneqContext.class,0);
		}
		public SqlexprContext sqlexpr() {
			return getRuleContext(SqlexprContext.class,0);
		}
		public SqleqContext sqleq() {
			return getRuleContext(SqleqContext.class,0);
		}
		public List<ConditionContext> condition() {
			return getRuleContexts(ConditionContext.class);
		}
		public ConditionContext condition(int i) {
			return getRuleContext(ConditionContext.class,i);
		}
		public KandContext kand() {
			return getRuleContext(KandContext.class,0);
		}
		public ConditionContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_condition; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof CSQLListener ) ((CSQLListener)listener).enterCondition(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof CSQLListener ) ((CSQLListener)listener).exitCondition(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof CSQLVisitor ) return ((CSQLVisitor<? extends T>)visitor).visitCondition(this);
			else return visitor.visitChildren(this);
		}
	}

	public final ConditionContext condition() throws RecognitionException {
		return condition(0);
	}

	private ConditionContext condition(int _p) throws RecognitionException {
		ParserRuleContext _parentctx = _ctx;
		int _parentState = getState();
		ConditionContext _localctx = new ConditionContext(_ctx, _parentState);
		ConditionContext _prevctx = _localctx;
		int _startState = 20;
		enterRecursionRule(_localctx, 20, RULE_condition, _p);
		try {
			int _alt;
			enterOuterAlt(_localctx, 1);
			{
			setState(200);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,15,_ctx) ) {
			case 1:
				{
				setState(192);
				id();
				setState(193);
				sqlneq();
				setState(194);
				sqlexpr();
				}
				break;
			case 2:
				{
				setState(196);
				id();
				setState(197);
				sqleq();
				setState(198);
				sqlexpr();
				}
				break;
			}
			_ctx.stop = _input.LT(-1);
			setState(208);
			_errHandler.sync(this);
			_alt = getInterpreter().adaptivePredict(_input,16,_ctx);
			while ( _alt!=2 && _alt!=org.antlr.v4.runtime.atn.ATN.INVALID_ALT_NUMBER ) {
				if ( _alt==1 ) {
					if ( _parseListeners!=null ) triggerExitRuleEvent();
					_prevctx = _localctx;
					{
					{
					_localctx = new ConditionContext(_parentctx, _parentState);
					pushNewRecursionContext(_localctx, _startState, RULE_condition);
					setState(202);
					if (!(precpred(_ctx, 3))) throw new FailedPredicateException(this, "precpred(_ctx, 3)");
					setState(203);
					kand();
					setState(204);
					condition(4);
					}
					} 
				}
				setState(210);
				_errHandler.sync(this);
				_alt = getInterpreter().adaptivePredict(_input,16,_ctx);
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			unrollRecursionContexts(_parentctx);
		}
		return _localctx;
	}

	@SuppressWarnings("CheckReturnValue")
	public static class KselectContext extends ParserRuleContext {
		public TerminalNode 's'() { return getToken(CSQL.'s', 0); }
		public TerminalNode 'S'() { return getToken(CSQL.'S', 0); }
		public List<TerminalNode> 'e'() { return getTokens(CSQL.'e'); }
		public TerminalNode 'e'(int i) {
			return getToken(CSQL.'e', i);
		}
		public List<TerminalNode> 'E'() { return getTokens(CSQL.'E'); }
		public TerminalNode 'E'(int i) {
			return getToken(CSQL.'E', i);
		}
		public TerminalNode 'l'() { return getToken(CSQL.'l', 0); }
		public TerminalNode 'L'() { return getToken(CSQL.'L', 0); }
		public TerminalNode 'c'() { return getToken(CSQL.'c', 0); }
		public TerminalNode 'C'() { return getToken(CSQL.'C', 0); }
		public TerminalNode 't'() { return getToken(CSQL.'t', 0); }
		public TerminalNode 'T'() { return getToken(CSQL.'T', 0); }
		public WsContext ws() {
			return getRuleContext(WsContext.class,0);
		}
		public KselectContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_kselect; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof CSQLListener ) ((CSQLListener)listener).enterKselect(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof CSQLListener ) ((CSQLListener)listener).exitKselect(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof CSQLVisitor ) return ((CSQLVisitor<? extends T>)visitor).visitKselect(this);
			else return visitor.visitChildren(this);
		}
	}

	public final KselectContext kselect() throws RecognitionException {
		KselectContext _localctx = new KselectContext(_ctx, getState());
		enterRule(_localctx, 22, RULE_kselect);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(211);
			if (!(notLetterOrDigit(7))) throw new FailedPredicateException(this, "notLetterOrDigit(7)");
			setState(212);
			_la = _input.LA(1);
			if ( !(_la=='S' || _la=='s') ) {
			_errHandler.recoverInline(this);
			}
			else {
				if ( _input.LA(1)==Token.EOF ) matchedEOF = true;
				_errHandler.reportMatch(this);
				consume();
			}
			setState(213);
			_la = _input.LA(1);
			if ( !(_la=='E' || _la=='e') ) {
			_errHandler.recoverInline(this);
			}
			else {
				if ( _input.LA(1)==Token.EOF ) matchedEOF = true;
				_errHandler.reportMatch(this);
				consume();
			}
			setState(214);
			_la = _input.LA(1);
			if ( !(_la=='L' || _la=='l') ) {
			_errHandler.recoverInline(this);
			}
			else {
				if ( _input.LA(1)==Token.EOF ) matchedEOF = true;
				_errHandler.reportMatch(this);
				consume();
			}
			setState(215);
			_la = _input.LA(1);
			if ( !(_la=='E' || _la=='e') ) {
			_errHandler.recoverInline(this);
			}
			else {
				if ( _input.LA(1)==Token.EOF ) matchedEOF = true;
				_errHandler.reportMatch(this);
				consume();
			}
			setState(216);
			_la = _input.LA(1);
			if ( !(_la=='C' || _la=='c') ) {
			_errHandler.recoverInline(this);
			}
			else {
				if ( _input.LA(1)==Token.EOF ) matchedEOF = true;
				_errHandler.reportMatch(this);
				consume();
			}
			setState(217);
			_la = _input.LA(1);
			if ( !(_la=='T' || _la=='t') ) {
			_errHandler.recoverInline(this);
			}
			else {
				if ( _input.LA(1)==Token.EOF ) matchedEOF = true;
				_errHandler.reportMatch(this);
				consume();
			}
			setState(219);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if ((((_la) & ~0x3f) == 0 && ((1L << _la) & 140741783324160L) != 0)) {
				{
				setState(218);
				ws();
				}
			}

			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	@SuppressWarnings("CheckReturnValue")
	public static class KfromContext extends ParserRuleContext {
		public TerminalNode 'f'() { return getToken(CSQL.'f', 0); }
		public TerminalNode 'F'() { return getToken(CSQL.'F', 0); }
		public TerminalNode 'r'() { return getToken(CSQL.'r', 0); }
		public TerminalNode 'R'() { return getToken(CSQL.'R', 0); }
		public TerminalNode 'o'() { return getToken(CSQL.'o', 0); }
		public TerminalNode 'O'() { return getToken(CSQL.'O', 0); }
		public TerminalNode 'm'() { return getToken(CSQL.'m', 0); }
		public TerminalNode 'M'() { return getToken(CSQL.'M', 0); }
		public WsContext ws() {
			return getRuleContext(WsContext.class,0);
		}
		public KfromContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_kfrom; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof CSQLListener ) ((CSQLListener)listener).enterKfrom(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof CSQLListener ) ((CSQLListener)listener).exitKfrom(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof CSQLVisitor ) return ((CSQLVisitor<? extends T>)visitor).visitKfrom(this);
			else return visitor.visitChildren(this);
		}
	}

	public final KfromContext kfrom() throws RecognitionException {
		KfromContext _localctx = new KfromContext(_ctx, getState());
		enterRule(_localctx, 24, RULE_kfrom);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(221);
			if (!(notLetterOrDigit(5))) throw new FailedPredicateException(this, "notLetterOrDigit(5)");
			setState(222);
			_la = _input.LA(1);
			if ( !(_la=='F' || _la=='f') ) {
			_errHandler.recoverInline(this);
			}
			else {
				if ( _input.LA(1)==Token.EOF ) matchedEOF = true;
				_errHandler.reportMatch(this);
				consume();
			}
			setState(223);
			_la = _input.LA(1);
			if ( !(_la=='R' || _la=='r') ) {
			_errHandler.recoverInline(this);
			}
			else {
				if ( _input.LA(1)==Token.EOF ) matchedEOF = true;
				_errHandler.reportMatch(this);
				consume();
			}
			setState(224);
			_la = _input.LA(1);
			if ( !(_la=='O' || _la=='o') ) {
			_errHandler.recoverInline(this);
			}
			else {
				if ( _input.LA(1)==Token.EOF ) matchedEOF = true;
				_errHandler.reportMatch(this);
				consume();
			}
			setState(225);
			_la = _input.LA(1);
			if ( !(_la=='M' || _la=='m') ) {
			_errHandler.recoverInline(this);
			}
			else {
				if ( _input.LA(1)==Token.EOF ) matchedEOF = true;
				_errHandler.reportMatch(this);
				consume();
			}
			setState(227);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if ((((_la) & ~0x3f) == 0 && ((1L << _la) & 140741783324160L) != 0)) {
				{
				setState(226);
				ws();
				}
			}

			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	@SuppressWarnings("CheckReturnValue")
	public static class KwhereContext extends ParserRuleContext {
		public TerminalNode 'w'() { return getToken(CSQL.'w', 0); }
		public TerminalNode 'W'() { return getToken(CSQL.'W', 0); }
		public TerminalNode 'h'() { return getToken(CSQL.'h', 0); }
		public TerminalNode 'H'() { return getToken(CSQL.'H', 0); }
		public List<TerminalNode> 'e'() { return getTokens(CSQL.'e'); }
		public TerminalNode 'e'(int i) {
			return getToken(CSQL.'e', i);
		}
		public List<TerminalNode> 'E'() { return getTokens(CSQL.'E'); }
		public TerminalNode 'E'(int i) {
			return getToken(CSQL.'E', i);
		}
		public TerminalNode 'r'() { return getToken(CSQL.'r', 0); }
		public TerminalNode 'R'() { return getToken(CSQL.'R', 0); }
		public WsContext ws() {
			return getRuleContext(WsContext.class,0);
		}
		public KwhereContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_kwhere; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof CSQLListener ) ((CSQLListener)listener).enterKwhere(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof CSQLListener ) ((CSQLListener)listener).exitKwhere(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof CSQLVisitor ) return ((CSQLVisitor<? extends T>)visitor).visitKwhere(this);
			else return visitor.visitChildren(this);
		}
	}

	public final KwhereContext kwhere() throws RecognitionException {
		KwhereContext _localctx = new KwhereContext(_ctx, getState());
		enterRule(_localctx, 26, RULE_kwhere);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(229);
			if (!(notLetterOrDigit(6))) throw new FailedPredicateException(this, "notLetterOrDigit(6)");
			setState(230);
			_la = _input.LA(1);
			if ( !(_la=='W' || _la=='w') ) {
			_errHandler.recoverInline(this);
			}
			else {
				if ( _input.LA(1)==Token.EOF ) matchedEOF = true;
				_errHandler.reportMatch(this);
				consume();
			}
			setState(231);
			_la = _input.LA(1);
			if ( !(_la=='H' || _la=='h') ) {
			_errHandler.recoverInline(this);
			}
			else {
				if ( _input.LA(1)==Token.EOF ) matchedEOF = true;
				_errHandler.reportMatch(this);
				consume();
			}
			setState(232);
			_la = _input.LA(1);
			if ( !(_la=='E' || _la=='e') ) {
			_errHandler.recoverInline(this);
			}
			else {
				if ( _input.LA(1)==Token.EOF ) matchedEOF = true;
				_errHandler.reportMatch(this);
				consume();
			}
			setState(233);
			_la = _input.LA(1);
			if ( !(_la=='R' || _la=='r') ) {
			_errHandler.recoverInline(this);
			}
			else {
				if ( _input.LA(1)==Token.EOF ) matchedEOF = true;
				_errHandler.reportMatch(this);
				consume();
			}
			setState(234);
			_la = _input.LA(1);
			if ( !(_la=='E' || _la=='e') ) {
			_errHandler.recoverInline(this);
			}
			else {
				if ( _input.LA(1)==Token.EOF ) matchedEOF = true;
				_errHandler.reportMatch(this);
				consume();
			}
			setState(236);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if ((((_la) & ~0x3f) == 0 && ((1L << _la) & 140741783324160L) != 0)) {
				{
				setState(235);
				ws();
				}
			}

			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	@SuppressWarnings("CheckReturnValue")
	public static class KandContext extends ParserRuleContext {
		public TerminalNode 'a'() { return getToken(CSQL.'a', 0); }
		public TerminalNode 'A'() { return getToken(CSQL.'A', 0); }
		public TerminalNode 'n'() { return getToken(CSQL.'n', 0); }
		public TerminalNode 'N'() { return getToken(CSQL.'N', 0); }
		public TerminalNode 'd'() { return getToken(CSQL.'d', 0); }
		public TerminalNode 'D'() { return getToken(CSQL.'D', 0); }
		public WsContext ws() {
			return getRuleContext(WsContext.class,0);
		}
		public KandContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_kand; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof CSQLListener ) ((CSQLListener)listener).enterKand(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof CSQLListener ) ((CSQLListener)listener).exitKand(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof CSQLVisitor ) return ((CSQLVisitor<? extends T>)visitor).visitKand(this);
			else return visitor.visitChildren(this);
		}
	}

	public final KandContext kand() throws RecognitionException {
		KandContext _localctx = new KandContext(_ctx, getState());
		enterRule(_localctx, 28, RULE_kand);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(238);
			if (!(notLetterOrDigit(4))) throw new FailedPredicateException(this, "notLetterOrDigit(4)");
			setState(239);
			_la = _input.LA(1);
			if ( !(_la=='A' || _la=='a') ) {
			_errHandler.recoverInline(this);
			}
			else {
				if ( _input.LA(1)==Token.EOF ) matchedEOF = true;
				_errHandler.reportMatch(this);
				consume();
			}
			setState(240);
			_la = _input.LA(1);
			if ( !(_la=='N' || _la=='n') ) {
			_errHandler.recoverInline(this);
			}
			else {
				if ( _input.LA(1)==Token.EOF ) matchedEOF = true;
				_errHandler.reportMatch(this);
				consume();
			}
			setState(241);
			_la = _input.LA(1);
			if ( !(_la=='D' || _la=='d') ) {
			_errHandler.recoverInline(this);
			}
			else {
				if ( _input.LA(1)==Token.EOF ) matchedEOF = true;
				_errHandler.reportMatch(this);
				consume();
			}
			setState(243);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if ((((_la) & ~0x3f) == 0 && ((1L << _la) & 140741783324160L) != 0)) {
				{
				setState(242);
				ws();
				}
			}

			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	@SuppressWarnings("CheckReturnValue")
	public static class IdlistContext extends ParserRuleContext {
		public List<IdContext> id() {
			return getRuleContexts(IdContext.class);
		}
		public IdContext id(int i) {
			return getRuleContext(IdContext.class,i);
		}
		public List<TerminalNode> ','() { return getTokens(CSQL.','); }
		public TerminalNode ','(int i) {
			return getToken(CSQL.',', i);
		}
		public IdlistContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_idlist; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof CSQLListener ) ((CSQLListener)listener).enterIdlist(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof CSQLListener ) ((CSQLListener)listener).exitIdlist(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof CSQLVisitor ) return ((CSQLVisitor<? extends T>)visitor).visitIdlist(this);
			else return visitor.visitChildren(this);
		}
	}

	public final IdlistContext idlist() throws RecognitionException {
		IdlistContext _localctx = new IdlistContext(_ctx, getState());
		enterRule(_localctx, 30, RULE_idlist);
		try {
			int _alt;
			enterOuterAlt(_localctx, 1);
			{
			setState(245);
			id();
			setState(250);
			_errHandler.sync(this);
			_alt = getInterpreter().adaptivePredict(_input,21,_ctx);
			while ( _alt!=2 && _alt!=org.antlr.v4.runtime.atn.ATN.INVALID_ALT_NUMBER ) {
				if ( _alt==1 ) {
					{
					{
					setState(246);
					match(',');
					setState(247);
					id();
					}
					} 
				}
				setState(252);
				_errHandler.sync(this);
				_alt = getInterpreter().adaptivePredict(_input,21,_ctx);
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	@SuppressWarnings("CheckReturnValue")
	public static class SqlexprContext extends ParserRuleContext {
		public SqlstringContext sqlstring() {
			return getRuleContext(SqlstringContext.class,0);
		}
		public IdContext id() {
			return getRuleContext(IdContext.class,0);
		}
		public IntegerContext integer() {
			return getRuleContext(IntegerContext.class,0);
		}
		public SqlexprContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_sqlexpr; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof CSQLListener ) ((CSQLListener)listener).enterSqlexpr(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof CSQLListener ) ((CSQLListener)listener).exitSqlexpr(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof CSQLVisitor ) return ((CSQLVisitor<? extends T>)visitor).visitSqlexpr(this);
			else return visitor.visitChildren(this);
		}
	}

	public final SqlexprContext sqlexpr() throws RecognitionException {
		SqlexprContext _localctx = new SqlexprContext(_ctx, getState());
		enterRule(_localctx, 32, RULE_sqlexpr);
		try {
			setState(256);
			_errHandler.sync(this);
			switch (_input.LA(1)) {
			case '\'':
				enterOuterAlt(_localctx, 1);
				{
				setState(253);
				sqlstring();
				}
				break;
			case 'A':
			case 'B':
			case 'C':
			case 'D':
			case 'E':
			case 'F':
			case 'G':
			case 'H':
			case 'I':
			case 'J':
			case 'K':
			case 'L':
			case 'M':
			case 'N':
			case 'O':
			case 'P':
			case 'Q':
			case 'R':
			case 'S':
			case 'T':
			case 'U':
			case 'V':
			case 'W':
			case 'X':
			case 'Y':
			case 'Z':
			case 'a':
			case 'b':
			case 'c':
			case 'd':
			case 'e':
			case 'f':
			case 'g':
			case 'h':
			case 'i':
			case 'j':
			case 'k':
			case 'l':
			case 'm':
			case 'n':
			case 'o':
			case 'p':
			case 'q':
			case 'r':
			case 's':
			case 't':
			case 'u':
			case 'v':
			case 'w':
			case 'x':
			case 'y':
			case 'z':
				enterOuterAlt(_localctx, 2);
				{
				setState(254);
				id();
				}
				break;
			case '0':
			case '1':
			case '2':
			case '3':
			case '4':
			case '5':
			case '6':
			case '7':
			case '8':
			case '9':
				enterOuterAlt(_localctx, 3);
				{
				setState(255);
				integer();
				}
				break;
			default:
				throw new NoViableAltException(this);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	@SuppressWarnings("CheckReturnValue")
	public static class SqlstringContext extends ParserRuleContext {
		public List<SquoteContext> squote() {
			return getRuleContexts(SquoteContext.class);
		}
		public SquoteContext squote(int i) {
			return getRuleContext(SquoteContext.class,i);
		}
		public WsContext ws() {
			return getRuleContext(WsContext.class,0);
		}
		public List<TerminalNode> '\''() { return getTokens(CSQL.'\''); }
		public TerminalNode '\''(int i) {
			return getToken(CSQL.'\'', i);
		}
		public SqlstringContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_sqlstring; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof CSQLListener ) ((CSQLListener)listener).enterSqlstring(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof CSQLListener ) ((CSQLListener)listener).exitSqlstring(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof CSQLVisitor ) return ((CSQLVisitor<? extends T>)visitor).visitSqlstring(this);
			else return visitor.visitChildren(this);
		}
	}

	public final SqlstringContext sqlstring() throws RecognitionException {
		SqlstringContext _localctx = new SqlstringContext(_ctx, getState());
		enterRule(_localctx, 34, RULE_sqlstring);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(258);
			squote();
			setState(260); 
			_errHandler.sync(this);
			_la = _input.LA(1);
			do {
				{
				{
				setState(259);
				_la = _input.LA(1);
				if ( _la <= 0 || (_la=='\'') ) {
				_errHandler.recoverInline(this);
				}
				else {
					if ( _input.LA(1)==Token.EOF ) matchedEOF = true;
					_errHandler.reportMatch(this);
					consume();
				}
				}
				}
				setState(262); 
				_errHandler.sync(this);
				_la = _input.LA(1);
			} while ( (((_la) & ~0x3f) == 0 && ((1L << _la) & -549755813890L) != 0) || ((((_la - 64)) & ~0x3f) == 0 && ((1L << (_la - 64)) & 9223372036854775807L) != 0) );
			setState(264);
			squote();
			setState(266);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,24,_ctx) ) {
			case 1:
				{
				setState(265);
				ws();
				}
				break;
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	@SuppressWarnings("CheckReturnValue")
	public static class SqleqContext extends ParserRuleContext {
		public TerminalNode '='() { return getToken(CSQL.'=', 0); }
		public WsContext ws() {
			return getRuleContext(WsContext.class,0);
		}
		public SqleqContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_sqleq; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof CSQLListener ) ((CSQLListener)listener).enterSqleq(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof CSQLListener ) ((CSQLListener)listener).exitSqleq(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof CSQLVisitor ) return ((CSQLVisitor<? extends T>)visitor).visitSqleq(this);
			else return visitor.visitChildren(this);
		}
	}

	public final SqleqContext sqleq() throws RecognitionException {
		SqleqContext _localctx = new SqleqContext(_ctx, getState());
		enterRule(_localctx, 36, RULE_sqleq);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(268);
			match('=');
			setState(270);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if ((((_la) & ~0x3f) == 0 && ((1L << _la) & 140741783324160L) != 0)) {
				{
				setState(269);
				ws();
				}
			}

			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	@SuppressWarnings("CheckReturnValue")
	public static class SqlneqContext extends ParserRuleContext {
		public TerminalNode '<'() { return getToken(CSQL.'<', 0); }
		public TerminalNode '>'() { return getToken(CSQL.'>', 0); }
		public WsContext ws() {
			return getRuleContext(WsContext.class,0);
		}
		public SqlneqContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_sqlneq; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof CSQLListener ) ((CSQLListener)listener).enterSqlneq(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof CSQLListener ) ((CSQLListener)listener).exitSqlneq(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof CSQLVisitor ) return ((CSQLVisitor<? extends T>)visitor).visitSqlneq(this);
			else return visitor.visitChildren(this);
		}
	}

	public final SqlneqContext sqlneq() throws RecognitionException {
		SqlneqContext _localctx = new SqlneqContext(_ctx, getState());
		enterRule(_localctx, 38, RULE_sqlneq);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(272);
			match('<');
			setState(273);
			match('>');
			setState(275);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if ((((_la) & ~0x3f) == 0 && ((1L << _la) & 140741783324160L) != 0)) {
				{
				setState(274);
				ws();
				}
			}

			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	@SuppressWarnings("CheckReturnValue")
	public static class IdContext extends ParserRuleContext {
		public List<LetterContext> letter() {
			return getRuleContexts(LetterContext.class);
		}
		public LetterContext letter(int i) {
			return getRuleContext(LetterContext.class,i);
		}
		public WsContext ws() {
			return getRuleContext(WsContext.class,0);
		}
		public IdContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_id; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof CSQLListener ) ((CSQLListener)listener).enterId(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof CSQLListener ) ((CSQLListener)listener).exitId(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof CSQLVisitor ) return ((CSQLVisitor<? extends T>)visitor).visitId(this);
			else return visitor.visitChildren(this);
		}
	}

	public final IdContext id() throws RecognitionException {
		IdContext _localctx = new IdContext(_ctx, getState());
		enterRule(_localctx, 40, RULE_id);
		try {
			int _alt;
			enterOuterAlt(_localctx, 1);
			{
			setState(278); 
			_errHandler.sync(this);
			_alt = 1;
			do {
				switch (_alt) {
				case 1:
					{
					{
					setState(277);
					letter();
					}
					}
					break;
				default:
					throw new NoViableAltException(this);
				}
				setState(280); 
				_errHandler.sync(this);
				_alt = getInterpreter().adaptivePredict(_input,27,_ctx);
			} while ( _alt!=2 && _alt!=org.antlr.v4.runtime.atn.ATN.INVALID_ALT_NUMBER );
			setState(282);
			if (!(!keywords.contains(_input.getText(_localctx.start, _input.LT(-1))))) throw new FailedPredicateException(this, "!keywords.contains($text)");
			setState(284);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,28,_ctx) ) {
			case 1:
				{
				setState(283);
				ws();
				}
				break;
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	@SuppressWarnings("CheckReturnValue")
	public static class SquoteContext extends ParserRuleContext {
		public TerminalNode '\''() { return getToken(CSQL.'\'', 0); }
		public WsContext ws() {
			return getRuleContext(WsContext.class,0);
		}
		public SquoteContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_squote; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof CSQLListener ) ((CSQLListener)listener).enterSquote(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof CSQLListener ) ((CSQLListener)listener).exitSquote(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof CSQLVisitor ) return ((CSQLVisitor<? extends T>)visitor).visitSquote(this);
			else return visitor.visitChildren(this);
		}
	}

	public final SquoteContext squote() throws RecognitionException {
		SquoteContext _localctx = new SquoteContext(_ctx, getState());
		enterRule(_localctx, 42, RULE_squote);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(286);
			match('\'');
			setState(288);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,29,_ctx) ) {
			case 1:
				{
				setState(287);
				ws();
				}
				break;
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	@SuppressWarnings("CheckReturnValue")
	public static class LcContext extends ParserRuleContext {
		public TerminalNode '{'() { return getToken(CSQL.'{', 0); }
		public WsContext ws() {
			return getRuleContext(WsContext.class,0);
		}
		public LcContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_lc; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof CSQLListener ) ((CSQLListener)listener).enterLc(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof CSQLListener ) ((CSQLListener)listener).exitLc(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof CSQLVisitor ) return ((CSQLVisitor<? extends T>)visitor).visitLc(this);
			else return visitor.visitChildren(this);
		}
	}

	public final LcContext lc() throws RecognitionException {
		LcContext _localctx = new LcContext(_ctx, getState());
		enterRule(_localctx, 44, RULE_lc);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(290);
			match('{');
			setState(292);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,30,_ctx) ) {
			case 1:
				{
				setState(291);
				ws();
				}
				break;
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	@SuppressWarnings("CheckReturnValue")
	public static class RcContext extends ParserRuleContext {
		public TerminalNode '}'() { return getToken(CSQL.'}', 0); }
		public WsContext ws() {
			return getRuleContext(WsContext.class,0);
		}
		public RcContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_rc; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof CSQLListener ) ((CSQLListener)listener).enterRc(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof CSQLListener ) ((CSQLListener)listener).exitRc(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof CSQLVisitor ) return ((CSQLVisitor<? extends T>)visitor).visitRc(this);
			else return visitor.visitChildren(this);
		}
	}

	public final RcContext rc() throws RecognitionException {
		RcContext _localctx = new RcContext(_ctx, getState());
		enterRule(_localctx, 46, RULE_rc);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(294);
			match('}');
			setState(296);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,31,_ctx) ) {
			case 1:
				{
				setState(295);
				ws();
				}
				break;
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	@SuppressWarnings("CheckReturnValue")
	public static class LpContext extends ParserRuleContext {
		public TerminalNode '('() { return getToken(CSQL.'(', 0); }
		public WsContext ws() {
			return getRuleContext(WsContext.class,0);
		}
		public LpContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_lp; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof CSQLListener ) ((CSQLListener)listener).enterLp(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof CSQLListener ) ((CSQLListener)listener).exitLp(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof CSQLVisitor ) return ((CSQLVisitor<? extends T>)visitor).visitLp(this);
			else return visitor.visitChildren(this);
		}
	}

	public final LpContext lp() throws RecognitionException {
		LpContext _localctx = new LpContext(_ctx, getState());
		enterRule(_localctx, 48, RULE_lp);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(298);
			match('(');
			setState(300);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,32,_ctx) ) {
			case 1:
				{
				setState(299);
				ws();
				}
				break;
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	@SuppressWarnings("CheckReturnValue")
	public static class RpContext extends ParserRuleContext {
		public TerminalNode ')'() { return getToken(CSQL.')', 0); }
		public WsContext ws() {
			return getRuleContext(WsContext.class,0);
		}
		public RpContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_rp; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof CSQLListener ) ((CSQLListener)listener).enterRp(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof CSQLListener ) ((CSQLListener)listener).exitRp(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof CSQLVisitor ) return ((CSQLVisitor<? extends T>)visitor).visitRp(this);
			else return visitor.visitChildren(this);
		}
	}

	public final RpContext rp() throws RecognitionException {
		RpContext _localctx = new RpContext(_ctx, getState());
		enterRule(_localctx, 50, RULE_rp);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(302);
			match(')');
			setState(304);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if ((((_la) & ~0x3f) == 0 && ((1L << _la) & 140741783324160L) != 0)) {
				{
				setState(303);
				ws();
				}
			}

			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	@SuppressWarnings("CheckReturnValue")
	public static class StarContext extends ParserRuleContext {
		public TerminalNode '*'() { return getToken(CSQL.'*', 0); }
		public WsContext ws() {
			return getRuleContext(WsContext.class,0);
		}
		public StarContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_star; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof CSQLListener ) ((CSQLListener)listener).enterStar(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof CSQLListener ) ((CSQLListener)listener).exitStar(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof CSQLVisitor ) return ((CSQLVisitor<? extends T>)visitor).visitStar(this);
			else return visitor.visitChildren(this);
		}
	}

	public final StarContext star() throws RecognitionException {
		StarContext _localctx = new StarContext(_ctx, getState());
		enterRule(_localctx, 52, RULE_star);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(306);
			match('*');
			setState(308);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,34,_ctx) ) {
			case 1:
				{
				setState(307);
				ws();
				}
				break;
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	@SuppressWarnings("CheckReturnValue")
	public static class PlusContext extends ParserRuleContext {
		public TerminalNode '+'() { return getToken(CSQL.'+', 0); }
		public WsContext ws() {
			return getRuleContext(WsContext.class,0);
		}
		public PlusContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_plus; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof CSQLListener ) ((CSQLListener)listener).enterPlus(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof CSQLListener ) ((CSQLListener)listener).exitPlus(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof CSQLVisitor ) return ((CSQLVisitor<? extends T>)visitor).visitPlus(this);
			else return visitor.visitChildren(this);
		}
	}

	public final PlusContext plus() throws RecognitionException {
		PlusContext _localctx = new PlusContext(_ctx, getState());
		enterRule(_localctx, 54, RULE_plus);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(310);
			match('+');
			setState(312);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,35,_ctx) ) {
			case 1:
				{
				setState(311);
				ws();
				}
				break;
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	@SuppressWarnings("CheckReturnValue")
	public static class AssContext extends ParserRuleContext {
		public TerminalNode '='() { return getToken(CSQL.'=', 0); }
		public WsContext ws() {
			return getRuleContext(WsContext.class,0);
		}
		public AssContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_ass; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof CSQLListener ) ((CSQLListener)listener).enterAss(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof CSQLListener ) ((CSQLListener)listener).exitAss(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof CSQLVisitor ) return ((CSQLVisitor<? extends T>)visitor).visitAss(this);
			else return visitor.visitChildren(this);
		}
	}

	public final AssContext ass() throws RecognitionException {
		AssContext _localctx = new AssContext(_ctx, getState());
		enterRule(_localctx, 56, RULE_ass);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(314);
			match('=');
			setState(316);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,36,_ctx) ) {
			case 1:
				{
				setState(315);
				ws();
				}
				break;
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	@SuppressWarnings("CheckReturnValue")
	public static class EqContext extends ParserRuleContext {
		public List<TerminalNode> '='() { return getTokens(CSQL.'='); }
		public TerminalNode '='(int i) {
			return getToken(CSQL.'=', i);
		}
		public WsContext ws() {
			return getRuleContext(WsContext.class,0);
		}
		public EqContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_eq; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof CSQLListener ) ((CSQLListener)listener).enterEq(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof CSQLListener ) ((CSQLListener)listener).exitEq(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof CSQLVisitor ) return ((CSQLVisitor<? extends T>)visitor).visitEq(this);
			else return visitor.visitChildren(this);
		}
	}

	public final EqContext eq() throws RecognitionException {
		EqContext _localctx = new EqContext(_ctx, getState());
		enterRule(_localctx, 58, RULE_eq);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(318);
			match('=');
			setState(319);
			match('=');
			setState(321);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,37,_ctx) ) {
			case 1:
				{
				setState(320);
				ws();
				}
				break;
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	@SuppressWarnings("CheckReturnValue")
	public static class NeqContext extends ParserRuleContext {
		public TerminalNode '!'() { return getToken(CSQL.'!', 0); }
		public TerminalNode '='() { return getToken(CSQL.'=', 0); }
		public WsContext ws() {
			return getRuleContext(WsContext.class,0);
		}
		public NeqContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_neq; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof CSQLListener ) ((CSQLListener)listener).enterNeq(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof CSQLListener ) ((CSQLListener)listener).exitNeq(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof CSQLVisitor ) return ((CSQLVisitor<? extends T>)visitor).visitNeq(this);
			else return visitor.visitChildren(this);
		}
	}

	public final NeqContext neq() throws RecognitionException {
		NeqContext _localctx = new NeqContext(_ctx, getState());
		enterRule(_localctx, 60, RULE_neq);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(323);
			match('!');
			setState(324);
			match('=');
			setState(326);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,38,_ctx) ) {
			case 1:
				{
				setState(325);
				ws();
				}
				break;
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	@SuppressWarnings("CheckReturnValue")
	public static class ColonContext extends ParserRuleContext {
		public TerminalNode ':'() { return getToken(CSQL.':', 0); }
		public WsContext ws() {
			return getRuleContext(WsContext.class,0);
		}
		public ColonContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_colon; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof CSQLListener ) ((CSQLListener)listener).enterColon(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof CSQLListener ) ((CSQLListener)listener).exitColon(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof CSQLVisitor ) return ((CSQLVisitor<? extends T>)visitor).visitColon(this);
			else return visitor.visitChildren(this);
		}
	}

	public final ColonContext colon() throws RecognitionException {
		ColonContext _localctx = new ColonContext(_ctx, getState());
		enterRule(_localctx, 62, RULE_colon);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(328);
			match(':');
			setState(330);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,39,_ctx) ) {
			case 1:
				{
				setState(329);
				ws();
				}
				break;
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	@SuppressWarnings("CheckReturnValue")
	public static class SemiContext extends ParserRuleContext {
		public TerminalNode ';'() { return getToken(CSQL.';', 0); }
		public WsContext ws() {
			return getRuleContext(WsContext.class,0);
		}
		public SemiContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_semi; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof CSQLListener ) ((CSQLListener)listener).enterSemi(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof CSQLListener ) ((CSQLListener)listener).exitSemi(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof CSQLVisitor ) return ((CSQLVisitor<? extends T>)visitor).visitSemi(this);
			else return visitor.visitChildren(this);
		}
	}

	public final SemiContext semi() throws RecognitionException {
		SemiContext _localctx = new SemiContext(_ctx, getState());
		enterRule(_localctx, 64, RULE_semi);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(332);
			match(';');
			setState(334);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,40,_ctx) ) {
			case 1:
				{
				setState(333);
				ws();
				}
				break;
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	@SuppressWarnings("CheckReturnValue")
	public static class KintContext extends ParserRuleContext {
		public TerminalNode 'i'() { return getToken(CSQL.'i', 0); }
		public TerminalNode 'n'() { return getToken(CSQL.'n', 0); }
		public TerminalNode 't'() { return getToken(CSQL.'t', 0); }
		public WsContext ws() {
			return getRuleContext(WsContext.class,0);
		}
		public KintContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_kint; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof CSQLListener ) ((CSQLListener)listener).enterKint(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof CSQLListener ) ((CSQLListener)listener).exitKint(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof CSQLVisitor ) return ((CSQLVisitor<? extends T>)visitor).visitKint(this);
			else return visitor.visitChildren(this);
		}
	}

	public final KintContext kint() throws RecognitionException {
		KintContext _localctx = new KintContext(_ctx, getState());
		enterRule(_localctx, 66, RULE_kint);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(336);
			if (!(notLetterOrDigit(4))) throw new FailedPredicateException(this, "notLetterOrDigit(4)");
			setState(337);
			match('i');
			setState(338);
			match('n');
			setState(339);
			match('t');
			setState(341);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if ((((_la) & ~0x3f) == 0 && ((1L << _la) & 140741783324160L) != 0)) {
				{
				setState(340);
				ws();
				}
			}

			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	@SuppressWarnings("CheckReturnValue")
	public static class KvoidContext extends ParserRuleContext {
		public TerminalNode 'v'() { return getToken(CSQL.'v', 0); }
		public TerminalNode 'o'() { return getToken(CSQL.'o', 0); }
		public TerminalNode 'i'() { return getToken(CSQL.'i', 0); }
		public TerminalNode 'd'() { return getToken(CSQL.'d', 0); }
		public WsContext ws() {
			return getRuleContext(WsContext.class,0);
		}
		public KvoidContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_kvoid; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof CSQLListener ) ((CSQLListener)listener).enterKvoid(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof CSQLListener ) ((CSQLListener)listener).exitKvoid(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof CSQLVisitor ) return ((CSQLVisitor<? extends T>)visitor).visitKvoid(this);
			else return visitor.visitChildren(this);
		}
	}

	public final KvoidContext kvoid() throws RecognitionException {
		KvoidContext _localctx = new KvoidContext(_ctx, getState());
		enterRule(_localctx, 68, RULE_kvoid);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(343);
			if (!(notLetterOrDigit(5))) throw new FailedPredicateException(this, "notLetterOrDigit(5)");
			setState(344);
			match('v');
			setState(345);
			match('o');
			setState(346);
			match('i');
			setState(347);
			match('d');
			setState(349);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if ((((_la) & ~0x3f) == 0 && ((1L << _la) & 140741783324160L) != 0)) {
				{
				setState(348);
				ws();
				}
			}

			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	@SuppressWarnings("CheckReturnValue")
	public static class KreturnContext extends ParserRuleContext {
		public List<TerminalNode> 'r'() { return getTokens(CSQL.'r'); }
		public TerminalNode 'r'(int i) {
			return getToken(CSQL.'r', i);
		}
		public TerminalNode 'e'() { return getToken(CSQL.'e', 0); }
		public TerminalNode 't'() { return getToken(CSQL.'t', 0); }
		public TerminalNode 'u'() { return getToken(CSQL.'u', 0); }
		public TerminalNode 'n'() { return getToken(CSQL.'n', 0); }
		public WsContext ws() {
			return getRuleContext(WsContext.class,0);
		}
		public KreturnContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_kreturn; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof CSQLListener ) ((CSQLListener)listener).enterKreturn(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof CSQLListener ) ((CSQLListener)listener).exitKreturn(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof CSQLVisitor ) return ((CSQLVisitor<? extends T>)visitor).visitKreturn(this);
			else return visitor.visitChildren(this);
		}
	}

	public final KreturnContext kreturn() throws RecognitionException {
		KreturnContext _localctx = new KreturnContext(_ctx, getState());
		enterRule(_localctx, 70, RULE_kreturn);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(351);
			if (!(notLetterOrDigit(7))) throw new FailedPredicateException(this, "notLetterOrDigit(7)");
			setState(352);
			match('r');
			setState(353);
			match('e');
			setState(354);
			match('t');
			setState(355);
			match('u');
			setState(356);
			match('r');
			setState(357);
			match('n');
			setState(359);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,43,_ctx) ) {
			case 1:
				{
				setState(358);
				ws();
				}
				break;
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	@SuppressWarnings("CheckReturnValue")
	public static class CcharContext extends ParserRuleContext {
		public List<SquoteContext> squote() {
			return getRuleContexts(SquoteContext.class);
		}
		public SquoteContext squote(int i) {
			return getRuleContext(SquoteContext.class,i);
		}
		public WsContext ws() {
			return getRuleContext(WsContext.class,0);
		}
		public CcharContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_cchar; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof CSQLListener ) ((CSQLListener)listener).enterCchar(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof CSQLListener ) ((CSQLListener)listener).exitCchar(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof CSQLVisitor ) return ((CSQLVisitor<? extends T>)visitor).visitCchar(this);
			else return visitor.visitChildren(this);
		}
	}

	public final CcharContext cchar() throws RecognitionException {
		CcharContext _localctx = new CcharContext(_ctx, getState());
		enterRule(_localctx, 72, RULE_cchar);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(361);
			squote();
			setState(362);
			matchWildcard();
			setState(363);
			squote();
			setState(365);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,44,_ctx) ) {
			case 1:
				{
				setState(364);
				ws();
				}
				break;
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	@SuppressWarnings("CheckReturnValue")
	public static class IntegerContext extends ParserRuleContext {
		public List<DigitContext> digit() {
			return getRuleContexts(DigitContext.class);
		}
		public DigitContext digit(int i) {
			return getRuleContext(DigitContext.class,i);
		}
		public WsContext ws() {
			return getRuleContext(WsContext.class,0);
		}
		public IntegerContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_integer; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof CSQLListener ) ((CSQLListener)listener).enterInteger(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof CSQLListener ) ((CSQLListener)listener).exitInteger(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof CSQLVisitor ) return ((CSQLVisitor<? extends T>)visitor).visitInteger(this);
			else return visitor.visitChildren(this);
		}
	}

	public final IntegerContext integer() throws RecognitionException {
		IntegerContext _localctx = new IntegerContext(_ctx, getState());
		enterRule(_localctx, 74, RULE_integer);
		try {
			int _alt;
			enterOuterAlt(_localctx, 1);
			{
			setState(368); 
			_errHandler.sync(this);
			_alt = 1;
			do {
				switch (_alt) {
				case 1:
					{
					{
					setState(367);
					digit();
					}
					}
					break;
				default:
					throw new NoViableAltException(this);
				}
				setState(370); 
				_errHandler.sync(this);
				_alt = getInterpreter().adaptivePredict(_input,45,_ctx);
			} while ( _alt!=2 && _alt!=org.antlr.v4.runtime.atn.ATN.INVALID_ALT_NUMBER );
			setState(373);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,46,_ctx) ) {
			case 1:
				{
				setState(372);
				ws();
				}
				break;
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	@SuppressWarnings("CheckReturnValue")
	public static class DigitContext extends ParserRuleContext {
		public TerminalNode '0'() { return getToken(CSQL.'0', 0); }
		public TerminalNode '1'() { return getToken(CSQL.'1', 0); }
		public TerminalNode '2'() { return getToken(CSQL.'2', 0); }
		public TerminalNode '3'() { return getToken(CSQL.'3', 0); }
		public TerminalNode '4'() { return getToken(CSQL.'4', 0); }
		public TerminalNode '5'() { return getToken(CSQL.'5', 0); }
		public TerminalNode '6'() { return getToken(CSQL.'6', 0); }
		public TerminalNode '7'() { return getToken(CSQL.'7', 0); }
		public TerminalNode '8'() { return getToken(CSQL.'8', 0); }
		public TerminalNode '9'() { return getToken(CSQL.'9', 0); }
		public DigitContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_digit; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof CSQLListener ) ((CSQLListener)listener).enterDigit(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof CSQLListener ) ((CSQLListener)listener).exitDigit(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof CSQLVisitor ) return ((CSQLVisitor<? extends T>)visitor).visitDigit(this);
			else return visitor.visitChildren(this);
		}
	}

	public final DigitContext digit() throws RecognitionException {
		DigitContext _localctx = new DigitContext(_ctx, getState());
		enterRule(_localctx, 76, RULE_digit);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(375);
			_la = _input.LA(1);
			if ( !((((_la) & ~0x3f) == 0 && ((1L << _la) & 287948901175001088L) != 0)) ) {
			_errHandler.recoverInline(this);
			}
			else {
				if ( _input.LA(1)==Token.EOF ) matchedEOF = true;
				_errHandler.reportMatch(this);
				consume();
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	@SuppressWarnings("CheckReturnValue")
	public static class LetterContext extends ParserRuleContext {
		public TerminalNode 'a'() { return getToken(CSQL.'a', 0); }
		public TerminalNode 'b'() { return getToken(CSQL.'b', 0); }
		public TerminalNode 'c'() { return getToken(CSQL.'c', 0); }
		public TerminalNode 'd'() { return getToken(CSQL.'d', 0); }
		public TerminalNode 'e'() { return getToken(CSQL.'e', 0); }
		public TerminalNode 'f'() { return getToken(CSQL.'f', 0); }
		public TerminalNode 'g'() { return getToken(CSQL.'g', 0); }
		public TerminalNode 'h'() { return getToken(CSQL.'h', 0); }
		public TerminalNode 'i'() { return getToken(CSQL.'i', 0); }
		public TerminalNode 'j'() { return getToken(CSQL.'j', 0); }
		public TerminalNode 'k'() { return getToken(CSQL.'k', 0); }
		public TerminalNode 'l'() { return getToken(CSQL.'l', 0); }
		public TerminalNode 'm'() { return getToken(CSQL.'m', 0); }
		public TerminalNode 'n'() { return getToken(CSQL.'n', 0); }
		public TerminalNode 'o'() { return getToken(CSQL.'o', 0); }
		public TerminalNode 'p'() { return getToken(CSQL.'p', 0); }
		public TerminalNode 'q'() { return getToken(CSQL.'q', 0); }
		public TerminalNode 'r'() { return getToken(CSQL.'r', 0); }
		public TerminalNode 's'() { return getToken(CSQL.'s', 0); }
		public TerminalNode 't'() { return getToken(CSQL.'t', 0); }
		public TerminalNode 'u'() { return getToken(CSQL.'u', 0); }
		public TerminalNode 'v'() { return getToken(CSQL.'v', 0); }
		public TerminalNode 'w'() { return getToken(CSQL.'w', 0); }
		public TerminalNode 'x'() { return getToken(CSQL.'x', 0); }
		public TerminalNode 'y'() { return getToken(CSQL.'y', 0); }
		public TerminalNode 'z'() { return getToken(CSQL.'z', 0); }
		public TerminalNode 'A'() { return getToken(CSQL.'A', 0); }
		public TerminalNode 'B'() { return getToken(CSQL.'B', 0); }
		public TerminalNode 'C'() { return getToken(CSQL.'C', 0); }
		public TerminalNode 'D'() { return getToken(CSQL.'D', 0); }
		public TerminalNode 'E'() { return getToken(CSQL.'E', 0); }
		public TerminalNode 'F'() { return getToken(CSQL.'F', 0); }
		public TerminalNode 'G'() { return getToken(CSQL.'G', 0); }
		public TerminalNode 'H'() { return getToken(CSQL.'H', 0); }
		public TerminalNode 'I'() { return getToken(CSQL.'I', 0); }
		public TerminalNode 'J'() { return getToken(CSQL.'J', 0); }
		public TerminalNode 'K'() { return getToken(CSQL.'K', 0); }
		public TerminalNode 'L'() { return getToken(CSQL.'L', 0); }
		public TerminalNode 'M'() { return getToken(CSQL.'M', 0); }
		public TerminalNode 'N'() { return getToken(CSQL.'N', 0); }
		public TerminalNode 'O'() { return getToken(CSQL.'O', 0); }
		public TerminalNode 'P'() { return getToken(CSQL.'P', 0); }
		public TerminalNode 'Q'() { return getToken(CSQL.'Q', 0); }
		public TerminalNode 'R'() { return getToken(CSQL.'R', 0); }
		public TerminalNode 'S'() { return getToken(CSQL.'S', 0); }
		public TerminalNode 'T'() { return getToken(CSQL.'T', 0); }
		public TerminalNode 'U'() { return getToken(CSQL.'U', 0); }
		public TerminalNode 'V'() { return getToken(CSQL.'V', 0); }
		public TerminalNode 'W'() { return getToken(CSQL.'W', 0); }
		public TerminalNode 'X'() { return getToken(CSQL.'X', 0); }
		public TerminalNode 'Y'() { return getToken(CSQL.'Y', 0); }
		public TerminalNode 'Z'() { return getToken(CSQL.'Z', 0); }
		public LetterContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_letter; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof CSQLListener ) ((CSQLListener)listener).enterLetter(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof CSQLListener ) ((CSQLListener)listener).exitLetter(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof CSQLVisitor ) return ((CSQLVisitor<? extends T>)visitor).visitLetter(this);
			else return visitor.visitChildren(this);
		}
	}

	public final LetterContext letter() throws RecognitionException {
		LetterContext _localctx = new LetterContext(_ctx, getState());
		enterRule(_localctx, 78, RULE_letter);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(377);
			_la = _input.LA(1);
			if ( !(((((_la - 65)) & ~0x3f) == 0 && ((1L << (_la - 65)) & 288230371923853311L) != 0)) ) {
			_errHandler.recoverInline(this);
			}
			else {
				if ( _input.LA(1)==Token.EOF ) matchedEOF = true;
				_errHandler.reportMatch(this);
				consume();
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	@SuppressWarnings("CheckReturnValue")
	public static class WsContext extends ParserRuleContext {
		public List<TerminalNode> ' '() { return getTokens(CSQL.' '); }
		public TerminalNode ' '(int i) {
			return getToken(CSQL.' ', i);
		}
		public List<TerminalNode> '\t'() { return getTokens(CSQL.'\t'); }
		public TerminalNode '\t'(int i) {
			return getToken(CSQL.'\t', i);
		}
		public List<TerminalNode> '\n'() { return getTokens(CSQL.'\n'); }
		public TerminalNode '\n'(int i) {
			return getToken(CSQL.'\n', i);
		}
		public List<CommentContext> comment() {
			return getRuleContexts(CommentContext.class);
		}
		public CommentContext comment(int i) {
			return getRuleContext(CommentContext.class,i);
		}
		public WsContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_ws; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof CSQLListener ) ((CSQLListener)listener).enterWs(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof CSQLListener ) ((CSQLListener)listener).exitWs(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof CSQLVisitor ) return ((CSQLVisitor<? extends T>)visitor).visitWs(this);
			else return visitor.visitChildren(this);
		}
	}

	public final WsContext ws() throws RecognitionException {
		WsContext _localctx = new WsContext(_ctx, getState());
		enterRule(_localctx, 80, RULE_ws);
		try {
			int _alt;
			enterOuterAlt(_localctx, 1);
			{
			setState(383); 
			_errHandler.sync(this);
			_alt = 1;
			do {
				switch (_alt) {
				case 1:
					{
					setState(383);
					_errHandler.sync(this);
					switch (_input.LA(1)) {
					case ' ':
						{
						setState(379);
						match(' ');
						}
						break;
					case '\t':
						{
						setState(380);
						match('\t');
						}
						break;
					case '\n':
						{
						setState(381);
						match('\n');
						}
						break;
					case '/':
						{
						setState(382);
						comment();
						}
						break;
					default:
						throw new NoViableAltException(this);
					}
					}
					break;
				default:
					throw new NoViableAltException(this);
				}
				setState(385); 
				_errHandler.sync(this);
				_alt = getInterpreter().adaptivePredict(_input,48,_ctx);
			} while ( _alt!=2 && _alt!=org.antlr.v4.runtime.atn.ATN.INVALID_ALT_NUMBER );
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	@SuppressWarnings("CheckReturnValue")
	public static class CommentContext extends ParserRuleContext {
		public List<TerminalNode> '/'() { return getTokens(CSQL.'/'); }
		public TerminalNode '/'(int i) {
			return getToken(CSQL.'/', i);
		}
		public List<TerminalNode> '\n'() { return getTokens(CSQL.'\n'); }
		public TerminalNode '\n'(int i) {
			return getToken(CSQL.'\n', i);
		}
		public List<TerminalNode> '\r'() { return getTokens(CSQL.'\r'); }
		public TerminalNode '\r'(int i) {
			return getToken(CSQL.'\r', i);
		}
		public CommentContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_comment; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof CSQLListener ) ((CSQLListener)listener).enterComment(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof CSQLListener ) ((CSQLListener)listener).exitComment(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof CSQLVisitor ) return ((CSQLVisitor<? extends T>)visitor).visitComment(this);
			else return visitor.visitChildren(this);
		}
	}

	public final CommentContext comment() throws RecognitionException {
		CommentContext _localctx = new CommentContext(_ctx, getState());
		enterRule(_localctx, 82, RULE_comment);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(387);
			match('/');
			setState(388);
			match('/');
			setState(392);
			_errHandler.sync(this);
			_la = _input.LA(1);
			while ((((_la) & ~0x3f) == 0 && ((1L << _la) & -9218L) != 0) || ((((_la - 64)) & ~0x3f) == 0 && ((1L << (_la - 64)) & 9223372036854775807L) != 0)) {
				{
				{
				setState(389);
				_la = _input.LA(1);
				if ( _la <= 0 || (_la=='\n' || _la=='\r') ) {
				_errHandler.recoverInline(this);
				}
				else {
					if ( _input.LA(1)==Token.EOF ) matchedEOF = true;
					_errHandler.reportMatch(this);
					consume();
				}
				}
				}
				setState(394);
				_errHandler.sync(this);
				_la = _input.LA(1);
			}
			setState(396);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if (_la=='\r') {
				{
				setState(395);
				match('\r');
				}
			}

			setState(398);
			match('\n');
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public boolean sempred(RuleContext _localctx, int ruleIndex, int predIndex) {
		switch (ruleIndex) {
		case 8:
			return expr_sempred((ExprContext)_localctx, predIndex);
		case 10:
			return condition_sempred((ConditionContext)_localctx, predIndex);
		case 11:
			return kselect_sempred((KselectContext)_localctx, predIndex);
		case 12:
			return kfrom_sempred((KfromContext)_localctx, predIndex);
		case 13:
			return kwhere_sempred((KwhereContext)_localctx, predIndex);
		case 14:
			return kand_sempred((KandContext)_localctx, predIndex);
		case 20:
			return id_sempred((IdContext)_localctx, predIndex);
		case 33:
			return kint_sempred((KintContext)_localctx, predIndex);
		case 34:
			return kvoid_sempred((KvoidContext)_localctx, predIndex);
		case 35:
			return kreturn_sempred((KreturnContext)_localctx, predIndex);
		}
		return true;
	}
	private boolean expr_sempred(ExprContext _localctx, int predIndex) {
		switch (predIndex) {
		case 0:
			return precpred(_ctx, 7);
		case 1:
			return precpred(_ctx, 6);
		case 2:
			return precpred(_ctx, 5);
		}
		return true;
	}
	private boolean condition_sempred(ConditionContext _localctx, int predIndex) {
		switch (predIndex) {
		case 3:
			return precpred(_ctx, 3);
		}
		return true;
	}
	private boolean kselect_sempred(KselectContext _localctx, int predIndex) {
		switch (predIndex) {
		case 4:
			return notLetterOrDigit(7);
		}
		return true;
	}
	private boolean kfrom_sempred(KfromContext _localctx, int predIndex) {
		switch (predIndex) {
		case 5:
			return notLetterOrDigit(5);
		}
		return true;
	}
	private boolean kwhere_sempred(KwhereContext _localctx, int predIndex) {
		switch (predIndex) {
		case 6:
			return notLetterOrDigit(6);
		}
		return true;
	}
	private boolean kand_sempred(KandContext _localctx, int predIndex) {
		switch (predIndex) {
		case 7:
			return notLetterOrDigit(4);
		}
		return true;
	}
	private boolean id_sempred(IdContext _localctx, int predIndex) {
		switch (predIndex) {
		case 8:
			return !keywords.contains(_input.getText(_localctx.start, _input.LT(-1)));
		}
		return true;
	}
	private boolean kint_sempred(KintContext _localctx, int predIndex) {
		switch (predIndex) {
		case 9:
			return notLetterOrDigit(4);
		}
		return true;
	}
	private boolean kvoid_sempred(KvoidContext _localctx, int predIndex) {
		switch (predIndex) {
		case 10:
			return notLetterOrDigit(5);
		}
		return true;
	}
	private boolean kreturn_sempred(KreturnContext _localctx, int predIndex) {
		switch (predIndex) {
		case 11:
			return notLetterOrDigit(7);
		}
		return true;
	}

	public static final String _serializedATN =
		"\u0004\u0001~\u0191\u0002\u0000\u0007\u0000\u0002\u0001\u0007\u0001\u0002"+
		"\u0002\u0007\u0002\u0002\u0003\u0007\u0003\u0002\u0004\u0007\u0004\u0002"+
		"\u0005\u0007\u0005\u0002\u0006\u0007\u0006\u0002\u0007\u0007\u0007\u0002"+
		"\b\u0007\b\u0002\t\u0007\t\u0002\n\u0007\n\u0002\u000b\u0007\u000b\u0002"+
		"\f\u0007\f\u0002\r\u0007\r\u0002\u000e\u0007\u000e\u0002\u000f\u0007\u000f"+
		"\u0002\u0010\u0007\u0010\u0002\u0011\u0007\u0011\u0002\u0012\u0007\u0012"+
		"\u0002\u0013\u0007\u0013\u0002\u0014\u0007\u0014\u0002\u0015\u0007\u0015"+
		"\u0002\u0016\u0007\u0016\u0002\u0017\u0007\u0017\u0002\u0018\u0007\u0018"+
		"\u0002\u0019\u0007\u0019\u0002\u001a\u0007\u001a\u0002\u001b\u0007\u001b"+
		"\u0002\u001c\u0007\u001c\u0002\u001d\u0007\u001d\u0002\u001e\u0007\u001e"+
		"\u0002\u001f\u0007\u001f\u0002 \u0007 \u0002!\u0007!\u0002\"\u0007\"\u0002"+
		"#\u0007#\u0002$\u0007$\u0002%\u0007%\u0002&\u0007&\u0002\'\u0007\'\u0002"+
		"(\u0007(\u0002)\u0007)\u0001\u0000\u0003\u0000V\b\u0000\u0001\u0000\u0001"+
		"\u0000\u0004\u0000Z\b\u0000\u000b\u0000\f\u0000[\u0001\u0000\u0001\u0000"+
		"\u0001\u0001\u0001\u0001\u0001\u0001\u0003\u0001c\b\u0001\u0001\u0002"+
		"\u0001\u0002\u0001\u0002\u0001\u0002\u0001\u0002\u0003\u0002j\b\u0002"+
		"\u0001\u0002\u0001\u0002\u0001\u0003\u0001\u0003\u0001\u0003\u0001\u0003"+
		"\u0003\u0003r\b\u0003\u0001\u0003\u0001\u0003\u0001\u0003\u0001\u0004"+
		"\u0001\u0004\u0001\u0004\u0005\u0004z\b\u0004\n\u0004\f\u0004}\t\u0004"+
		"\u0001\u0005\u0001\u0005\u0001\u0005\u0001\u0006\u0001\u0006\u0004\u0006"+
		"\u0084\b\u0006\u000b\u0006\f\u0006\u0085\u0001\u0006\u0001\u0006\u0001"+
		"\u0007\u0001\u0007\u0001\u0007\u0001\u0007\u0001\u0007\u0001\u0007\u0001"+
		"\u0007\u0001\u0007\u0001\u0007\u0001\u0007\u0001\u0007\u0001\u0007\u0001"+
		"\u0007\u0003\u0007\u0097\b\u0007\u0001\b\u0001\b\u0001\b\u0001\b\u0001"+
		"\b\u0003\b\u009e\b\b\u0001\b\u0001\b\u0001\b\u0003\b\u00a3\b\b\u0001\b"+
		"\u0001\b\u0001\b\u0001\b\u0001\b\u0001\b\u0001\b\u0001\b\u0001\b\u0001"+
		"\b\u0005\b\u00af\b\b\n\b\f\b\u00b2\t\b\u0001\t\u0001\t\u0001\t\u0003\t"+
		"\u00b7\b\t\u0001\t\u0001\t\u0001\t\u0001\t\u0001\t\u0003\t\u00be\b\t\u0001"+
		"\n\u0001\n\u0001\n\u0001\n\u0001\n\u0001\n\u0001\n\u0001\n\u0001\n\u0003"+
		"\n\u00c9\b\n\u0001\n\u0001\n\u0001\n\u0001\n\u0005\n\u00cf\b\n\n\n\f\n"+
		"\u00d2\t\n\u0001\u000b\u0001\u000b\u0001\u000b\u0001\u000b\u0001\u000b"+
		"\u0001\u000b\u0001\u000b\u0001\u000b\u0003\u000b\u00dc\b\u000b\u0001\f"+
		"\u0001\f\u0001\f\u0001\f\u0001\f\u0001\f\u0003\f\u00e4\b\f\u0001\r\u0001"+
		"\r\u0001\r\u0001\r\u0001\r\u0001\r\u0001\r\u0003\r\u00ed\b\r\u0001\u000e"+
		"\u0001\u000e\u0001\u000e\u0001\u000e\u0001\u000e\u0003\u000e\u00f4\b\u000e"+
		"\u0001\u000f\u0001\u000f\u0001\u000f\u0005\u000f\u00f9\b\u000f\n\u000f"+
		"\f\u000f\u00fc\t\u000f\u0001\u0010\u0001\u0010\u0001\u0010\u0003\u0010"+
		"\u0101\b\u0010\u0001\u0011\u0001\u0011\u0004\u0011\u0105\b\u0011\u000b"+
		"\u0011\f\u0011\u0106\u0001\u0011\u0001\u0011\u0003\u0011\u010b\b\u0011"+
		"\u0001\u0012\u0001\u0012\u0003\u0012\u010f\b\u0012\u0001\u0013\u0001\u0013"+
		"\u0001\u0013\u0003\u0013\u0114\b\u0013\u0001\u0014\u0004\u0014\u0117\b"+
		"\u0014\u000b\u0014\f\u0014\u0118\u0001\u0014\u0001\u0014\u0003\u0014\u011d"+
		"\b\u0014\u0001\u0015\u0001\u0015\u0003\u0015\u0121\b\u0015\u0001\u0016"+
		"\u0001\u0016\u0003\u0016\u0125\b\u0016\u0001\u0017\u0001\u0017\u0003\u0017"+
		"\u0129\b\u0017\u0001\u0018\u0001\u0018\u0003\u0018\u012d\b\u0018\u0001"+
		"\u0019\u0001\u0019\u0003\u0019\u0131\b\u0019\u0001\u001a\u0001\u001a\u0003"+
		"\u001a\u0135\b\u001a\u0001\u001b\u0001\u001b\u0003\u001b\u0139\b\u001b"+
		"\u0001\u001c\u0001\u001c\u0003\u001c\u013d\b\u001c\u0001\u001d\u0001\u001d"+
		"\u0001\u001d\u0003\u001d\u0142\b\u001d\u0001\u001e\u0001\u001e\u0001\u001e"+
		"\u0003\u001e\u0147\b\u001e\u0001\u001f\u0001\u001f\u0003\u001f\u014b\b"+
		"\u001f\u0001 \u0001 \u0003 \u014f\b \u0001!\u0001!\u0001!\u0001!\u0001"+
		"!\u0003!\u0156\b!\u0001\"\u0001\"\u0001\"\u0001\"\u0001\"\u0001\"\u0003"+
		"\"\u015e\b\"\u0001#\u0001#\u0001#\u0001#\u0001#\u0001#\u0001#\u0001#\u0003"+
		"#\u0168\b#\u0001$\u0001$\u0001$\u0001$\u0003$\u016e\b$\u0001%\u0004%\u0171"+
		"\b%\u000b%\f%\u0172\u0001%\u0003%\u0176\b%\u0001&\u0001&\u0001\'\u0001"+
		"\'\u0001(\u0001(\u0001(\u0001(\u0004(\u0180\b(\u000b(\f(\u0181\u0001)"+
		"\u0001)\u0001)\u0005)\u0187\b)\n)\f)\u018a\t)\u0001)\u0003)\u018d\b)\u0001"+
		")\u0001)\u0001)\u0000\u0002\u0010\u0014*\u0000\u0002\u0004\u0006\b\n\f"+
		"\u000e\u0010\u0012\u0014\u0016\u0018\u001a\u001c\u001e \"$&(*,.02468:"+
		"<>@BDFHJLNPR\u0000\u0012\u0002\u0000SSss\u0002\u0000EEee\u0002\u0000L"+
		"Lll\u0002\u0000CCcc\u0002\u0000TTtt\u0002\u0000FFff\u0002\u0000RRrr\u0002"+
		"\u0000OOoo\u0002\u0000MMmm\u0002\u0000WWww\u0002\u0000HHhh\u0002\u0000"+
		"AAaa\u0002\u0000NNnn\u0002\u0000DDdd\u0001\u0000\'\'\u0001\u000009\u0002"+
		"\u0000AZaz\u0002\u0000\n\n\r\r\u01a2\u0000U\u0001\u0000\u0000\u0000\u0002"+
		"b\u0001\u0000\u0000\u0000\u0004d\u0001\u0000\u0000\u0000\u0006m\u0001"+
		"\u0000\u0000\u0000\bv\u0001\u0000\u0000\u0000\n~\u0001\u0000\u0000\u0000"+
		"\f\u0081\u0001\u0000\u0000\u0000\u000e\u0096\u0001\u0000\u0000\u0000\u0010"+
		"\u009d\u0001\u0000\u0000\u0000\u0012\u00b3\u0001\u0000\u0000\u0000\u0014"+
		"\u00c8\u0001\u0000\u0000\u0000\u0016\u00d3\u0001\u0000\u0000\u0000\u0018"+
		"\u00dd\u0001\u0000\u0000\u0000\u001a\u00e5\u0001\u0000\u0000\u0000\u001c"+
		"\u00ee\u0001\u0000\u0000\u0000\u001e\u00f5\u0001\u0000\u0000\u0000 \u0100"+
		"\u0001\u0000\u0000\u0000\"\u0102\u0001\u0000\u0000\u0000$\u010c\u0001"+
		"\u0000\u0000\u0000&\u0110\u0001\u0000\u0000\u0000(\u0116\u0001\u0000\u0000"+
		"\u0000*\u011e\u0001\u0000\u0000\u0000,\u0122\u0001\u0000\u0000\u0000."+
		"\u0126\u0001\u0000\u0000\u00000\u012a\u0001\u0000\u0000\u00002\u012e\u0001"+
		"\u0000\u0000\u00004\u0132\u0001\u0000\u0000\u00006\u0136\u0001\u0000\u0000"+
		"\u00008\u013a\u0001\u0000\u0000\u0000:\u013e\u0001\u0000\u0000\u0000<"+
		"\u0143\u0001\u0000\u0000\u0000>\u0148\u0001\u0000\u0000\u0000@\u014c\u0001"+
		"\u0000\u0000\u0000B\u0150\u0001\u0000\u0000\u0000D\u0157\u0001\u0000\u0000"+
		"\u0000F\u015f\u0001\u0000\u0000\u0000H\u0169\u0001\u0000\u0000\u0000J"+
		"\u0170\u0001\u0000\u0000\u0000L\u0177\u0001\u0000\u0000\u0000N\u0179\u0001"+
		"\u0000\u0000\u0000P\u017f\u0001\u0000\u0000\u0000R\u0183\u0001\u0000\u0000"+
		"\u0000TV\u0003P(\u0000UT\u0001\u0000\u0000\u0000UV\u0001\u0000\u0000\u0000"+
		"VY\u0001\u0000\u0000\u0000WZ\u0003\u0004\u0002\u0000XZ\u0003\u0006\u0003"+
		"\u0000YW\u0001\u0000\u0000\u0000YX\u0001\u0000\u0000\u0000Z[\u0001\u0000"+
		"\u0000\u0000[Y\u0001\u0000\u0000\u0000[\\\u0001\u0000\u0000\u0000\\]\u0001"+
		"\u0000\u0000\u0000]^\u0005\u0000\u0000\u0001^\u0001\u0001\u0000\u0000"+
		"\u0000_c\u0003B!\u0000`c\u0003D\"\u0000ac\u0003(\u0014\u0000b_\u0001\u0000"+
		"\u0000\u0000b`\u0001\u0000\u0000\u0000ba\u0001\u0000\u0000\u0000c\u0003"+
		"\u0001\u0000\u0000\u0000de\u0003\u0002\u0001\u0000ei\u0003(\u0014\u0000"+
		"fg\u00038\u001c\u0000gh\u0003\u0010\b\u0000hj\u0001\u0000\u0000\u0000"+
		"if\u0001\u0000\u0000\u0000ij\u0001\u0000\u0000\u0000jk\u0001\u0000\u0000"+
		"\u0000kl\u0003@ \u0000l\u0005\u0001\u0000\u0000\u0000mn\u0003\u0002\u0001"+
		"\u0000no\u0003(\u0014\u0000oq\u00030\u0018\u0000pr\u0003\b\u0004\u0000"+
		"qp\u0001\u0000\u0000\u0000qr\u0001\u0000\u0000\u0000rs\u0001\u0000\u0000"+
		"\u0000st\u00032\u0019\u0000tu\u0003\f\u0006\u0000u\u0007\u0001\u0000\u0000"+
		"\u0000v{\u0003\n\u0005\u0000wx\u0005,\u0000\u0000xz\u0003\n\u0005\u0000"+
		"yw\u0001\u0000\u0000\u0000z}\u0001\u0000\u0000\u0000{y\u0001\u0000\u0000"+
		"\u0000{|\u0001\u0000\u0000\u0000|\t\u0001\u0000\u0000\u0000}{\u0001\u0000"+
		"\u0000\u0000~\u007f\u0003\u0002\u0001\u0000\u007f\u0080\u0003(\u0014\u0000"+
		"\u0080\u000b\u0001\u0000\u0000\u0000\u0081\u0083\u0003,\u0016\u0000\u0082"+
		"\u0084\u0003\u000e\u0007\u0000\u0083\u0082\u0001\u0000\u0000\u0000\u0084"+
		"\u0085\u0001\u0000\u0000\u0000\u0085\u0083\u0001\u0000\u0000\u0000\u0085"+
		"\u0086\u0001\u0000\u0000\u0000\u0086\u0087\u0001\u0000\u0000\u0000\u0087"+
		"\u0088\u0003.\u0017\u0000\u0088\r\u0001\u0000\u0000\u0000\u0089\u0097"+
		"\u0003\u0004\u0002\u0000\u008a\u008b\u0003F#\u0000\u008b\u008c\u0003\u0010"+
		"\b\u0000\u008c\u008d\u0003@ \u0000\u008d\u0097\u0001\u0000\u0000\u0000"+
		"\u008e\u008f\u0003(\u0014\u0000\u008f\u0090\u00038\u001c\u0000\u0090\u0091"+
		"\u0003\u0010\b\u0000\u0091\u0092\u0003@ \u0000\u0092\u0097\u0001\u0000"+
		"\u0000\u0000\u0093\u0094\u0003(\u0014\u0000\u0094\u0095\u0003>\u001f\u0000"+
		"\u0095\u0097\u0001\u0000\u0000\u0000\u0096\u0089\u0001\u0000\u0000\u0000"+
		"\u0096\u008a\u0001\u0000\u0000\u0000\u0096\u008e\u0001\u0000\u0000\u0000"+
		"\u0096\u0093\u0001\u0000\u0000\u0000\u0097\u000f\u0001\u0000\u0000\u0000"+
		"\u0098\u0099\u0006\b\uffff\uffff\u0000\u0099\u009e\u0003J%\u0000\u009a"+
		"\u009e\u0003H$\u0000\u009b\u009e\u0003(\u0014\u0000\u009c\u009e\u0003"+
		"\u0012\t\u0000\u009d\u0098\u0001\u0000\u0000\u0000\u009d\u009a\u0001\u0000"+
		"\u0000\u0000\u009d\u009b\u0001\u0000\u0000\u0000\u009d\u009c\u0001\u0000"+
		"\u0000\u0000\u009e\u00b0\u0001\u0000\u0000\u0000\u009f\u00a2\n\u0007\u0000"+
		"\u0000\u00a0\u00a3\u0003:\u001d\u0000\u00a1\u00a3\u0003<\u001e\u0000\u00a2"+
		"\u00a0\u0001\u0000\u0000\u0000\u00a2\u00a1\u0001\u0000\u0000\u0000\u00a3"+
		"\u00a4\u0001\u0000\u0000\u0000\u00a4\u00a5\u0003\u0010\b\b\u00a5\u00af"+
		"\u0001\u0000\u0000\u0000\u00a6\u00a7\n\u0006\u0000\u0000\u00a7\u00a8\u0003"+
		"4\u001a\u0000\u00a8\u00a9\u0003\u0010\b\u0007\u00a9\u00af\u0001\u0000"+
		"\u0000\u0000\u00aa\u00ab\n\u0005\u0000\u0000\u00ab\u00ac\u00036\u001b"+
		"\u0000\u00ac\u00ad\u0003\u0010\b\u0006\u00ad\u00af\u0001\u0000\u0000\u0000"+
		"\u00ae\u009f\u0001\u0000\u0000\u0000\u00ae\u00a6\u0001\u0000\u0000\u0000"+
		"\u00ae\u00aa\u0001\u0000\u0000\u0000\u00af\u00b2\u0001\u0000\u0000\u0000"+
		"\u00b0\u00ae\u0001\u0000\u0000\u0000\u00b0\u00b1\u0001\u0000\u0000\u0000"+
		"\u00b1\u0011\u0001\u0000\u0000\u0000\u00b2\u00b0\u0001\u0000\u0000\u0000"+
		"\u00b3\u00b6\u0003\u0016\u000b\u0000\u00b4\u00b7\u00034\u001a\u0000\u00b5"+
		"\u00b7\u0003\u001e\u000f\u0000\u00b6\u00b4\u0001\u0000\u0000\u0000\u00b6"+
		"\u00b5\u0001\u0000\u0000\u0000\u00b7\u00b8\u0001\u0000\u0000\u0000\u00b8"+
		"\u00b9\u0003\u0018\f\u0000\u00b9\u00bd\u0003 \u0010\u0000\u00ba\u00bb"+
		"\u0003\u001a\r\u0000\u00bb\u00bc\u0003\u0014\n\u0000\u00bc\u00be\u0001"+
		"\u0000\u0000\u0000\u00bd\u00ba\u0001\u0000\u0000\u0000\u00bd\u00be\u0001"+
		"\u0000\u0000\u0000\u00be\u0013\u0001\u0000\u0000\u0000\u00bf\u00c0\u0006"+
		"\n\uffff\uffff\u0000\u00c0\u00c1\u0003(\u0014\u0000\u00c1\u00c2\u0003"+
		"&\u0013\u0000\u00c2\u00c3\u0003 \u0010\u0000\u00c3\u00c9\u0001\u0000\u0000"+
		"\u0000\u00c4\u00c5\u0003(\u0014\u0000\u00c5\u00c6\u0003$\u0012\u0000\u00c6"+
		"\u00c7\u0003 \u0010\u0000\u00c7\u00c9\u0001\u0000\u0000\u0000\u00c8\u00bf"+
		"\u0001\u0000\u0000\u0000\u00c8\u00c4\u0001\u0000\u0000\u0000\u00c9\u00d0"+
		"\u0001\u0000\u0000\u0000\u00ca\u00cb\n\u0003\u0000\u0000\u00cb\u00cc\u0003"+
		"\u001c\u000e\u0000\u00cc\u00cd\u0003\u0014\n\u0004\u00cd\u00cf\u0001\u0000"+
		"\u0000\u0000\u00ce\u00ca\u0001\u0000\u0000\u0000\u00cf\u00d2\u0001\u0000"+
		"\u0000\u0000\u00d0\u00ce\u0001\u0000\u0000\u0000\u00d0\u00d1\u0001\u0000"+
		"\u0000\u0000\u00d1\u0015\u0001\u0000\u0000\u0000\u00d2\u00d0\u0001\u0000"+
		"\u0000\u0000\u00d3\u00d4\u0004\u000b\u0004\u0000\u00d4\u00d5\u0007\u0000"+
		"\u0000\u0000\u00d5\u00d6\u0007\u0001\u0000\u0000\u00d6\u00d7\u0007\u0002"+
		"\u0000\u0000\u00d7\u00d8\u0007\u0001\u0000\u0000\u00d8\u00d9\u0007\u0003"+
		"\u0000\u0000\u00d9\u00db\u0007\u0004\u0000\u0000\u00da\u00dc\u0003P(\u0000"+
		"\u00db\u00da\u0001\u0000\u0000\u0000\u00db\u00dc\u0001\u0000\u0000\u0000"+
		"\u00dc\u0017\u0001\u0000\u0000\u0000\u00dd\u00de\u0004\f\u0005\u0000\u00de"+
		"\u00df\u0007\u0005\u0000\u0000\u00df\u00e0\u0007\u0006\u0000\u0000\u00e0"+
		"\u00e1\u0007\u0007\u0000\u0000\u00e1\u00e3\u0007\b\u0000\u0000\u00e2\u00e4"+
		"\u0003P(\u0000\u00e3\u00e2\u0001\u0000\u0000\u0000\u00e3\u00e4\u0001\u0000"+
		"\u0000\u0000\u00e4\u0019\u0001\u0000\u0000\u0000\u00e5\u00e6\u0004\r\u0006"+
		"\u0000\u00e6\u00e7\u0007\t\u0000\u0000\u00e7\u00e8\u0007\n\u0000\u0000"+
		"\u00e8\u00e9\u0007\u0001\u0000\u0000\u00e9\u00ea\u0007\u0006\u0000\u0000"+
		"\u00ea\u00ec\u0007\u0001\u0000\u0000\u00eb\u00ed\u0003P(\u0000\u00ec\u00eb"+
		"\u0001\u0000\u0000\u0000\u00ec\u00ed\u0001\u0000\u0000\u0000\u00ed\u001b"+
		"\u0001\u0000\u0000\u0000\u00ee\u00ef\u0004\u000e\u0007\u0000\u00ef\u00f0"+
		"\u0007\u000b\u0000\u0000\u00f0\u00f1\u0007\f\u0000\u0000\u00f1\u00f3\u0007"+
		"\r\u0000\u0000\u00f2\u00f4\u0003P(\u0000\u00f3\u00f2\u0001\u0000\u0000"+
		"\u0000\u00f3\u00f4\u0001\u0000\u0000\u0000\u00f4\u001d\u0001\u0000\u0000"+
		"\u0000\u00f5\u00fa\u0003(\u0014\u0000\u00f6\u00f7\u0005,\u0000\u0000\u00f7"+
		"\u00f9\u0003(\u0014\u0000\u00f8\u00f6\u0001\u0000\u0000\u0000\u00f9\u00fc"+
		"\u0001\u0000\u0000\u0000\u00fa\u00f8\u0001\u0000\u0000\u0000\u00fa\u00fb"+
		"\u0001\u0000\u0000\u0000\u00fb\u001f\u0001\u0000\u0000\u0000\u00fc\u00fa"+
		"\u0001\u0000\u0000\u0000\u00fd\u0101\u0003\"\u0011\u0000\u00fe\u0101\u0003"+
		"(\u0014\u0000\u00ff\u0101\u0003J%\u0000\u0100\u00fd\u0001\u0000\u0000"+
		"\u0000\u0100\u00fe\u0001\u0000\u0000\u0000\u0100\u00ff\u0001\u0000\u0000"+
		"\u0000\u0101!\u0001\u0000\u0000\u0000\u0102\u0104\u0003*\u0015\u0000\u0103"+
		"\u0105\b\u000e\u0000\u0000\u0104\u0103\u0001\u0000\u0000\u0000\u0105\u0106"+
		"\u0001\u0000\u0000\u0000\u0106\u0104\u0001\u0000\u0000\u0000\u0106\u0107"+
		"\u0001\u0000\u0000\u0000\u0107\u0108\u0001\u0000\u0000\u0000\u0108\u010a"+
		"\u0003*\u0015\u0000\u0109\u010b\u0003P(\u0000\u010a\u0109\u0001\u0000"+
		"\u0000\u0000\u010a\u010b\u0001\u0000\u0000\u0000\u010b#\u0001\u0000\u0000"+
		"\u0000\u010c\u010e\u0005=\u0000\u0000\u010d\u010f\u0003P(\u0000\u010e"+
		"\u010d\u0001\u0000\u0000\u0000\u010e\u010f\u0001\u0000\u0000\u0000\u010f"+
		"%\u0001\u0000\u0000\u0000\u0110\u0111\u0005<\u0000\u0000\u0111\u0113\u0005"+
		">\u0000\u0000\u0112\u0114\u0003P(\u0000\u0113\u0112\u0001\u0000\u0000"+
		"\u0000\u0113\u0114\u0001\u0000\u0000\u0000\u0114\'\u0001\u0000\u0000\u0000"+
		"\u0115\u0117\u0003N\'\u0000\u0116\u0115\u0001\u0000\u0000\u0000\u0117"+
		"\u0118\u0001\u0000\u0000\u0000\u0118\u0116\u0001\u0000\u0000\u0000\u0118"+
		"\u0119\u0001\u0000\u0000\u0000\u0119\u011a\u0001\u0000\u0000\u0000\u011a"+
		"\u011c\u0004\u0014\b\u0001\u011b\u011d\u0003P(\u0000\u011c\u011b\u0001"+
		"\u0000\u0000\u0000\u011c\u011d\u0001\u0000\u0000\u0000\u011d)\u0001\u0000"+
		"\u0000\u0000\u011e\u0120\u0005\'\u0000\u0000\u011f\u0121\u0003P(\u0000"+
		"\u0120\u011f\u0001\u0000\u0000\u0000\u0120\u0121\u0001\u0000\u0000\u0000"+
		"\u0121+\u0001\u0000\u0000\u0000\u0122\u0124\u0005{\u0000\u0000\u0123\u0125"+
		"\u0003P(\u0000\u0124\u0123\u0001\u0000\u0000\u0000\u0124\u0125\u0001\u0000"+
		"\u0000\u0000\u0125-\u0001\u0000\u0000\u0000\u0126\u0128\u0005}\u0000\u0000"+
		"\u0127\u0129\u0003P(\u0000\u0128\u0127\u0001\u0000\u0000\u0000\u0128\u0129"+
		"\u0001\u0000\u0000\u0000\u0129/\u0001\u0000\u0000\u0000\u012a\u012c\u0005"+
		"(\u0000\u0000\u012b\u012d\u0003P(\u0000\u012c\u012b\u0001\u0000\u0000"+
		"\u0000\u012c\u012d\u0001\u0000\u0000\u0000\u012d1\u0001\u0000\u0000\u0000"+
		"\u012e\u0130\u0005)\u0000\u0000\u012f\u0131\u0003P(\u0000\u0130\u012f"+
		"\u0001\u0000\u0000\u0000\u0130\u0131\u0001\u0000\u0000\u0000\u01313\u0001"+
		"\u0000\u0000\u0000\u0132\u0134\u0005*\u0000\u0000\u0133\u0135\u0003P("+
		"\u0000\u0134\u0133\u0001\u0000\u0000\u0000\u0134\u0135\u0001\u0000\u0000"+
		"\u0000\u01355\u0001\u0000\u0000\u0000\u0136\u0138\u0005+\u0000\u0000\u0137"+
		"\u0139\u0003P(\u0000\u0138\u0137\u0001\u0000\u0000\u0000\u0138\u0139\u0001"+
		"\u0000\u0000\u0000\u01397\u0001\u0000\u0000\u0000\u013a\u013c\u0005=\u0000"+
		"\u0000\u013b\u013d\u0003P(\u0000\u013c\u013b\u0001\u0000\u0000\u0000\u013c"+
		"\u013d\u0001\u0000\u0000\u0000\u013d9\u0001\u0000\u0000\u0000\u013e\u013f"+
		"\u0005=\u0000\u0000\u013f\u0141\u0005=\u0000\u0000\u0140\u0142\u0003P"+
		"(\u0000\u0141\u0140\u0001\u0000\u0000\u0000\u0141\u0142\u0001\u0000\u0000"+
		"\u0000\u0142;\u0001\u0000\u0000\u0000\u0143\u0144\u0005!\u0000\u0000\u0144"+
		"\u0146\u0005=\u0000\u0000\u0145\u0147\u0003P(\u0000\u0146\u0145\u0001"+
		"\u0000\u0000\u0000\u0146\u0147\u0001\u0000\u0000\u0000\u0147=\u0001\u0000"+
		"\u0000\u0000\u0148\u014a\u0005:\u0000\u0000\u0149\u014b\u0003P(\u0000"+
		"\u014a\u0149\u0001\u0000\u0000\u0000\u014a\u014b\u0001\u0000\u0000\u0000"+
		"\u014b?\u0001\u0000\u0000\u0000\u014c\u014e\u0005;\u0000\u0000\u014d\u014f"+
		"\u0003P(\u0000\u014e\u014d\u0001\u0000\u0000\u0000\u014e\u014f\u0001\u0000"+
		"\u0000\u0000\u014fA\u0001\u0000\u0000\u0000\u0150\u0151\u0004!\t\u0000"+
		"\u0151\u0152\u0005i\u0000\u0000\u0152\u0153\u0005n\u0000\u0000\u0153\u0155"+
		"\u0005t\u0000\u0000\u0154\u0156\u0003P(\u0000\u0155\u0154\u0001\u0000"+
		"\u0000\u0000\u0155\u0156\u0001\u0000\u0000\u0000\u0156C\u0001\u0000\u0000"+
		"\u0000\u0157\u0158\u0004\"\n\u0000\u0158\u0159\u0005v\u0000\u0000\u0159"+
		"\u015a\u0005o\u0000\u0000\u015a\u015b\u0005i\u0000\u0000\u015b\u015d\u0005"+
		"d\u0000\u0000\u015c\u015e\u0003P(\u0000\u015d\u015c\u0001\u0000\u0000"+
		"\u0000\u015d\u015e\u0001\u0000\u0000\u0000\u015eE\u0001\u0000\u0000\u0000"+
		"\u015f\u0160\u0004#\u000b\u0000\u0160\u0161\u0005r\u0000\u0000\u0161\u0162"+
		"\u0005e\u0000\u0000\u0162\u0163\u0005t\u0000\u0000\u0163\u0164\u0005u"+
		"\u0000\u0000\u0164\u0165\u0005r\u0000\u0000\u0165\u0167\u0005n\u0000\u0000"+
		"\u0166\u0168\u0003P(\u0000\u0167\u0166\u0001\u0000\u0000\u0000\u0167\u0168"+
		"\u0001\u0000\u0000\u0000\u0168G\u0001\u0000\u0000\u0000\u0169\u016a\u0003"+
		"*\u0015\u0000\u016a\u016b\t\u0000\u0000\u0000\u016b\u016d\u0003*\u0015"+
		"\u0000\u016c\u016e\u0003P(\u0000\u016d\u016c\u0001\u0000\u0000\u0000\u016d"+
		"\u016e\u0001\u0000\u0000\u0000\u016eI\u0001\u0000\u0000\u0000\u016f\u0171"+
		"\u0003L&\u0000\u0170\u016f\u0001\u0000\u0000\u0000\u0171\u0172\u0001\u0000"+
		"\u0000\u0000\u0172\u0170\u0001\u0000\u0000\u0000\u0172\u0173\u0001\u0000"+
		"\u0000\u0000\u0173\u0175\u0001\u0000\u0000\u0000\u0174\u0176\u0003P(\u0000"+
		"\u0175\u0174\u0001\u0000\u0000\u0000\u0175\u0176\u0001\u0000\u0000\u0000"+
		"\u0176K\u0001\u0000\u0000\u0000\u0177\u0178\u0007\u000f\u0000\u0000\u0178"+
		"M\u0001\u0000\u0000\u0000\u0179\u017a\u0007\u0010\u0000\u0000\u017aO\u0001"+
		"\u0000\u0000\u0000\u017b\u0180\u0005 \u0000\u0000\u017c\u0180\u0005\t"+
		"\u0000\u0000\u017d\u0180\u0005\n\u0000\u0000\u017e\u0180\u0003R)\u0000"+
		"\u017f\u017b\u0001\u0000\u0000\u0000\u017f\u017c\u0001\u0000\u0000\u0000"+
		"\u017f\u017d\u0001\u0000\u0000\u0000\u017f\u017e\u0001\u0000\u0000\u0000"+
		"\u0180\u0181\u0001\u0000\u0000\u0000\u0181\u017f\u0001\u0000\u0000\u0000"+
		"\u0181\u0182\u0001\u0000\u0000\u0000\u0182Q\u0001\u0000\u0000\u0000\u0183"+
		"\u0184\u0005/\u0000\u0000\u0184\u0188\u0005/\u0000\u0000\u0185\u0187\b"+
		"\u0011\u0000\u0000\u0186\u0185\u0001\u0000\u0000\u0000\u0187\u018a\u0001"+
		"\u0000\u0000\u0000\u0188\u0186\u0001\u0000\u0000\u0000\u0188\u0189\u0001"+
		"\u0000\u0000\u0000\u0189\u018c\u0001\u0000\u0000\u0000\u018a\u0188\u0001"+
		"\u0000\u0000\u0000\u018b\u018d\u0005\r\u0000\u0000\u018c\u018b\u0001\u0000"+
		"\u0000\u0000\u018c\u018d\u0001\u0000\u0000\u0000\u018d\u018e\u0001\u0000"+
		"\u0000\u0000\u018e\u018f\u0005\n\u0000\u0000\u018fS\u0001\u0000\u0000"+
		"\u00003UY[biq{\u0085\u0096\u009d\u00a2\u00ae\u00b0\u00b6\u00bd\u00c8\u00d0"+
		"\u00db\u00e3\u00ec\u00f3\u00fa\u0100\u0106\u010a\u010e\u0113\u0118\u011c"+
		"\u0120\u0124\u0128\u012c\u0130\u0134\u0138\u013c\u0141\u0146\u014a\u014e"+
		"\u0155\u015d\u0167\u016d\u0172\u0175\u017f\u0181\u0188\u018c";
	public static final ATN _ATN =
		new ATNDeserializer().deserialize(_serializedATN.toCharArray());
	static {
		_decisionToDFA = new DFA[_ATN.getNumberOfDecisions()];
		for (int i = 0; i < _ATN.getNumberOfDecisions(); i++) {
			_decisionToDFA[i] = new DFA(_ATN.getDecisionState(i), i);
		}
	}
}