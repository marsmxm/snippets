// Generated from /Users/mxm/learn/snippets/antlr-code/original/reference/foo/Count.g4 by ANTLR 4.13.1

package foo;

import org.antlr.v4.runtime.tree.AbstractParseTreeVisitor;

/**
 * This class provides an empty implementation of {@link CountVisitor},
 * which can be extended to create a visitor which only needs to handle a subset
 * of the available methods.
 *
 * @param <T> The return type of the visit operation. Use {@link Void} for
 * operations with no return type.
 */
@SuppressWarnings("CheckReturnValue")
public class CountBaseVisitor<T> extends AbstractParseTreeVisitor<T> implements CountVisitor<T> {
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation returns the result of calling
	 * {@link #visitChildren} on {@code ctx}.</p>
	 */
	@Override public T visitList(CountParser.ListContext ctx) { return visitChildren(ctx); }
}