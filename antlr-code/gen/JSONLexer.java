// Generated from /Users/mxm/learn/snippets/antlr-code/original/listeners/JSON.g4 by ANTLR 4.13.1
import org.antlr.v4.runtime.Lexer;
import org.antlr.v4.runtime.CharStream;
import org.antlr.v4.runtime.Token;
import org.antlr.v4.runtime.TokenStream;
import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.atn.*;
import org.antlr.v4.runtime.dfa.DFA;
import org.antlr.v4.runtime.misc.*;

@SuppressWarnings({"all", "warnings", "unchecked", "unused", "cast", "CheckReturnValue", "this-escape"})
public class JSONLexer extends Lexer {
	static { RuntimeMetaData.checkVersion("4.13.1", RuntimeMetaData.VERSION); }

	protected static final DFA[] _decisionToDFA;
	protected static final PredictionContextCache _sharedContextCache =
		new PredictionContextCache();
	public static final int
		T__0=1, T__1=2, T__2=3, T__3=4, T__4=5, T__5=6, T__6=7, LCURLY=8, LBRACK=9, 
		STRING=10, NUMBER=11, WS=12;
	public static String[] channelNames = {
		"DEFAULT_TOKEN_CHANNEL", "HIDDEN"
	};

	public static String[] modeNames = {
		"DEFAULT_MODE"
	};

	private static String[] makeRuleNames() {
		return new String[] {
			"T__0", "T__1", "T__2", "T__3", "T__4", "T__5", "T__6", "LCURLY", "LBRACK", 
			"STRING", "ESC", "UNICODE", "HEX", "NUMBER", "INT", "EXP", "WS"
		};
	}
	public static final String[] ruleNames = makeRuleNames();

