package host.mxm.reactor.spring;

import static host.mxm.reactor.RequestContextCoreSubscriber.CONTEXT_THREAD_LOCAL;

import org.springframework.core.Ordered;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Component;
import org.springframework.web.server.ServerWebExchange;
import org.springframework.web.server.WebFilter;
import org.springframework.web.server.WebFilterChain;

import reactor.core.publisher.Mono;
import reactor.util.context.Context;

/**
 *
 * @author Mu Xian Ming (Sam)
 */
@Order(Ordered.HIGHEST_PRECEDENCE)
@Component
public class ContextInitFilter implements WebFilter {
    @Override
    public Mono<Void> filter(ServerWebExchange exchange, WebFilterChain chain) {
        return chain.filter(exchange)
                    .subscriberContext(context -> {
                        System.err.println("context init thread: " + Thread.currentThread().getName());
                        Context newCtx = context.put("world", "world");
                        CONTEXT_THREAD_LOCAL.set(newCtx);
                        return newCtx;
                    });
    }
}
