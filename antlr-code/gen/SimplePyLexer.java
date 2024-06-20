// Generated from /Users/mxm/learn/snippets/antlr-code/original/lexmagic/SimplePy.g4 by ANTLR 4.13.1
import org.antlr.v4.runtime.Lexer;
import org.antlr.v4.runtime.CharStream;
import org.antlr.v4.runtime.Token;
import org.antlr.v4.runtime.TokenStream;
import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.atn.*;
import org.antlr.v4.runtime.dfa.DFA;
import org.antlr.v4.runtime.misc.*;

@SuppressWarnings({"all", "warnings", "unchecked", "unused", "cast", "CheckReturnValue", "this-escape"})
public class SimplePyLexer extends Lexer {
	static { RuntimeMetaData.checkVersion("4.13.1", RuntimeMetaData.VERSION); }

	protected static final DFA[] _decisionToDFA;
	protected static final PredictionContextCache _sharedContextCache =
		new PredictionContextCache();
	public static final int
		T__0=1, T__1=2, T__2=3, ID=4, INT=5, LPAREN=6, RPAREN=7, LBRACK=8, RBRACK=9, 
		IGNORE_NEWLINE=10, NEWLINE=11, WS=12, LINE_ESCAPE=13, COMMENT=14;
	public static String[] channelNames = {
		"DEFAULT_TOKEN_CHANNEL", "HIDDEN"
	};

	public static String[] modeNames = {
		"DEFAULT_MODE"
	};

	private static String[] makeRuleNames() {
		return new String[] {
			"T__0", "T__1", "T__2", "ID", "INT", "LPAREN", "RPAREN", "LBRACK", "RBRACK", 
			"IGNORE_NEWLINE", "NEWLINE", "WS", "LINE_ESCAPE", "COMMENT"
		};
	}
	public static final String[] ruleNames = makeRuleNames();

