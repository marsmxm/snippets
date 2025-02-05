package ink.mxm.predicates;
/***
 * Excerpted from "The Definitive ANTLR 4 Reference",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/tpantlr2 for more book information.
***/
import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.tree.Trees;

import java.io.FileInputStream;
import java.io.InputStream;

public class TestEnum {
    public static void main(String[] args) throws Exception {
		int i = 0;
		EnumParser.java5 = false; // assume non-Java5 mode by default
		if ( args.length>0 && args[i].equals("-java5") ) {
			EnumParser.java5 = true;
			i++;
		}
		String inputFile = null;
		if ( args.length>i ) inputFile = args[i];
		InputStream is = System.in;
		if ( inputFile!=null ) {
			is = new FileInputStream(inputFile);
		}
		ANTLRInputStream input = new ANTLRInputStream(is);
		EnumLexer lexer = new EnumLexer(input);
		CommonTokenStream tokens = new CommonTokenStream(lexer);
		EnumParser parser = new EnumParser(tokens);
		parser.prog();
	}
}
