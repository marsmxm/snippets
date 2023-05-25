// Generated from /Users/mxm/learn/snippets/antlr-code/src/main/java/ink/mxm/tour/ActionExpr.g4 by ANTLR 4.12.0
package ink.mxm.tour;

import java.util.*;

import org.antlr.v4.runtime.atn.*;
import org.antlr.v4.runtime.dfa.DFA;
import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.misc.*;
import org.antlr.v4.runtime.tree.*;
import java.util.List;
import java.util.Iterator;
import java.util.ArrayList;

@SuppressWarnings({"all", "warnings", "unchecked", "unused", "cast", "CheckReturnValue"})
public class ActionExprParser extends Parser {
	static { RuntimeMetaData.checkVersion("4.12.0", RuntimeMetaData.VERSION); }

	protected static final DFA[] _decisionToDFA;
	protected static final PredictionContextCache _sharedContextCache =
		new PredictionContextCache();
	public static final int
		T__0=1, T__1=2, T__2=3, MUL=4, DIV=5, ADD=6, SUB=7, ID=8, INT=9, NEWLINE=10, 
		WS=11;
	public static final int
		RULE_prog = 0, RULE_stat = 1, RULE_expr = 2;
	private static String[] makeRuleNames() {
		return new String[] {
			"prog", "stat", "expr"
		};
	}
	public static final String[] ruleNames = makeRuleNames();

	private static String[] makeLiteralNames() {
		return new String[] {
			null, "'='", "'('", "')'", "'*'", "'/'", "'+'", "'-'"
		};
	}
	private static final String[] _LITERAL_NAMES = makeLiteralNames();
	private static String[] makeSymbolicNames() {
		return new String[] {
			null, null, null, null, "MUL", "DIV", "ADD", "SUB", "ID", "INT", "NEWLINE", 
			"WS"
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
	public String getGrammarFileName() { return "ActionExpr.g4"; }

	@Override
	public String[] getRuleNames() { return ruleNames; }

	@Override
	public String getSerializedATN() { return _serializedATN; }

	@Override
	public ATN getATN() { return _ATN; }


	    Map<String, Integer> memory = new HashMap<String, Integer>();

	public ActionExprParser(TokenStream input) {
		super(input);
		_interp = new ParserATNSimulator(this,_ATN,_decisionToDFA,_sharedContextCache);
	}

	@SuppressWarnings("CheckReturnValue")
	public static class ProgContext extends ParserRuleContext {
		public List<StatContext> stat() {
			return getRuleContexts(StatContext.class);
		}
		public StatContext stat(int i) {
			return getRuleContext(StatContext.class,i);
		}
		public ProgContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_prog; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof ActionExprListener ) ((ActionExprListener)listener).enterProg(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof ActionExprListener ) ((ActionExprListener)listener).exitProg(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof ActionExprVisitor ) return ((ActionExprVisitor<? extends T>)visitor).visitProg(this);
			else return visitor.visitChildren(this);
		}
	}