	private static String[] makeLiteralNames() {
		return new String[] {
			null, "','", "'}'", "']'", "':'", "'true'", "'false'", "'null'", "'{'", 
			"'['"
		};
	}
	private static final String[] _LITERAL_NAMES = makeLiteralNames();
	private static String[] makeSymbolicNames() {
		return new String[] {
			null, null, null, null, null, null, null, null, "LCURLY", "LBRACK", "STRING", 
			"NUMBER", "WS"
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


	public JSONLexer(CharStream input) {
		super(input);
		_interp = new LexerATNSimulator(this,_ATN,_decisionToDFA,_sharedContextCache);
	}

	@Override
	public String getGrammarFileName() { return "JSON.g4"; }

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

	public static final String _serializedATN =
		"\u0004\u0000\f\u0082\u0006\uffff\uffff\u0002\u0000\u0007\u0000\u0002\u0001"+
		"\u0007\u0001\u0002\u0002\u0007\u0002\u0002\u0003\u0007\u0003\u0002\u0004"+
		"\u0007\u0004\u0002\u0005\u0007\u0005\u0002\u0006\u0007\u0006\u0002\u0007"+
		"\u0007\u0007\u0002\b\u0007\b\u0002\t\u0007\t\u0002\n\u0007\n\u0002\u000b"+
		"\u0007\u000b\u0002\f\u0007\f\u0002\r\u0007\r\u0002\u000e\u0007\u000e\u0002"+
		"\u000f\u0007\u000f\u0002\u0010\u0007\u0010\u0001\u0000\u0001\u0000\u0001"+
		"\u0001\u0001\u0001\u0001\u0002\u0001\u0002\u0001\u0003\u0001\u0003\u0001"+
		"\u0004\u0001\u0004\u0001\u0004\u0001\u0004\u0001\u0004\u0001\u0005\u0001"+
		"\u0005\u0001\u0005\u0001\u0005\u0001\u0005\u0001\u0005\u0001\u0006\u0001"+
		"\u0006\u0001\u0006\u0001\u0006\u0001\u0006\u0001\u0007\u0001\u0007\u0001"+
		"\b\u0001\b\u0001\t\u0001\t\u0001\t\u0005\tC\b\t\n\t\f\tF\t\t\u0001\t\u0001"+
		"\t\u0001\n\u0001\n\u0001\n\u0003\nM\b\n\u0001\u000b\u0001\u000b\u0001"+
		"\u000b\u0001\u000b\u0001\u000b\u0001\u000b\u0001\f\u0001\f\u0001\r\u0003"+
		"\rX\b\r\u0001\r\u0001\r\u0001\r\u0001\r\u0003\r^\b\r\u0001\r\u0003\ra"+
		"\b\r\u0001\r\u0001\r\u0001\r\u0001\r\u0003\rg\b\r\u0001\r\u0003\rj\b\r"+
		"\u0001\u000e\u0001\u000e\u0001\u000e\u0005\u000eo\b\u000e\n\u000e\f\u000e"+
		"r\t\u000e\u0003\u000et\b\u000e\u0001\u000f\u0001\u000f\u0003\u000fx\b"+
		"\u000f\u0001\u000f\u0001\u000f\u0001\u0010\u0004\u0010}\b\u0010\u000b"+
		"\u0010\f\u0010~\u0001\u0010\u0001\u0010\u0000\u0000\u0011\u0001\u0001"+
		"\u0003\u0002\u0005\u0003\u0007\u0004\t\u0005\u000b\u0006\r\u0007\u000f"+
		"\b\u0011\t\u0013\n\u0015\u0000\u0017\u0000\u0019\u0000\u001b\u000b\u001d"+
		"\u0000\u001f\u0000!\f\u0001\u0000\u0006\u0002\u0000\"\"\\\\\b\u0000\""+
		"\"//\\\\bbffnnrrtt\u0003\u000009AFaf\u0002\u0000EEee\u0002\u0000++--\u0003"+
		"\u0000\t\n\r\r  \u0089\u0000\u0001\u0001\u0000\u0000\u0000\u0000\u0003"+
		"\u0001\u0000\u0000\u0000\u0000\u0005\u0001\u0000\u0000\u0000\u0000\u0007"+
		"\u0001\u0000\u0000\u0000\u0000\t\u0001\u0000\u0000\u0000\u0000\u000b\u0001"+
		"\u0000\u0000\u0000\u0000\r\u0001\u0000\u0000\u0000\u0000\u000f\u0001\u0000"+
		"\u0000\u0000\u0000\u0011\u0001\u0000\u0000\u0000\u0000\u0013\u0001\u0000"+
		"\u0000\u0000\u0000\u001b\u0001\u0000\u0000\u0000\u0000!\u0001\u0000\u0000"+
		"\u0000\u0001#\u0001\u0000\u0000\u0000\u0003%\u0001\u0000\u0000\u0000\u0005"+
		"\'\u0001\u0000\u0000\u0000\u0007)\u0001\u0000\u0000\u0000\t+\u0001\u0000"+
		"\u0000\u0000\u000b0\u0001\u0000\u0000\u0000\r6\u0001\u0000\u0000\u0000"+
		"\u000f;\u0001\u0000\u0000\u0000\u0011=\u0001\u0000\u0000\u0000\u0013?"+
		"\u0001\u0000\u0000\u0000\u0015I\u0001\u0000\u0000\u0000\u0017N\u0001\u0000"+
		"\u0000\u0000\u0019T\u0001\u0000\u0000\u0000\u001bi\u0001\u0000\u0000\u0000"+
		"\u001ds\u0001\u0000\u0000\u0000\u001fu\u0001\u0000\u0000\u0000!|\u0001"+
		"\u0000\u0000\u0000#$\u0005,\u0000\u0000$\u0002\u0001\u0000\u0000\u0000"+
		"%&\u0005}\u0000\u0000&\u0004\u0001\u0000\u0000\u0000\'(\u0005]\u0000\u0000"+
		"(\u0006\u0001\u0000\u0000\u0000)*\u0005:\u0000\u0000*\b\u0001\u0000\u0000"+
		"\u0000+,\u0005t\u0000\u0000,-\u0005r\u0000\u0000-.\u0005u\u0000\u0000"+
		"./\u0005e\u0000\u0000/\n\u0001\u0000\u0000\u000001\u0005f\u0000\u0000"+
		"12\u0005a\u0000\u000023\u0005l\u0000\u000034\u0005s\u0000\u000045\u0005"+
		"e\u0000\u00005\f\u0001\u0000\u0000\u000067\u0005n\u0000\u000078\u0005"+
		"u\u0000\u000089\u0005l\u0000\u00009:\u0005l\u0000\u0000:\u000e\u0001\u0000"+
		"\u0000\u0000;<\u0005{\u0000\u0000<\u0010\u0001\u0000\u0000\u0000=>\u0005"+
		"[\u0000\u0000>\u0012\u0001\u0000\u0000\u0000?D\u0005\"\u0000\u0000@C\u0003"+
		"\u0015\n\u0000AC\b\u0000\u0000\u0000B@\u0001\u0000\u0000\u0000BA\u0001"+
		"\u0000\u0000\u0000CF\u0001\u0000\u0000\u0000DB\u0001\u0000\u0000\u0000"+
		"DE\u0001\u0000\u0000\u0000EG\u0001\u0000\u0000\u0000FD\u0001\u0000\u0000"+
		"\u0000GH\u0005\"\u0000\u0000H\u0014\u0001\u0000\u0000\u0000IL\u0005\\"+
		"\u0000\u0000JM\u0007\u0001\u0000\u0000KM\u0003\u0017\u000b\u0000LJ\u0001"+
		"\u0000\u0000\u0000LK\u0001\u0000\u0000\u0000M\u0016\u0001\u0000\u0000"+
		"\u0000NO\u0005u\u0000\u0000OP\u0003\u0019\f\u0000PQ\u0003\u0019\f\u0000"+
		"QR\u0003\u0019\f\u0000RS\u0003\u0019\f\u0000S\u0018\u0001\u0000\u0000"+
		"\u0000TU\u0007\u0002\u0000\u0000U\u001a\u0001\u0000\u0000\u0000VX\u0005"+
		"-\u0000\u0000WV\u0001\u0000\u0000\u0000WX\u0001\u0000\u0000\u0000XY\u0001"+
		"\u0000\u0000\u0000YZ\u0003\u001d\u000e\u0000Z[\u0005.\u0000\u0000[]\u0003"+
		"\u001d\u000e\u0000\\^\u0003\u001f\u000f\u0000]\\\u0001\u0000\u0000\u0000"+
		"]^\u0001\u0000\u0000\u0000^j\u0001\u0000\u0000\u0000_a\u0005-\u0000\u0000"+
		"`_\u0001\u0000\u0000\u0000`a\u0001\u0000\u0000\u0000ab\u0001\u0000\u0000"+
		"\u0000bc\u0003\u001d\u000e\u0000cd\u0003\u001f\u000f\u0000dj\u0001\u0000"+
		"\u0000\u0000eg\u0005-\u0000\u0000fe\u0001\u0000\u0000\u0000fg\u0001\u0000"+
		"\u0000\u0000gh\u0001\u0000\u0000\u0000hj\u0003\u001d\u000e\u0000iW\u0001"+
		"\u0000\u0000\u0000i`\u0001\u0000\u0000\u0000if\u0001\u0000\u0000\u0000"+
		"j\u001c\u0001\u0000\u0000\u0000kt\u00050\u0000\u0000lp\u000219\u0000m"+
		"o\u000209\u0000nm\u0001\u0000\u0000\u0000or\u0001\u0000\u0000\u0000pn"+
		"\u0001\u0000\u0000\u0000pq\u0001\u0000\u0000\u0000qt\u0001\u0000\u0000"+
		"\u0000rp\u0001\u0000\u0000\u0000sk\u0001\u0000\u0000\u0000sl\u0001\u0000"+
		"\u0000\u0000t\u001e\u0001\u0000\u0000\u0000uw\u0007\u0003\u0000\u0000"+
		"vx\u0007\u0004\u0000\u0000wv\u0001\u0000\u0000\u0000wx\u0001\u0000\u0000"+
		"\u0000xy\u0001\u0000\u0000\u0000yz\u0003\u001d\u000e\u0000z \u0001\u0000"+
		"\u0000\u0000{}\u0007\u0005\u0000\u0000|{\u0001\u0000\u0000\u0000}~\u0001"+
		"\u0000\u0000\u0000~|\u0001\u0000\u0000\u0000~\u007f\u0001\u0000\u0000"+
		"\u0000\u007f\u0080\u0001\u0000\u0000\u0000\u0080\u0081\u0006\u0010\u0000"+
		"\u0000\u0081\"\u0001\u0000\u0000\u0000\r\u0000BDLW]`fipsw~\u0001\u0006"+
		"\u0000\u0000";
	public static final ATN _ATN =
		new ATNDeserializer().deserialize(_serializedATN.toCharArray());
	static {
		_decisionToDFA = new DFA[_ATN.getNumberOfDecisions()];
		for (int i = 0; i < _ATN.getNumberOfDecisions(); i++) {
			_decisionToDFA[i] = new DFA(_ATN.getDecisionState(i), i);
		}
	}
}