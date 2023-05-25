// Generated from /Users/mxm/learn/snippets/antlr-code/src/main/java/ink/mxm/tour/XMLLexer.g4 by ANTLR 4.12.0
package ink.mxm.tour;
import org.antlr.v4.runtime.Lexer;
import org.antlr.v4.runtime.CharStream;
import org.antlr.v4.runtime.Token;
import org.antlr.v4.runtime.TokenStream;
import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.atn.*;
import org.antlr.v4.runtime.dfa.DFA;
import org.antlr.v4.runtime.misc.*;

@SuppressWarnings({"all", "warnings", "unchecked", "unused", "cast", "CheckReturnValue"})
public class XMLLexer extends Lexer {
	static { RuntimeMetaData.checkVersion("4.12.0", RuntimeMetaData.VERSION); }

	protected static final DFA[] _decisionToDFA;
	protected static final PredictionContextCache _sharedContextCache =
		new PredictionContextCache();
	public static final int
		OPEN=1, COMMENT=2, EntityRef=3, TEXT=4, CLOSE=5, SLASH_CLOSE=6, EQUALS=7, 
		STRING=8, SlashName=9, Name=10, S=11;
	public static final int
		INSIDE=1;
	public static String[] channelNames = {
		"DEFAULT_TOKEN_CHANNEL", "HIDDEN"
	};

	public static String[] modeNames = {
		"DEFAULT_MODE", "INSIDE"
	};

	private static String[] makeRuleNames() {
		return new String[] {
			"OPEN", "COMMENT", "EntityRef", "TEXT", "CLOSE", "SLASH_CLOSE", "EQUALS", 
			"STRING", "SlashName", "Name", "S", "ALPHA", "DIGIT"
		};
	}
	public static final String[] ruleNames = makeRuleNames();

