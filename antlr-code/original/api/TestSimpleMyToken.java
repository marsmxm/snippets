package ink.mxm.api; /***
 * Excerpted from "The Definitive ANTLR 4 Reference",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/tpantlr2 for more book information.
***/
import org.antlr.v4.runtime.ANTLRFileStream;
import org.antlr.v4.runtime.ANTLRInputStream;
import org.antlr.v4.runtime.CommonTokenStream;
import org.antlr.v4.runtime.ParserRuleContext;
import org.antlr.v4.runtime.Token;
import org.antlr.v4.runtime.tree.ParseTree;
import org.antlr.v4.runtime.tree.Tree;

import java.io.IOException;
import java.util.List;

public class TestSimpleMyToken {
	public static void main(String[] args) throws IOException {
		ANTLRInputStream input = new ANTLRFileStream(args[0]);
		SimpleLexer lexer = new SimpleLexer(input);
		MyTokenFactory factory = new MyTokenFactory(input);
		lexer.setTokenFactory(factory);
		CommonTokenStream tokens = new CommonTokenStream(lexer);

		// now, print all tokens
		tokens.fill();
		List<Token> alltokens = tokens.getTokens();
		for (Token t : alltokens) System.out.println(t.toString());

		// now parse
		SimpleParser parser = new SimpleParser(tokens);
		parser.setTokenFactory(factory);
		ParseTree t = parser.s();
		System.out.println(t.toStringTree(parser));
	}
}
