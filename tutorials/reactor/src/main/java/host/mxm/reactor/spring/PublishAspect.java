package host.mxm.reactor.spring;

import static host.mxm.reactor.RequestContextCoreSubscriber.CONTEXT_THREAD_LOCAL;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.stereotype.Component;

import reactor.core.publisher.Mono;
import reactor.core.scheduler.Schedulers;

/**
 *
 * @author Mu Xian Ming (Sam)
 */
@Aspect
@Component
public class PublishAspect {
    @Before("execution(public * host.mxm.reactor.spring.*.*(..))")
    public void beforeAny(JoinPoint joinPoint) {
        String name = "before " + joinPoint.getSignature().getName();
        System.err.println(name + " thread: " + Thread.currentThread().getName());
        System.err.println(name + " context: " + CONTEXT_THREAD_LOCAL.get());

        Mono.just("publish")
            .publishOn(Schedulers.elastic())
            .flatMap(s -> {
                System.err.println(name + ".flatMap thread: " + Thread.currentThread().getName());
                System.err.println(name + ".flatMap context: " + CONTEXT_THREAD_LOCAL.get());
                return Mono.just(s + "haha");
            })
            .subscribe();
    }
}
