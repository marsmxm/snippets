// Generated from /Users/mxm/learn/snippets/antlr-code/original/reference/Actions.g4 by ANTLR 4.13.1
import org.antlr.v4.runtime.Lexer;
import org.antlr.v4.runtime.CharStream;
import org.antlr.v4.runtime.Token;
import org.antlr.v4.runtime.TokenStream;
import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.atn.*;
import org.antlr.v4.runtime.dfa.DFA;
import org.antlr.v4.runtime.misc.*;

@SuppressWarnings({"all", "warnings", "unchecked", "unused", "cast", "CheckReturnValue", "this-escape"})
public class ActionsLexer extends Lexer {
	static { RuntimeMetaData.checkVersion("4.13.1", RuntimeMetaData.VERSION); }

	protected static final DFA[] _decisionToDFA;
	protected static final PredictionContextCache _sharedContextCache =
		new PredictionContextCache();
	public static final int
		ACTION1=1, ACTION2=2, ACTION3=3, STRING=4, WS=5;
	public static String[] channelNames = {
		"DEFAULT_TOKEN_CHANNEL", "HIDDEN"
	};

	public static String[] modeNames = {
		"DEFAULT_MODE"
	};

	private static String[] makeRuleNames() {
		return new String[] {
			"ACTION1", "ACTION2", "ACTION3", "STRING", "WS"
		};
	}
	public static final String[] ruleNames = makeRuleNames();