	private static String[] makeLiteralNames() {
		return new String[] {
			null, "'<'", null, null, null, "'>'", "'/>'", "'='"
		};
	}
	private static final String[] _LITERAL_NAMES = makeLiteralNames();
	private static String[] makeSymbolicNames() {
		return new String[] {
			null, "OPEN", "COMMENT", "EntityRef", "TEXT", "CLOSE", "SLASH_CLOSE", 
			"EQUALS", "STRING", "SlashName", "Name", "S"
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


	public XMLLexer(CharStream input) {
		super(input);
		_interp = new LexerATNSimulator(this,_ATN,_decisionToDFA,_sharedContextCache);
	}

	@Override
	public String getGrammarFileName() { return "XMLLexer.g4"; }

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
		"\u0004\u0000\u000be\u0006\uffff\uffff\u0006\uffff\uffff\u0002\u0000\u0007"+
		"\u0000\u0002\u0001\u0007\u0001\u0002\u0002\u0007\u0002\u0002\u0003\u0007"+
		"\u0003\u0002\u0004\u0007\u0004\u0002\u0005\u0007\u0005\u0002\u0006\u0007"+
		"\u0006\u0002\u0007\u0007\u0007\u0002\b\u0007\b\u0002\t\u0007\t\u0002\n"+
		"\u0007\n\u0002\u000b\u0007\u000b\u0002\f\u0007\f\u0001\u0000\u0001\u0000"+
		"\u0001\u0000\u0001\u0000\u0001\u0001\u0001\u0001\u0001\u0001\u0001\u0001"+
		"\u0001\u0001\u0001\u0001\u0005\u0001\'\b\u0001\n\u0001\f\u0001*\t\u0001"+
		"\u0001\u0001\u0001\u0001\u0001\u0001\u0001\u0001\u0001\u0001\u0001\u0001"+
		"\u0001\u0002\u0001\u0002\u0004\u00024\b\u0002\u000b\u0002\f\u00025\u0001"+
		"\u0002\u0001\u0002\u0001\u0003\u0004\u0003;\b\u0003\u000b\u0003\f\u0003"+
		"<\u0001\u0004\u0001\u0004\u0001\u0004\u0001\u0004\u0001\u0005\u0001\u0005"+
		"\u0001\u0005\u0001\u0005\u0001\u0005\u0001\u0006\u0001\u0006\u0001\u0007"+
		"\u0001\u0007\u0005\u0007L\b\u0007\n\u0007\f\u0007O\t\u0007\u0001\u0007"+
		"\u0001\u0007\u0001\b\u0001\b\u0001\b\u0001\t\u0001\t\u0001\t\u0005\tY"+
		"\b\t\n\t\f\t\\\t\t\u0001\n\u0001\n\u0001\n\u0001\n\u0001\u000b\u0001\u000b"+
		"\u0001\f\u0001\f\u0002(M\u0000\r\u0002\u0001\u0004\u0002\u0006\u0003\b"+
		"\u0004\n\u0005\f\u0006\u000e\u0007\u0010\b\u0012\t\u0014\n\u0016\u000b"+
		"\u0018\u0000\u001a\u0000\u0002\u0000\u0001\u0005\u0001\u0000az\u0002\u0000"+
		"&&<<\u0003\u0000\t\n\r\r  \u0002\u0000AZaz\u0001\u000009g\u0000\u0002"+
		"\u0001\u0000\u0000\u0000\u0000\u0004\u0001\u0000\u0000\u0000\u0000\u0006"+
		"\u0001\u0000\u0000\u0000\u0000\b\u0001\u0000\u0000\u0000\u0001\n\u0001"+
		"\u0000\u0000\u0000\u0001\f\u0001\u0000\u0000\u0000\u0001\u000e\u0001\u0000"+
		"\u0000\u0000\u0001\u0010\u0001\u0000\u0000\u0000\u0001\u0012\u0001\u0000"+
		"\u0000\u0000\u0001\u0014\u0001\u0000\u0000\u0000\u0001\u0016\u0001\u0000"+
		"\u0000\u0000\u0002\u001c\u0001\u0000\u0000\u0000\u0004 \u0001\u0000\u0000"+
		"\u0000\u00061\u0001\u0000\u0000\u0000\b:\u0001\u0000\u0000\u0000\n>\u0001"+
		"\u0000\u0000\u0000\fB\u0001\u0000\u0000\u0000\u000eG\u0001\u0000\u0000"+
		"\u0000\u0010I\u0001\u0000\u0000\u0000\u0012R\u0001\u0000\u0000\u0000\u0014"+
		"U\u0001\u0000\u0000\u0000\u0016]\u0001\u0000\u0000\u0000\u0018a\u0001"+
		"\u0000\u0000\u0000\u001ac\u0001\u0000\u0000\u0000\u001c\u001d\u0005<\u0000"+
		"\u0000\u001d\u001e\u0001\u0000\u0000\u0000\u001e\u001f\u0006\u0000\u0000"+
		"\u0000\u001f\u0003\u0001\u0000\u0000\u0000 !\u0005<\u0000\u0000!\"\u0005"+
		"!\u0000\u0000\"#\u0005-\u0000\u0000#$\u0005-\u0000\u0000$(\u0001\u0000"+
		"\u0000\u0000%\'\t\u0000\u0000\u0000&%\u0001\u0000\u0000\u0000\'*\u0001"+
		"\u0000\u0000\u0000()\u0001\u0000\u0000\u0000(&\u0001\u0000\u0000\u0000"+
		")+\u0001\u0000\u0000\u0000*(\u0001\u0000\u0000\u0000+,\u0005-\u0000\u0000"+
		",-\u0005-\u0000\u0000-.\u0005>\u0000\u0000./\u0001\u0000\u0000\u0000/"+
		"0\u0006\u0001\u0001\u00000\u0005\u0001\u0000\u0000\u000013\u0005&\u0000"+
		"\u000024\u0007\u0000\u0000\u000032\u0001\u0000\u0000\u000045\u0001\u0000"+
		"\u0000\u000053\u0001\u0000\u0000\u000056\u0001\u0000\u0000\u000067\u0001"+
		"\u0000\u0000\u000078\u0005;\u0000\u00008\u0007\u0001\u0000\u0000\u0000"+
		"9;\b\u0001\u0000\u0000:9\u0001\u0000\u0000\u0000;<\u0001\u0000\u0000\u0000"+
		"<:\u0001\u0000\u0000\u0000<=\u0001\u0000\u0000\u0000=\t\u0001\u0000\u0000"+
		"\u0000>?\u0005>\u0000\u0000?@\u0001\u0000\u0000\u0000@A\u0006\u0004\u0002"+
		"\u0000A\u000b\u0001\u0000\u0000\u0000BC\u0005/\u0000\u0000CD\u0005>\u0000"+
		"\u0000DE\u0001\u0000\u0000\u0000EF\u0006\u0005\u0002\u0000F\r\u0001\u0000"+
		"\u0000\u0000GH\u0005=\u0000\u0000H\u000f\u0001\u0000\u0000\u0000IM\u0005"+
		"\"\u0000\u0000JL\t\u0000\u0000\u0000KJ\u0001\u0000\u0000\u0000LO\u0001"+
		"\u0000\u0000\u0000MN\u0001\u0000\u0000\u0000MK\u0001\u0000\u0000\u0000"+
		"NP\u0001\u0000\u0000\u0000OM\u0001\u0000\u0000\u0000PQ\u0005\"\u0000\u0000"+
		"Q\u0011\u0001\u0000\u0000\u0000RS\u0005/\u0000\u0000ST\u0003\u0014\t\u0000"+
		"T\u0013\u0001\u0000\u0000\u0000UZ\u0003\u0018\u000b\u0000VY\u0003\u0018"+
		"\u000b\u0000WY\u0003\u001a\f\u0000XV\u0001\u0000\u0000\u0000XW\u0001\u0000"+
		"\u0000\u0000Y\\\u0001\u0000\u0000\u0000ZX\u0001\u0000\u0000\u0000Z[\u0001"+
		"\u0000\u0000\u0000[\u0015\u0001\u0000\u0000\u0000\\Z\u0001\u0000\u0000"+
		"\u0000]^\u0007\u0002\u0000\u0000^_\u0001\u0000\u0000\u0000_`\u0006\n\u0001"+
		"\u0000`\u0017\u0001\u0000\u0000\u0000ab\u0007\u0003\u0000\u0000b\u0019"+
		"\u0001\u0000\u0000\u0000cd\u0007\u0004\u0000\u0000d\u001b\u0001\u0000"+
		"\u0000\u0000\b\u0000\u0001(5<MXZ\u0003\u0005\u0001\u0000\u0006\u0000\u0000"+
		"\u0004\u0000\u0000";
	public static final ATN _ATN =
		new ATNDeserializer().deserialize(_serializedATN.toCharArray());
	static {
		_decisionToDFA = new DFA[_ATN.getNumberOfDecisions()];
		for (int i = 0; i < _ATN.getNumberOfDecisions(); i++) {
			_decisionToDFA[i] = new DFA(_ATN.getDecisionState(i), i);
		}
	}
}