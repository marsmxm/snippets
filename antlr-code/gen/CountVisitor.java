// Generated from /Users/mxm/learn/snippets/antlr-code/original/reference/foo/Count.g4 by ANTLR 4.13.1

package foo;

import org.antlr.v4.runtime.tree.ParseTreeVisitor;

/**
 * This interface defines a complete generic visitor for a parse tree produced
 * by {@link CountParser}.
 *
 * @param <T> The return type of the visit operation. Use {@link Void} for
 * operations with no return type.
 */
public interface CountVisitor<T> extends ParseTreeVisitor<T> {
	/**
	 * Visit a parse tree produced by {@link CountParser#list}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitList(CountParser.ListContext ctx);
}