	private static String[] makeLiteralNames() {
		return new String[] {
		};
	}
	private static final String[] _LITERAL_NAMES = makeLiteralNames();
	private static String[] makeSymbolicNames() {
		return new String[] {
			null, "ACTION1", "ACTION2", "ACTION3", "STRING", "WS"
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


	public ActionsLexer(CharStream input) {
		super(input);
		_interp = new LexerATNSimulator(this,_ATN,_decisionToDFA,_sharedContextCache);
	}

	@Override
	public String getGrammarFileName() { return "Actions.g4"; }

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
		"\u0004\u0000\u0005;\u0006\uffff\uffff\u0002\u0000\u0007\u0000\u0002\u0001"+
		"\u0007\u0001\u0002\u0002\u0007\u0002\u0002\u0003\u0007\u0003\u0002\u0004"+
		"\u0007\u0004\u0001\u0000\u0001\u0000\u0001\u0000\u0005\u0000\u000f\b\u0000"+
		"\n\u0000\f\u0000\u0012\t\u0000\u0001\u0000\u0001\u0000\u0001\u0001\u0001"+
		"\u0001\u0001\u0001\u0005\u0001\u0019\b\u0001\n\u0001\f\u0001\u001c\t\u0001"+
		"\u0001\u0001\u0001\u0001\u0001\u0002\u0001\u0002\u0001\u0002\u0005\u0002"+
		"#\b\u0002\n\u0002\f\u0002&\t\u0002\u0001\u0002\u0001\u0002\u0001\u0003"+
		"\u0001\u0003\u0001\u0003\u0001\u0003\u0005\u0003.\b\u0003\n\u0003\f\u0003"+
		"1\t\u0003\u0001\u0003\u0001\u0003\u0001\u0004\u0004\u00046\b\u0004\u000b"+
		"\u0004\f\u00047\u0001\u0004\u0001\u0004\u0003\u0010\u001a/\u0000\u0005"+
		"\u0001\u0001\u0003\u0002\u0005\u0003\u0007\u0004\t\u0005\u0001\u0000\u0003"+
		"\u0001\u0000\"\"\u0002\u0000\"\">>\u0003\u0000\t\n\r\r  C\u0000\u0001"+
		"\u0001\u0000\u0000\u0000\u0000\u0003\u0001\u0000\u0000\u0000\u0000\u0005"+
		"\u0001\u0000\u0000\u0000\u0000\u0007\u0001\u0000\u0000\u0000\u0000\t\u0001"+
		"\u0000\u0000\u0000\u0001\u000b\u0001\u0000\u0000\u0000\u0003\u0015\u0001"+
		"\u0000\u0000\u0000\u0005\u001f\u0001\u0000\u0000\u0000\u0007)\u0001\u0000"+
		"\u0000\u0000\t5\u0001\u0000\u0000\u0000\u000b\u0010\u0005{\u0000\u0000"+
		"\f\u000f\u0003\u0007\u0003\u0000\r\u000f\t\u0000\u0000\u0000\u000e\f\u0001"+
		"\u0000\u0000\u0000\u000e\r\u0001\u0000\u0000\u0000\u000f\u0012\u0001\u0000"+
		"\u0000\u0000\u0010\u0011\u0001\u0000\u0000\u0000\u0010\u000e\u0001\u0000"+
		"\u0000\u0000\u0011\u0013\u0001\u0000\u0000\u0000\u0012\u0010\u0001\u0000"+
		"\u0000\u0000\u0013\u0014\u0005}\u0000\u0000\u0014\u0002\u0001\u0000\u0000"+
		"\u0000\u0015\u001a\u0005[\u0000\u0000\u0016\u0019\u0003\u0007\u0003\u0000"+
		"\u0017\u0019\b\u0000\u0000\u0000\u0018\u0016\u0001\u0000\u0000\u0000\u0018"+
		"\u0017\u0001\u0000\u0000\u0000\u0019\u001c\u0001\u0000\u0000\u0000\u001a"+
		"\u001b\u0001\u0000\u0000\u0000\u001a\u0018\u0001\u0000\u0000\u0000\u001b"+
		"\u001d\u0001\u0000\u0000\u0000\u001c\u001a\u0001\u0000\u0000\u0000\u001d"+
		"\u001e\u0005]\u0000\u0000\u001e\u0004\u0001\u0000\u0000\u0000\u001f$\u0005"+
		"<\u0000\u0000 #\u0003\u0007\u0003\u0000!#\b\u0001\u0000\u0000\" \u0001"+
		"\u0000\u0000\u0000\"!\u0001\u0000\u0000\u0000#&\u0001\u0000\u0000\u0000"+
		"$\"\u0001\u0000\u0000\u0000$%\u0001\u0000\u0000\u0000%\'\u0001\u0000\u0000"+
		"\u0000&$\u0001\u0000\u0000\u0000\'(\u0005>\u0000\u0000(\u0006\u0001\u0000"+
		"\u0000\u0000)/\u0005\"\u0000\u0000*+\u0005\\\u0000\u0000+.\u0005\"\u0000"+
		"\u0000,.\t\u0000\u0000\u0000-*\u0001\u0000\u0000\u0000-,\u0001\u0000\u0000"+
		"\u0000.1\u0001\u0000\u0000\u0000/0\u0001\u0000\u0000\u0000/-\u0001\u0000"+
		"\u0000\u000002\u0001\u0000\u0000\u00001/\u0001\u0000\u0000\u000023\u0005"+
		"\"\u0000\u00003\b\u0001\u0000\u0000\u000046\u0007\u0002\u0000\u000054"+
		"\u0001\u0000\u0000\u000067\u0001\u0000\u0000\u000075\u0001\u0000\u0000"+
		"\u000078\u0001\u0000\u0000\u000089\u0001\u0000\u0000\u00009:\u0006\u0004"+
		"\u0000\u0000:\n\u0001\u0000\u0000\u0000\n\u0000\u000e\u0010\u0018\u001a"+
		"\"$-/7\u0001\u0006\u0000\u0000";
	public static final ATN _ATN =
		new ATNDeserializer().deserialize(_serializedATN.toCharArray());
	static {
		_decisionToDFA = new DFA[_ATN.getNumberOfDecisions()];
		for (int i = 0; i < _ATN.getNumberOfDecisions(); i++) {
			_decisionToDFA[i] = new DFA(_ATN.getDecisionState(i), i);
		}
	}
}