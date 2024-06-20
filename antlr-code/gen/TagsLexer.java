// Generated from /Users/mxm/learn/snippets/antlr-code/original/lexmagic/Tags.g4 by ANTLR 4.13.1
import org.antlr.v4.runtime.Lexer;
import org.antlr.v4.runtime.CharStream;
import org.antlr.v4.runtime.Token;
import org.antlr.v4.runtime.TokenStream;
import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.atn.*;
import org.antlr.v4.runtime.dfa.DFA;
import org.antlr.v4.runtime.misc.*;

@SuppressWarnings({"all", "warnings", "unchecked", "unused", "cast", "CheckReturnValue", "this-escape"})
public class TagsLexer extends Lexer {
	static { RuntimeMetaData.checkVersion("4.13.1", RuntimeMetaData.VERSION); }

	protected static final DFA[] _decisionToDFA;
	protected static final PredictionContextCache _sharedContextCache =
		new PredictionContextCache();
	public static final int
		COMMENT=1, CDATA=2, TAG=3, ENTITY=4, TEXT=5;
	public static String[] channelNames = {
		"DEFAULT_TOKEN_CHANNEL", "HIDDEN"
	};

	public static String[] modeNames = {
		"DEFAULT_MODE"
	};

	private static String[] makeRuleNames() {
		return new String[] {
			"COMMENT", "CDATA", "TAG", "ENTITY", "TEXT"
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
			null, "COMMENT", "CDATA", "TAG", "ENTITY", "TEXT"
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


	public TagsLexer(CharStream input) {
		super(input);
		_interp = new LexerATNSimulator(this,_ATN,_decisionToDFA,_sharedContextCache);
	}

	@Override
	public String getGrammarFileName() { return "Tags.g4"; }

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
		"\u0004\u0000\u0005G\u0006\uffff\uffff\u0002\u0000\u0007\u0000\u0002\u0001"+
		"\u0007\u0001\u0002\u0002\u0007\u0002\u0002\u0003\u0007\u0003\u0002\u0004"+
		"\u0007\u0004\u0001\u0000\u0001\u0000\u0001\u0000\u0001\u0000\u0001\u0000"+
		"\u0001\u0000\u0005\u0000\u0012\b\u0000\n\u0000\f\u0000\u0015\t\u0000\u0001"+
		"\u0000\u0001\u0000\u0001\u0000\u0001\u0000\u0001\u0000\u0001\u0000\u0001"+
		"\u0001\u0001\u0001\u0001\u0001\u0001\u0001\u0001\u0001\u0001\u0001\u0001"+
		"\u0001\u0001\u0001\u0001\u0001\u0001\u0001\u0001\u0001\u0005\u0001(\b"+
		"\u0001\n\u0001\f\u0001+\t\u0001\u0001\u0001\u0001\u0001\u0001\u0001\u0001"+
		"\u0001\u0001\u0002\u0001\u0002\u0005\u00023\b\u0002\n\u0002\f\u00026\t"+
		"\u0002\u0001\u0002\u0001\u0002\u0001\u0003\u0001\u0003\u0005\u0003<\b"+
		"\u0003\n\u0003\f\u0003?\t\u0003\u0001\u0003\u0001\u0003\u0001\u0004\u0004"+
		"\u0004D\b\u0004\u000b\u0004\f\u0004E\u0004\u0013)4=\u0000\u0005\u0001"+
		"\u0001\u0003\u0002\u0005\u0003\u0007\u0004\t\u0005\u0001\u0000\u0001\u0002"+
		"\u0000&&<<K\u0000\u0001\u0001\u0000\u0000\u0000\u0000\u0003\u0001\u0000"+
		"\u0000\u0000\u0000\u0005\u0001\u0000\u0000\u0000\u0000\u0007\u0001\u0000"+
		"\u0000\u0000\u0000\t\u0001\u0000\u0000\u0000\u0001\u000b\u0001\u0000\u0000"+
		"\u0000\u0003\u001c\u0001\u0000\u0000\u0000\u00050\u0001\u0000\u0000\u0000"+
		"\u00079\u0001\u0000\u0000\u0000\tC\u0001\u0000\u0000\u0000\u000b\f\u0005"+
		"<\u0000\u0000\f\r\u0005!\u0000\u0000\r\u000e\u0005-\u0000\u0000\u000e"+
		"\u000f\u0005-\u0000\u0000\u000f\u0013\u0001\u0000\u0000\u0000\u0010\u0012"+
		"\t\u0000\u0000\u0000\u0011\u0010\u0001\u0000\u0000\u0000\u0012\u0015\u0001"+
		"\u0000\u0000\u0000\u0013\u0014\u0001\u0000\u0000\u0000\u0013\u0011\u0001"+
		"\u0000\u0000\u0000\u0014\u0016\u0001\u0000\u0000\u0000\u0015\u0013\u0001"+
		"\u0000\u0000\u0000\u0016\u0017\u0005-\u0000\u0000\u0017\u0018\u0005-\u0000"+
		"\u0000\u0018\u0019\u0005>\u0000\u0000\u0019\u001a\u0001\u0000\u0000\u0000"+
		"\u001a\u001b\u0006\u0000\u0000\u0000\u001b\u0002\u0001\u0000\u0000\u0000"+
		"\u001c\u001d\u0005<\u0000\u0000\u001d\u001e\u0005!\u0000\u0000\u001e\u001f"+
		"\u0005[\u0000\u0000\u001f \u0005C\u0000\u0000 !\u0005D\u0000\u0000!\""+
		"\u0005A\u0000\u0000\"#\u0005T\u0000\u0000#$\u0005A\u0000\u0000$%\u0005"+
		"[\u0000\u0000%)\u0001\u0000\u0000\u0000&(\t\u0000\u0000\u0000\'&\u0001"+
		"\u0000\u0000\u0000(+\u0001\u0000\u0000\u0000)*\u0001\u0000\u0000\u0000"+
		")\'\u0001\u0000\u0000\u0000*,\u0001\u0000\u0000\u0000+)\u0001\u0000\u0000"+
		"\u0000,-\u0005]\u0000\u0000-.\u0005]\u0000\u0000./\u0005>\u0000\u0000"+
		"/\u0004\u0001\u0000\u0000\u000004\u0005<\u0000\u000013\t\u0000\u0000\u0000"+
		"21\u0001\u0000\u0000\u000036\u0001\u0000\u0000\u000045\u0001\u0000\u0000"+
		"\u000042\u0001\u0000\u0000\u000057\u0001\u0000\u0000\u000064\u0001\u0000"+
		"\u0000\u000078\u0005>\u0000\u00008\u0006\u0001\u0000\u0000\u00009=\u0005"+
		"&\u0000\u0000:<\t\u0000\u0000\u0000;:\u0001\u0000\u0000\u0000<?\u0001"+
		"\u0000\u0000\u0000=>\u0001\u0000\u0000\u0000=;\u0001\u0000\u0000\u0000"+
		">@\u0001\u0000\u0000\u0000?=\u0001\u0000\u0000\u0000@A\u0005;\u0000\u0000"+
		"A\b\u0001\u0000\u0000\u0000BD\b\u0000\u0000\u0000CB\u0001\u0000\u0000"+
		"\u0000DE\u0001\u0000\u0000\u0000EC\u0001\u0000\u0000\u0000EF\u0001\u0000"+
		"\u0000\u0000F\n\u0001\u0000\u0000\u0000\u0006\u0000\u0013)4=E\u0001\u0006"+
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