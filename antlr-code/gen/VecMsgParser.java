// Generated from /Users/mxm/learn/snippets/antlr-code/original/errors/VecMsg.g4 by ANTLR 4.13.1
import org.antlr.v4.runtime.atn.*;
import org.antlr.v4.runtime.dfa.DFA;
import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.misc.*;
import org.antlr.v4.runtime.tree.*;
import java.util.List;
import java.util.Iterator;
import java.util.ArrayList;

@SuppressWarnings({"all", "warnings", "unchecked", "unused", "cast", "CheckReturnValue"})
public class VecMsgParser extends Parser {
	static { RuntimeMetaData.checkVersion("4.13.1", RuntimeMetaData.VERSION); }

	protected static final DFA[] _decisionToDFA;
	protected static final PredictionContextCache _sharedContextCache =
		new PredictionContextCache();
	public static final int
		T__0=1, T__1=2, T__2=3, INT=4, WS=5;
	public static final int
		RULE_vec4 = 0, RULE_ints = 1;
	private static String[] makeRuleNames() {
		return new String[] {
			"vec4", "ints"
		};
	}
	public static final String[] ruleNames = makeRuleNames();

	private static String[] makeLiteralNames() {
		return new String[] {
			null, "'['", "']'", "','"
		};
	}
	private static final String[] _LITERAL_NAMES = makeLiteralNames();
	private static String[] makeSymbolicNames() {
		return new String[] {
			null, null, null, null, "INT", "WS"
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
	public String getGrammarFileName() { return "VecMsg.g4"; }

	@Override
	public String[] getRuleNames() { return ruleNames; }

	@Override
	public String getSerializedATN() { return _serializedATN; }

	@Override
	public ATN getATN() { return _ATN; }

	public VecMsgParser(TokenStream input) {
		super(input);
		_interp = new ParserATNSimulator(this,_ATN,_decisionToDFA,_sharedContextCache);
	}

	@SuppressWarnings("CheckReturnValue")
	public static class Vec4Context extends ParserRuleContext {
		public IntsContext ints() {
			return getRuleContext(IntsContext.class,0);
		}
		public Vec4Context(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_vec4; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VecMsgListener ) ((VecMsgListener)listener).enterVec4(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VecMsgListener ) ((VecMsgListener)listener).exitVec4(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VecMsgVisitor ) return ((VecMsgVisitor<? extends T>)visitor).visitVec4(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Vec4Context vec4() throws RecognitionException {
		Vec4Context _localctx = new Vec4Context(_ctx, getState());
		enterRule(_localctx, 0, RULE_vec4);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(4);
			match(T__0);
			setState(5);
			ints(4);
			setState(6);
			match(T__1);
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
	public static class IntsContext extends ParserRuleContext {
		public int max;
		public int i = 1;
		public List<TerminalNode> INT() { return getTokens(VecMsgParser.INT); }
		public TerminalNode INT(int i) {
			return getToken(VecMsgParser.INT, i);
		}
		public IntsContext(ParserRuleContext parent, int invokingState) { super(parent, invokingState); }
		public IntsContext(ParserRuleContext parent, int invokingState, int max) {
			super(parent, invokingState);
			this.max = max;
		}
		@Override public int getRuleIndex() { return RULE_ints; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VecMsgListener ) ((VecMsgListener)listener).enterInts(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VecMsgListener ) ((VecMsgListener)listener).exitInts(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VecMsgVisitor ) return ((VecMsgVisitor<? extends T>)visitor).visitInts(this);
			else return visitor.visitChildren(this);
		}
	}

	public final IntsContext ints(int max) throws RecognitionException {
		IntsContext _localctx = new IntsContext(_ctx, getState(), max);
		enterRule(_localctx, 2, RULE_ints);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(8);
			match(INT);
			setState(15);
			_errHandler.sync(this);
			_la = _input.LA(1);
			while (_la==T__2) {
				{
				{
				setState(9);
				match(T__2);
				_localctx.i++;
				setState(11);
				if (!(_localctx.i<=_localctx.max)) throw new FailedPredicateException(this, "$i<=$max", "exceeded max "+_localctx.max);
				setState(12);
				match(INT);
				}
				}
				setState(17);
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

	public boolean sempred(RuleContext _localctx, int ruleIndex, int predIndex) {
		switch (ruleIndex) {
		case 1:
			return ints_sempred((IntsContext)_localctx, predIndex);
		}
		return true;
	}
	private boolean ints_sempred(IntsContext _localctx, int predIndex) {
		switch (predIndex) {
		case 0:
			return _localctx.i<=_localctx.max;
		}
		return true;
	}

	public static final String _serializedATN =
		"\u0004\u0001\u0005\u0013\u0002\u0000\u0007\u0000\u0002\u0001\u0007\u0001"+
		"\u0001\u0000\u0001\u0000\u0001\u0000\u0001\u0000\u0001\u0001\u0001\u0001"+
		"\u0001\u0001\u0001\u0001\u0001\u0001\u0005\u0001\u000e\b\u0001\n\u0001"+
		"\f\u0001\u0011\t\u0001\u0001\u0001\u0000\u0000\u0002\u0000\u0002\u0000"+
		"\u0000\u0011\u0000\u0004\u0001\u0000\u0000\u0000\u0002\b\u0001\u0000\u0000"+
		"\u0000\u0004\u0005\u0005\u0001\u0000\u0000\u0005\u0006\u0003\u0002\u0001"+
		"\u0000\u0006\u0007\u0005\u0002\u0000\u0000\u0007\u0001\u0001\u0000\u0000"+
		"\u0000\b\u000f\u0005\u0004\u0000\u0000\t\n\u0005\u0003\u0000\u0000\n\u000b"+
		"\u0006\u0001\uffff\uffff\u0000\u000b\f\u0004\u0001\u0000\u0001\f\u000e"+
		"\u0005\u0004\u0000\u0000\r\t\u0001\u0000\u0000\u0000\u000e\u0011\u0001"+
		"\u0000\u0000\u0000\u000f\r\u0001\u0000\u0000\u0000\u000f\u0010\u0001\u0000"+
		"\u0000\u0000\u0010\u0003\u0001\u0000\u0000\u0000\u0011\u000f\u0001\u0000"+
		"\u0000\u0000\u0001\u000f";
	public static final ATN _ATN =
		new ATNDeserializer().deserialize(_serializedATN.toCharArray());
	static {
		_decisionToDFA = new DFA[_ATN.getNumberOfDecisions()];
		for (int i = 0; i < _ATN.getNumberOfDecisions(); i++) {
			_decisionToDFA[i] = new DFA(_ATN.getDecisionState(i), i);
		}
	}
}