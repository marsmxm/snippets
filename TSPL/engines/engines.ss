(library (tspl engines)
  (export make-engine timed-lambda)
  (import (rnrs) (tspl timer)) 

  (define make-engine
    (let ([do-complete #f] [do-expire #f])
      (define timer-handler
        (lambda ()
          (start-timer (call/cc do-expire) timer-handler)))
      (define new-engine
        (lambda (resume)
          (lambda (ticks complete expire)
            ((call/cc
              (lambda (escape)
                (set! do-complete
                      (lambda (ticks value)
                        (escape (lambda () (complete ticks value)))))
                (set! do-expire
                      (lambda (resume)
                        (escape (lambda () (expire (new-engine resume))))))
                (resume ticks)))))))
      (lambda (proc)
        (new-engine
         (lambda (ticks)
           (start-timer ticks timer-handler)
           (let ([value (proc)])
             (let ([ticks (stop-timer)])
               (do-complete ticks value)))))))) 

  (define-syntax timed-lambda
    (syntax-rules ()
      [(_ formals exp1 exp2 ...)
       (lambda formals (decrement-timer) exp1 exp2 ...)])))
