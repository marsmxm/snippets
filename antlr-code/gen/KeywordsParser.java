// Generated from /Users/mxm/learn/snippets/antlr-code/original/actions/Keywords.g4 by ANTLR 4.13.1
import org.antlr.v4.runtime.atn.*;
import org.antlr.v4.runtime.dfa.DFA;
import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.misc.*;
import org.antlr.v4.runtime.tree.*;
import java.util.List;
import java.util.Iterator;
import java.util.ArrayList;

@SuppressWarnings({"all", "warnings", "unchecked", "unused", "cast", "CheckReturnValue"})
public class KeywordsParser extends Parser {
	static { RuntimeMetaData.checkVersion("4.13.1", RuntimeMetaData.VERSION); }

	protected static final DFA[] _decisionToDFA;
	protected static final PredictionContextCache _sharedContextCache =
		new PredictionContextCache();
	public static final int
		T__0=1, T__1=2, ID=3, CHAR=4, INT=5, WS=6, BEGIN=7, END=8, IF=9, THEN=10, 
		WHILE=11;
	public static final int
		RULE_stat = 0, RULE_expr = 1;
	private static String[] makeRuleNames() {
		return new String[] {
			"stat", "expr"
		};
	}
	public static final String[] ruleNames = makeRuleNames();

	private static String[] makeLiteralNames() {
		return new String[] {
			null, "'='", "';'"
		};
	}
	private static final String[] _LITERAL_NAMES = makeLiteralNames();
	private static String[] makeSymbolicNames() {
		return new String[] {
			null, null, null, "ID", "CHAR", "INT", "WS", "BEGIN", "END", "IF", "THEN", 
			"WHILE"
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
	public String getGrammarFileName() { return "Keywords.g4"; }

	@Override
	public String[] getRuleNames() { return ruleNames; }

	@Override
	public String getSerializedATN() { return _serializedATN; }

	@Override
	public ATN getATN() { return _ATN; }

	public KeywordsParser(TokenStream input) {
		super(input);
		_interp = new ParserATNSimulator(this,_ATN,_decisionToDFA,_sharedContextCache);
	}

	@SuppressWarnings("CheckReturnValue")
	public static class StatContext extends ParserRuleContext {
		public TerminalNode BEGIN() { return getToken(KeywordsParser.BEGIN, 0); }
		public TerminalNode END() { return getToken(KeywordsParser.END, 0); }
		public List<StatContext> stat() {
			return getRuleContexts(StatContext.class);
		}
		public StatContext stat(int i) {
			return getRuleContext(StatContext.class,i);
		}
		public TerminalNode IF() { return getToken(KeywordsParser.IF, 0); }
		public ExprContext expr() {
			return getRuleContext(ExprContext.class,0);
		}
		public TerminalNode THEN() { return getToken(KeywordsParser.THEN, 0); }
		public TerminalNode WHILE() { return getToken(KeywordsParser.WHILE, 0); }
		public TerminalNode ID() { return getToken(KeywordsParser.ID, 0); }
		public StatContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_stat; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof KeywordsListener ) ((KeywordsListener)listener).enterStat(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof KeywordsListener ) ((KeywordsListener)listener).exitStat(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof KeywordsVisitor ) return ((KeywordsVisitor<? extends T>)visitor).visitStat(this);
			else return visitor.visitChildren(this);
		}
	}