	public final ProgContext prog() throws RecognitionException {
		ProgContext _localctx = new ProgContext(_ctx, getState());
		enterRule(_localctx, 0, RULE_prog);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(7); 
			_errHandler.sync(this);
			_la = _input.LA(1);
			do {
				{
				{
				setState(6);
				stat();
				}
				}
				setState(9); 
				_errHandler.sync(this);
				_la = _input.LA(1);
			} while ( (((_la) & ~0x3f) == 0 && ((1L << _la) & 1796L) != 0) );
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
		public ExprContext expr;
		public Token ID;
		public ExprContext expr() {
			return getRuleContext(ExprContext.class,0);
		}
		public TerminalNode NEWLINE() { return getToken(ActionExprParser.NEWLINE, 0); }
		public TerminalNode ID() { return getToken(ActionExprParser.ID, 0); }
		public StatContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_stat; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof ActionExprListener ) ((ActionExprListener)listener).enterStat(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof ActionExprListener ) ((ActionExprListener)listener).exitStat(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof ActionExprVisitor ) return ((ActionExprVisitor<? extends T>)visitor).visitStat(this);
			else return visitor.visitChildren(this);
		}
	}

	public final StatContext stat() throws RecognitionException {
		StatContext _localctx = new StatContext(_ctx, getState());
		enterRule(_localctx, 2, RULE_stat);
		try {
			setState(22);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,1,_ctx) ) {
			case 1:
				enterOuterAlt(_localctx, 1);
				{
				setState(11);
				((StatContext)_localctx).expr = expr(0);
				setState(12);
				match(NEWLINE);
				System.out.println(((StatContext)_localctx).expr.v);
				}
				break;
			case 2:
				enterOuterAlt(_localctx, 2);
				{
				setState(15);
				((StatContext)_localctx).ID = match(ID);
				setState(16);
				match(T__0);
				setState(17);
				((StatContext)_localctx).expr = expr(0);
				setState(18);
				match(NEWLINE);

				                                   String id = ((StatContext)_localctx).ID.getText();
				                                   memory.put(id, ((StatContext)_localctx).expr.v);
				                                   
				}
				break;
			case 3:
				enterOuterAlt(_localctx, 3);
				{
				setState(21);
				match(NEWLINE);
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
		public int v;
		public ExprContext a;
		public Token INT;
		public Token ID;
		public ExprContext e;
		public Token op;
		public ExprContext b;
		public TerminalNode INT() { return getToken(ActionExprParser.INT, 0); }
		public TerminalNode ID() { return getToken(ActionExprParser.ID, 0); }
		public List<ExprContext> expr() {
			return getRuleContexts(ExprContext.class);
		}
		public ExprContext expr(int i) {
			return getRuleContext(ExprContext.class,i);
		}
		public TerminalNode MUL() { return getToken(ActionExprParser.MUL, 0); }
		public TerminalNode DIV() { return getToken(ActionExprParser.DIV, 0); }
		public TerminalNode ADD() { return getToken(ActionExprParser.ADD, 0); }
		public TerminalNode SUB() { return getToken(ActionExprParser.SUB, 0); }
		public ExprContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_expr; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof ActionExprListener ) ((ActionExprListener)listener).enterExpr(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof ActionExprListener ) ((ActionExprListener)listener).exitExpr(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof ActionExprVisitor ) return ((ActionExprVisitor<? extends T>)visitor).visitExpr(this);
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
		int _startState = 4;
		enterRecursionRule(_localctx, 4, RULE_expr, _p);
		int _la;
		try {
			int _alt;
			enterOuterAlt(_localctx, 1);
			{
			setState(34);
			_errHandler.sync(this);
			switch (_input.LA(1)) {
			case INT:
				{
				setState(25);
				((ExprContext)_localctx).INT = match(INT);
				((ExprContext)_localctx).v =  Integer.valueOf(((ExprContext)_localctx).INT.getText());
				}
				break;
			case ID:
				{
				setState(27);
				((ExprContext)_localctx).ID = match(ID);

				                                   String id = ((ExprContext)_localctx).ID.getText();
				                                   if ( memory.containsKey(id) ) {
				                                       ((ExprContext)_localctx).v =  memory.get(id);
				                                   }
				                                   
				}
				break;
			case T__1:
				{
				setState(29);
				match(T__1);
				setState(30);
				((ExprContext)_localctx).e = expr(0);
				setState(31);
				match(T__2);
				((ExprContext)_localctx).v =  ((ExprContext)_localctx).e.v;
				}
				break;
			default:
				throw new NoViableAltException(this);
			}
			_ctx.stop = _input.LT(-1);
			setState(48);
			_errHandler.sync(this);
			_alt = getInterpreter().adaptivePredict(_input,4,_ctx);
			while ( _alt!=2 && _alt!=org.antlr.v4.runtime.atn.ATN.INVALID_ALT_NUMBER ) {
				if ( _alt==1 ) {
					if ( _parseListeners!=null ) triggerExitRuleEvent();
					_prevctx = _localctx;
					{
					setState(46);
					_errHandler.sync(this);
					switch ( getInterpreter().adaptivePredict(_input,3,_ctx) ) {
					case 1:
						{
						_localctx = new ExprContext(_parentctx, _parentState);
						_localctx.a = _prevctx;
						pushNewRecursionContext(_localctx, _startState, RULE_expr);
						setState(36);
						if (!(precpred(_ctx, 5))) throw new FailedPredicateException(this, "precpred(_ctx, 5)");
						setState(37);
						((ExprContext)_localctx).op = _input.LT(1);
						_la = _input.LA(1);
						if ( !(_la==MUL || _la==DIV) ) {
							((ExprContext)_localctx).op = (Token)_errHandler.recoverInline(this);
						}
						else {
							if ( _input.LA(1)==Token.EOF ) matchedEOF = true;
							_errHandler.reportMatch(this);
							consume();
						}
						setState(38);
						((ExprContext)_localctx).b = expr(6);

						                                             if ( ((ExprContext)_localctx).op.getType()==MUL ) ((ExprContext)_localctx).v =  ((ExprContext)_localctx).a.v * ((ExprContext)_localctx).b.v;
						                                             else ((ExprContext)_localctx).v =  ((ExprContext)_localctx).a.v / ((ExprContext)_localctx).b.v;
						                                             
						}
						break;
					case 2:
						{
						_localctx = new ExprContext(_parentctx, _parentState);
						_localctx.a = _prevctx;
						pushNewRecursionContext(_localctx, _startState, RULE_expr);
						setState(41);
						if (!(precpred(_ctx, 4))) throw new FailedPredicateException(this, "precpred(_ctx, 4)");
						setState(42);
						((ExprContext)_localctx).op = _input.LT(1);
						_la = _input.LA(1);
						if ( !(_la==ADD || _la==SUB) ) {
							((ExprContext)_localctx).op = (Token)_errHandler.recoverInline(this);
						}
						else {
							if ( _input.LA(1)==Token.EOF ) matchedEOF = true;
							_errHandler.reportMatch(this);
							consume();
						}
						setState(43);
						((ExprContext)_localctx).b = expr(5);

						                                             if ( ((ExprContext)_localctx).op.getType()==ADD ) ((ExprContext)_localctx).v =  ((ExprContext)_localctx).a.v + ((ExprContext)_localctx).b.v;
						                                             else ((ExprContext)_localctx).v =  ((ExprContext)_localctx).a.v - ((ExprContext)_localctx).b.v;
						                                             
						}
						break;
					}
					} 
				}
				setState(50);
				_errHandler.sync(this);
				_alt = getInterpreter().adaptivePredict(_input,4,_ctx);
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

	public boolean sempred(RuleContext _localctx, int ruleIndex, int predIndex) {
		switch (ruleIndex) {
		case 2:
			return expr_sempred((ExprContext)_localctx, predIndex);
		}
		return true;
	}
	private boolean expr_sempred(ExprContext _localctx, int predIndex) {
		switch (predIndex) {
		case 0:
			return precpred(_ctx, 5);
		case 1:
			return precpred(_ctx, 4);
		}
		return true;
	}

	public static final String _serializedATN =
		"\u0004\u0001\u000b4\u0002\u0000\u0007\u0000\u0002\u0001\u0007\u0001\u0002"+
		"\u0002\u0007\u0002\u0001\u0000\u0004\u0000\b\b\u0000\u000b\u0000\f\u0000"+
		"\t\u0001\u0001\u0001\u0001\u0001\u0001\u0001\u0001\u0001\u0001\u0001\u0001"+
		"\u0001\u0001\u0001\u0001\u0001\u0001\u0001\u0001\u0001\u0001\u0003\u0001"+
		"\u0017\b\u0001\u0001\u0002\u0001\u0002\u0001\u0002\u0001\u0002\u0001\u0002"+
		"\u0001\u0002\u0001\u0002\u0001\u0002\u0001\u0002\u0001\u0002\u0003\u0002"+
		"#\b\u0002\u0001\u0002\u0001\u0002\u0001\u0002\u0001\u0002\u0001\u0002"+
		"\u0001\u0002\u0001\u0002\u0001\u0002\u0001\u0002\u0001\u0002\u0005\u0002"+
		"/\b\u0002\n\u0002\f\u00022\t\u0002\u0001\u0002\u0000\u0001\u0004\u0003"+
		"\u0000\u0002\u0004\u0000\u0002\u0001\u0000\u0004\u0005\u0001\u0000\u0006"+
		"\u00077\u0000\u0007\u0001\u0000\u0000\u0000\u0002\u0016\u0001\u0000\u0000"+
		"\u0000\u0004\"\u0001\u0000\u0000\u0000\u0006\b\u0003\u0002\u0001\u0000"+
		"\u0007\u0006\u0001\u0000\u0000\u0000\b\t\u0001\u0000\u0000\u0000\t\u0007"+
		"\u0001\u0000\u0000\u0000\t\n\u0001\u0000\u0000\u0000\n\u0001\u0001\u0000"+
		"\u0000\u0000\u000b\f\u0003\u0004\u0002\u0000\f\r\u0005\n\u0000\u0000\r"+
		"\u000e\u0006\u0001\uffff\uffff\u0000\u000e\u0017\u0001\u0000\u0000\u0000"+
		"\u000f\u0010\u0005\b\u0000\u0000\u0010\u0011\u0005\u0001\u0000\u0000\u0011"+
		"\u0012\u0003\u0004\u0002\u0000\u0012\u0013\u0005\n\u0000\u0000\u0013\u0014"+
		"\u0006\u0001\uffff\uffff\u0000\u0014\u0017\u0001\u0000\u0000\u0000\u0015"+
		"\u0017\u0005\n\u0000\u0000\u0016\u000b\u0001\u0000\u0000\u0000\u0016\u000f"+
		"\u0001\u0000\u0000\u0000\u0016\u0015\u0001\u0000\u0000\u0000\u0017\u0003"+
		"\u0001\u0000\u0000\u0000\u0018\u0019\u0006\u0002\uffff\uffff\u0000\u0019"+
		"\u001a\u0005\t\u0000\u0000\u001a#\u0006\u0002\uffff\uffff\u0000\u001b"+
		"\u001c\u0005\b\u0000\u0000\u001c#\u0006\u0002\uffff\uffff\u0000\u001d"+
		"\u001e\u0005\u0002\u0000\u0000\u001e\u001f\u0003\u0004\u0002\u0000\u001f"+
		" \u0005\u0003\u0000\u0000 !\u0006\u0002\uffff\uffff\u0000!#\u0001\u0000"+
		"\u0000\u0000\"\u0018\u0001\u0000\u0000\u0000\"\u001b\u0001\u0000\u0000"+
		"\u0000\"\u001d\u0001\u0000\u0000\u0000#0\u0001\u0000\u0000\u0000$%\n\u0005"+
		"\u0000\u0000%&\u0007\u0000\u0000\u0000&\'\u0003\u0004\u0002\u0006\'(\u0006"+
		"\u0002\uffff\uffff\u0000(/\u0001\u0000\u0000\u0000)*\n\u0004\u0000\u0000"+
		"*+\u0007\u0001\u0000\u0000+,\u0003\u0004\u0002\u0005,-\u0006\u0002\uffff"+
		"\uffff\u0000-/\u0001\u0000\u0000\u0000.$\u0001\u0000\u0000\u0000.)\u0001"+
		"\u0000\u0000\u0000/2\u0001\u0000\u0000\u00000.\u0001\u0000\u0000\u0000"+
		"01\u0001\u0000\u0000\u00001\u0005\u0001\u0000\u0000\u000020\u0001\u0000"+
		"\u0000\u0000\u0005\t\u0016\".0";
	public static final ATN _ATN =
		new ATNDeserializer().deserialize(_serializedATN.toCharArray());
	static {
		_decisionToDFA = new DFA[_ATN.getNumberOfDecisions()];
		for (int i = 0; i < _ATN.getNumberOfDecisions(); i++) {
			_decisionToDFA[i] = new DFA(_ATN.getDecisionState(i), i);
		}
	}
}