	private static String[] makeLiteralNames() {
		return new String[] {
			null, "'='", "'+'", "','", null, null, "'('", "')'", "'['", "']'"
		};
	}
	private static final String[] _LITERAL_NAMES = makeLiteralNames();
	private static String[] makeSymbolicNames() {
		return new String[] {
			null, null, null, null, "ID", "INT", "LPAREN", "RPAREN", "LBRACK", "RBRACK", 
			"IGNORE_NEWLINE", "NEWLINE", "WS", "LINE_ESCAPE", "COMMENT"
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


	    int nesting = 0;


	public SimplePyLexer(CharStream input) {
		super(input);
		_interp = new LexerATNSimulator(this,_ATN,_decisionToDFA,_sharedContextCache);
	}

	@Override
	public String getGrammarFileName() { return "SimplePy.g4"; }

	@Override
	public String[] getRuleNames() { return ruleNames; }

	@Override
	public String getSerializedATN() { return _serializedATN; }

	@Override
	public String[] getChannelNames() { return channelNames; }

	@Override
	public String[] getModeNames() { return modeNames; }

	@Override
	public ATN getATN() { return _ATN; }

	@Override
	public void action(RuleContext _localctx, int ruleIndex, int actionIndex) {
		switch (ruleIndex) {
		case 5:
			LPAREN_action((RuleContext)_localctx, actionIndex);
			break;
		case 6:
			RPAREN_action((RuleContext)_localctx, actionIndex);
			break;
		case 7:
			LBRACK_action((RuleContext)_localctx, actionIndex);
			break;
		case 8:
			RBRACK_action((RuleContext)_localctx, actionIndex);
			break;
		}
	}
	private void LPAREN_action(RuleContext _localctx, int actionIndex) {
		switch (actionIndex) {
		case 0:
			nesting++;
			break;
		}
	}
	private void RPAREN_action(RuleContext _localctx, int actionIndex) {
		switch (actionIndex) {
		case 1:
			nesting--;
			break;
		}
	}
	private void LBRACK_action(RuleContext _localctx, int actionIndex) {
		switch (actionIndex) {
		case 2:
			nesting++;
			break;
		}
	}
	private void RBRACK_action(RuleContext _localctx, int actionIndex) {
		switch (actionIndex) {
		case 3:
			nesting--;
			break;
		}
	}
	@Override
	public boolean sempred(RuleContext _localctx, int ruleIndex, int predIndex) {
		switch (ruleIndex) {
		case 9:
			return IGNORE_NEWLINE_sempred((RuleContext)_localctx, predIndex);
		}
		return true;
	}
	private boolean IGNORE_NEWLINE_sempred(RuleContext _localctx, int predIndex) {
		switch (predIndex) {
		case 0:
			return nesting>0;
		}
		return true;
	}

	public static final String _serializedATN =
		"\u0004\u0000\u000e`\u0006\uffff\uffff\u0002\u0000\u0007\u0000\u0002\u0001"+
		"\u0007\u0001\u0002\u0002\u0007\u0002\u0002\u0003\u0007\u0003\u0002\u0004"+
		"\u0007\u0004\u0002\u0005\u0007\u0005\u0002\u0006\u0007\u0006\u0002\u0007"+
		"\u0007\u0007\u0002\b\u0007\b\u0002\t\u0007\t\u0002\n\u0007\n\u0002\u000b"+
		"\u0007\u000b\u0002\f\u0007\f\u0002\r\u0007\r\u0001\u0000\u0001\u0000\u0001"+
		"\u0001\u0001\u0001\u0001\u0002\u0001\u0002\u0001\u0003\u0001\u0003\u0005"+
		"\u0003&\b\u0003\n\u0003\f\u0003)\t\u0003\u0001\u0004\u0004\u0004,\b\u0004"+
		"\u000b\u0004\f\u0004-\u0001\u0005\u0001\u0005\u0001\u0005\u0001\u0006"+
		"\u0001\u0006\u0001\u0006\u0001\u0007\u0001\u0007\u0001\u0007\u0001\b\u0001"+
		"\b\u0001\b\u0001\t\u0003\t=\b\t\u0001\t\u0001\t\u0001\t\u0001\t\u0001"+
		"\t\u0001\n\u0003\nE\b\n\u0001\n\u0001\n\u0001\u000b\u0004\u000bJ\b\u000b"+
		"\u000b\u000b\f\u000bK\u0001\u000b\u0001\u000b\u0001\f\u0001\f\u0003\f"+
		"R\b\f\u0001\f\u0001\f\u0001\f\u0001\f\u0001\r\u0001\r\u0005\rZ\b\r\n\r"+
		"\f\r]\t\r\u0001\r\u0001\r\u0000\u0000\u000e\u0001\u0001\u0003\u0002\u0005"+
		"\u0003\u0007\u0004\t\u0005\u000b\u0006\r\u0007\u000f\b\u0011\t\u0013\n"+
		"\u0015\u000b\u0017\f\u0019\r\u001b\u000e\u0001\u0000\u0005\u0003\u0000"+
		"AZ__az\u0004\u000009AZ__az\u0001\u000009\u0002\u0000\t\t  \u0002\u0000"+
		"\n\n\r\rf\u0000\u0001\u0001\u0000\u0000\u0000\u0000\u0003\u0001\u0000"+
		"\u0000\u0000\u0000\u0005\u0001\u0000\u0000\u0000\u0000\u0007\u0001\u0000"+
		"\u0000\u0000\u0000\t\u0001\u0000\u0000\u0000\u0000\u000b\u0001\u0000\u0000"+
		"\u0000\u0000\r\u0001\u0000\u0000\u0000\u0000\u000f\u0001\u0000\u0000\u0000"+
		"\u0000\u0011\u0001\u0000\u0000\u0000\u0000\u0013\u0001\u0000\u0000\u0000"+
		"\u0000\u0015\u0001\u0000\u0000\u0000\u0000\u0017\u0001\u0000\u0000\u0000"+
		"\u0000\u0019\u0001\u0000\u0000\u0000\u0000\u001b\u0001\u0000\u0000\u0000"+
		"\u0001\u001d\u0001\u0000\u0000\u0000\u0003\u001f\u0001\u0000\u0000\u0000"+
		"\u0005!\u0001\u0000\u0000\u0000\u0007#\u0001\u0000\u0000\u0000\t+\u0001"+
		"\u0000\u0000\u0000\u000b/\u0001\u0000\u0000\u0000\r2\u0001\u0000\u0000"+
		"\u0000\u000f5\u0001\u0000\u0000\u0000\u00118\u0001\u0000\u0000\u0000\u0013"+
		"<\u0001\u0000\u0000\u0000\u0015D\u0001\u0000\u0000\u0000\u0017I\u0001"+
		"\u0000\u0000\u0000\u0019O\u0001\u0000\u0000\u0000\u001bW\u0001\u0000\u0000"+
		"\u0000\u001d\u001e\u0005=\u0000\u0000\u001e\u0002\u0001\u0000\u0000\u0000"+
		"\u001f \u0005+\u0000\u0000 \u0004\u0001\u0000\u0000\u0000!\"\u0005,\u0000"+
		"\u0000\"\u0006\u0001\u0000\u0000\u0000#\'\u0007\u0000\u0000\u0000$&\u0007"+
		"\u0001\u0000\u0000%$\u0001\u0000\u0000\u0000&)\u0001\u0000\u0000\u0000"+
		"\'%\u0001\u0000\u0000\u0000\'(\u0001\u0000\u0000\u0000(\b\u0001\u0000"+
		"\u0000\u0000)\'\u0001\u0000\u0000\u0000*,\u0007\u0002\u0000\u0000+*\u0001"+
		"\u0000\u0000\u0000,-\u0001\u0000\u0000\u0000-+\u0001\u0000\u0000\u0000"+
		"-.\u0001\u0000\u0000\u0000.\n\u0001\u0000\u0000\u0000/0\u0005(\u0000\u0000"+
		"01\u0006\u0005\u0000\u00001\f\u0001\u0000\u0000\u000023\u0005)\u0000\u0000"+
		"34\u0006\u0006\u0001\u00004\u000e\u0001\u0000\u0000\u000056\u0005[\u0000"+
		"\u000067\u0006\u0007\u0002\u00007\u0010\u0001\u0000\u0000\u000089\u0005"+
		"]\u0000\u00009:\u0006\b\u0003\u0000:\u0012\u0001\u0000\u0000\u0000;=\u0005"+
		"\r\u0000\u0000<;\u0001\u0000\u0000\u0000<=\u0001\u0000\u0000\u0000=>\u0001"+
		"\u0000\u0000\u0000>?\u0005\n\u0000\u0000?@\u0004\t\u0000\u0000@A\u0001"+
		"\u0000\u0000\u0000AB\u0006\t\u0004\u0000B\u0014\u0001\u0000\u0000\u0000"+
		"CE\u0005\r\u0000\u0000DC\u0001\u0000\u0000\u0000DE\u0001\u0000\u0000\u0000"+
		"EF\u0001\u0000\u0000\u0000FG\u0005\n\u0000\u0000G\u0016\u0001\u0000\u0000"+
		"\u0000HJ\u0007\u0003\u0000\u0000IH\u0001\u0000\u0000\u0000JK\u0001\u0000"+
		"\u0000\u0000KI\u0001\u0000\u0000\u0000KL\u0001\u0000\u0000\u0000LM\u0001"+
		"\u0000\u0000\u0000MN\u0006\u000b\u0004\u0000N\u0018\u0001\u0000\u0000"+
		"\u0000OQ\u0005\\\u0000\u0000PR\u0005\r\u0000\u0000QP\u0001\u0000\u0000"+
		"\u0000QR\u0001\u0000\u0000\u0000RS\u0001\u0000\u0000\u0000ST\u0005\n\u0000"+
		"\u0000TU\u0001\u0000\u0000\u0000UV\u0006\f\u0004\u0000V\u001a\u0001\u0000"+
		"\u0000\u0000W[\u0005#\u0000\u0000XZ\b\u0004\u0000\u0000YX\u0001\u0000"+
		"\u0000\u0000Z]\u0001\u0000\u0000\u0000[Y\u0001\u0000\u0000\u0000[\\\u0001"+
		"\u0000\u0000\u0000\\^\u0001\u0000\u0000\u0000][\u0001\u0000\u0000\u0000"+
		"^_\u0006\r\u0004\u0000_\u001c\u0001\u0000\u0000\u0000\b\u0000\'-<DKQ["+
		"\u0005\u0001\u0005\u0000\u0001\u0006\u0001\u0001\u0007\u0002\u0001\b\u0003"+
		"\u0006\u0000\u0000";
	public static final ATN _ATN =
		new ATNDeserializer().deserialize(_serializedATN.toCharArray());
	static {
		_decisionToDFA = new DFA[_ATN.getNumberOfDecisions()];
		for (int i = 0; i < _ATN.getNumberOfDecisions(); i++) {
			_decisionToDFA[i] = new DFA(_ATN.getDecisionState(i), i);
		}
	}
}