	public final StatContext stat() throws RecognitionException {
		StatContext _localctx = new StatContext(_ctx, getState());
		enterRule(_localctx, 0, RULE_stat);
		int _la;
		try {
			setState(26);
			_errHandler.sync(this);
			switch (_input.LA(1)) {
			case BEGIN:
				enterOuterAlt(_localctx, 1);
				{
				setState(4);
				match(BEGIN);
				setState(8);
				_errHandler.sync(this);
				_la = _input.LA(1);
				while ((((_la) & ~0x3f) == 0 && ((1L << _la) & 2696L) != 0)) {
					{
					{
					setState(5);
					stat();
					}
					}
					setState(10);
					_errHandler.sync(this);
					_la = _input.LA(1);
				}
				setState(11);
				match(END);
				}
				break;
			case IF:
				enterOuterAlt(_localctx, 2);
				{
				setState(12);
				match(IF);
				setState(13);
				expr();
				setState(14);
				match(THEN);
				setState(15);
				stat();
				}
				break;
			case WHILE:
				enterOuterAlt(_localctx, 3);
				{
				setState(17);
				match(WHILE);
				setState(18);
				expr();
				setState(19);
				stat();
				}
				break;
			case ID:
				enterOuterAlt(_localctx, 4);
				{
				setState(21);
				match(ID);
				setState(22);
				match(T__0);
				setState(23);
				expr();
				setState(24);
				match(T__1);
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
	public static class ExprContext extends ParserRuleContext {
		public TerminalNode INT() { return getToken(KeywordsParser.INT, 0); }
		public TerminalNode CHAR() { return getToken(KeywordsParser.CHAR, 0); }
		public ExprContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_expr; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof KeywordsListener ) ((KeywordsListener)listener).enterExpr(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof KeywordsListener ) ((KeywordsListener)listener).exitExpr(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof KeywordsVisitor ) return ((KeywordsVisitor<? extends T>)visitor).visitExpr(this);
			else return visitor.visitChildren(this);
		}
	}

	public final ExprContext expr() throws RecognitionException {
		ExprContext _localctx = new ExprContext(_ctx, getState());
		enterRule(_localctx, 2, RULE_expr);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(28);
			_la = _input.LA(1);
			if ( !(_la==CHAR || _la==INT) ) {
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

	public static final String _serializedATN =
		"\u0004\u0001\u000b\u001f\u0002\u0000\u0007\u0000\u0002\u0001\u0007\u0001"+
		"\u0001\u0000\u0001\u0000\u0005\u0000\u0007\b\u0000\n\u0000\f\u0000\n\t"+
		"\u0000\u0001\u0000\u0001\u0000\u0001\u0000\u0001\u0000\u0001\u0000\u0001"+
		"\u0000\u0001\u0000\u0001\u0000\u0001\u0000\u0001\u0000\u0001\u0000\u0001"+
		"\u0000\u0001\u0000\u0001\u0000\u0001\u0000\u0003\u0000\u001b\b\u0000\u0001"+
		"\u0001\u0001\u0001\u0001\u0001\u0000\u0000\u0002\u0000\u0002\u0000\u0001"+
		"\u0001\u0000\u0004\u0005 \u0000\u001a\u0001\u0000\u0000\u0000\u0002\u001c"+
		"\u0001\u0000\u0000\u0000\u0004\b\u0005\u0007\u0000\u0000\u0005\u0007\u0003"+
		"\u0000\u0000\u0000\u0006\u0005\u0001\u0000\u0000\u0000\u0007\n\u0001\u0000"+
		"\u0000\u0000\b\u0006\u0001\u0000\u0000\u0000\b\t\u0001\u0000\u0000\u0000"+
		"\t\u000b\u0001\u0000\u0000\u0000\n\b\u0001\u0000\u0000\u0000\u000b\u001b"+
		"\u0005\b\u0000\u0000\f\r\u0005\t\u0000\u0000\r\u000e\u0003\u0002\u0001"+
		"\u0000\u000e\u000f\u0005\n\u0000\u0000\u000f\u0010\u0003\u0000\u0000\u0000"+
		"\u0010\u001b\u0001\u0000\u0000\u0000\u0011\u0012\u0005\u000b\u0000\u0000"+
		"\u0012\u0013\u0003\u0002\u0001\u0000\u0013\u0014\u0003\u0000\u0000\u0000"+
		"\u0014\u001b\u0001\u0000\u0000\u0000\u0015\u0016\u0005\u0003\u0000\u0000"+
		"\u0016\u0017\u0005\u0001\u0000\u0000\u0017\u0018\u0003\u0002\u0001\u0000"+
		"\u0018\u0019\u0005\u0002\u0000\u0000\u0019\u001b\u0001\u0000\u0000\u0000"+
		"\u001a\u0004\u0001\u0000\u0000\u0000\u001a\f\u0001\u0000\u0000\u0000\u001a"+
		"\u0011\u0001\u0000\u0000\u0000\u001a\u0015\u0001\u0000\u0000\u0000\u001b"+
		"\u0001\u0001\u0000\u0000\u0000\u001c\u001d\u0007\u0000\u0000\u0000\u001d"+
		"\u0003\u0001\u0000\u0000\u0000\u0002\b\u001a";
	public static final ATN _ATN =
		new ATNDeserializer().deserialize(_serializedATN.toCharArray());
	static {
		_decisionToDFA = new DFA[_ATN.getNumberOfDecisions()];
		for (int i = 0; i < _ATN.getNumberOfDecisions(); i++) {
			_decisionToDFA[i] = new DFA(_ATN.getDecisionState(i), i);
		}
	}
}