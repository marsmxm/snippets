// Generated from /Users/mxm/learn/snippets/antlr-code/original/structures/Comment.g4 by ANTLR 4.13.1
import org.antlr.v4.runtime.tree.ParseTreeVisitor;

/**
 * This interface defines a complete generic visitor for a parse tree produced
 * by {@link CommentParser}.
 *
 * @param <T> The return type of the visit operation. Use {@link Void} for
 * operations with no return type.
 */
public interface CommentVisitor<T> extends ParseTreeVisitor<T> {
	/**
	 * Visit a parse tree produced by {@link CommentParser#file}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitFile(CommentParser.FileContext ctx);
}