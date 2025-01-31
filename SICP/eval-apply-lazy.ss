(library (eval-apply-lazy)
  (export driver-loop-lazy)
  (import (rnrs) (rnrs mutable-pairs))

  (define apply-in-underlying-scheme apply)

  (define (list-of-values exps env)
    (if (no-operands? exps)
        '()
        (cons (eval (first-operand exps) env)
              (list-of-values (rest-operands exps) env))))

  (define (eval-if exp env)
    (if (true? (actual-value (if-predicate exp) env))
        (eval (if-consequent exp) env)
        (eval (if-alternative exp) env)))
  
  (define (eval-sequence exps env)
    (cond ((last-exp? exps) (eval (first-exp exps) env))
          (else (eval (first-exp exps) env)
                (eval-sequence (rest-exps exps) env))))

  (define (eval-assignment exp env)
    (set-variable-value! (assignment-variable exp)
                         (eval (assignment-value exp) env)
                         env)
    'ok)

  (define (eval-definition exp env)
    (define-variable! (definition-variable exp)
      (eval (definition-value exp) env)
      env)
    'ok)


  ;; 4.1.2  Representing Expressions
  (define (self-evaluating? exp)
    (cond
     [(number? exp) #t]
     [(string? exp) #t]
     [else #f]))

  (define (variable? exp) (symbol? exp))

  (define (quoted? exp)
    (tagged-list? exp 'quote))

  (define (text-of-quotation exp) (cadr exp))

  (define (tagged-list? exp tag)
    (if (pair? exp)
        (eq? (car exp) tag)
        #f))

  (define (assignment? exp)
    (tagged-list? exp 'set!))
  (define (assignment-variable exp) (cadr exp))
  (define (assignment-value exp) (caddr exp))

  (define (definition? exp)
    (tagged-list? exp 'define))
  (define (definition-variable exp)
    (if (symbol? (cadr exp))
        (cadr exp)
        (caadr exp)))
  (define (definition-value exp)
    (if (symbol? (cadr exp))
        (caddr exp)
        (make-lambda (cdadr exp)   ; formal parameters
                     (cddr exp)))) ; body

  (define (lambda? exp) (tagged-list? exp 'lambda))
  (define (lambda-parameters exp) (cadr exp))
  (define (lambda-body exp) (cddr exp))
  (define (make-lambda parameters body)
    (cons 'lambda (cons parameters body)))

  (define (if? exp) (tagged-list? exp 'if))
  (define (if-predicate exp) (cadr exp))
  (define (if-consequent exp) (caddr exp))
  (define (if-alternative exp)
    (if (not (null? (cdddr exp)))
        (cadddr exp)
        'false))

  (define (make-if predicate consequent alternative)
    (list 'if predicate consequent alternative))

  (define (begin? exp) (tagged-list? exp 'begin))
  (define (begin-actions exp) (cdr exp))
  (define (last-exp? seq) (null? (cdr seq)))
  (define (first-exp seq) (car seq))
  (define (rest-exps seq) (cdr seq))

  (define (sequence->exp seq)
    (cond ((null? seq) seq)
          ((last-exp? seq) (first-exp seq))
          (else (make-begin seq))))
  (define (make-begin seq) (cons 'begin seq))

  (define (application? exp) (pair? exp))
  (define (operator exp) (car exp))
  (define (operands exp) (cdr exp))
  (define (no-operands? ops) (null? ops))
  (define (first-operand ops) (car ops))
  (define (rest-operands ops) (cdr ops))

  (define (cond? exp) (tagged-list? exp 'cond))
  (define (cond-clauses exp) (cdr exp))
  (define (cond-else-clause? clause)
    (eq? (cond-predicate clause) 'else))
  (define (cond-predicate clause) (car clause))
  (define (cond-actions clause) (cdr clause))
  (define (cond->if exp)
    (expand-clauses (cond-clauses exp)))
  (define (cond-arrow-clause? clause)
    (eq? '=> (cadr clause)))
  (define cond-lambda caddr)

  (define (expand-clauses clauses)
    (if (null? clauses)
        'false                          ; no else clause
        (let ((first (car clauses))
              (rest (cdr clauses)))
          (if (cond-else-clause? first)
              (if (null? rest)
                  (sequence->exp (cond-actions first))
                  (error "ELSE clause isn't last -- COND->IF"
                         clauses))
              (if (cond-arrow-clause? first)
                  (make-if (cond-predicate first)
                           (list (cond-lambda first) (cond-predicate first))
                           (expand-clauses rest))
                  (make-if (cond-predicate first)
                           (sequence->exp (cond-actions first))
                           (expand-clauses rest)))))))
  (define unzip
    (lambda (pairs)
      (if (null? pairs)
          '(() ())
          (let ([pair (car pairs)]
                [ans (unzip (cdr pairs))])
            (list (cons (car pair) (car ans))
                  (cons (cadr pair) (cadr ans)))))))

  (define (let? exp) (tagged-list? exp 'let))

  (define (named-let? exp)
    (let ([second (cadr exp)])
      (and (not (pair? second))
           (not (null? second)))))

  (define let->combination
    (lambda (exp)
      (if (named-let? exp)
          (let ([name (cadr exp)]
                [two-lists (unzip (caddr exp))])
            (sequence->exp
             (list (list 'define (cons name (car two-lists)) (cdddr exp))
                   (cons name (cadr two-lists)))))
          (let ([two-lists (unzip (cadr exp))])
            (list (make-lambda (car two-lists) (cddr exp))
                  (cadr two-lists))))))

  ;; Exercise 4.7
  (define make-let
    (lambda (bindings body)
      (list 'let bindings body)))

  (define let*?
    (lambda (exp) (tagged-list? exp 'let*)))

  (define let*->nested-lets
    (lambda (exp)
      (let ([bindings (cadr exp)]
            [body (caddr exp)])
        (if (null? bindings)
            (make-let bindings body)
            (make-let (list (car bindings))
                      (let*->nested-lets (list 'let* (cdr bindings) body)))))))


  ;; Evaluator Data Structures
  (define (true? x)
    (not (eq? x 'false)))
  (define (false? x)
    (eq? x 'false))
  
  (define (make-procedure parameters body env)
    (list 'procedure parameters (scan-out-defines body) env))
  (define (compound-procedure? p)
    (tagged-list? p 'procedure))
  (define (procedure-parameters p) (cadr p))
  (define (procedure-body p) (caddr p))
  (define (procedure-environment p) (cadddr p))

  (define scan-out-defines
    (lambda (pbody)
      (define (transform defs new-body)
        (cons 'let
              (cons (map (lambda (def) (list (definition-variable def)
                                             '*unassigned*))
                         defs)
                    (append
                     (map (lambda (def) (list 'set!
                                              (definition-variable def)
                                              (definition-value def)))
                          defs)
                     new-body))))
      (if (or (null? pbody)
              (not (definition? (car pbody))))
          pbody
          (let extract ([defs '()]
                        [body pbody])
            (if (null? body)
                (transform defs body)
                (let ([exp (car body)])
                  (if (definition? exp)
                      (extract (cons exp defs) (cdr body))
                      (transform defs body))))))))


  (define (enclosing-environment env) (cdr env))
  (define (first-frame env) (car env))
  (define the-empty-environment '())

  (define (make-frame variables values)
    (cons variables values))
  (define (frame-variables frame) (car frame))
  (define (frame-values frame) (cdr frame))
  (define (add-binding-to-frame! var val frame)
    (set-car! frame (cons var (car frame)))
    (set-cdr! frame (cons val (cdr frame))))

  (define (extend-environment vars vals base-env)
    (if (= (length vars) (length vals))
        (cons (make-frame vars vals) base-env)
        (if (< (length vars) (length vals))
            (error 'extend "Too many arguments supplied" vars vals)
            (error 'extend "Too few arguments supplied" vars vals))))

  (define (lookup-variable-value var env)
    (define (env-loop env)
      (define (scan vars vals)
        (cond ((null? vars)
               (env-loop (enclosing-environment env)))
              ((eq? var (car vars))
               (car vals))
              (else (scan (cdr vars) (cdr vals)))))
      (if (eq? env the-empty-environment)
          (error 'lookup "Unbound variable" var)
          (let* ((frame (first-frame env))
                 (value 
                  (scan (frame-variables frame)
                        (frame-values frame))))
            (if (eq? value '*unassigned*)
                (error 'lookup "Unassaigned variable" var)
                value))))
    (env-loop env))

  (define (set-variable-value! var val env)
    (define (env-loop env)
      (define (scan vars vals)
        (cond ((null? vars)
               (env-loop (enclosing-environment env)))
              ((eq? var (car vars))
               (set-car! vals val))
              (else (scan (cdr vars) (cdr vals)))))
      (if (eq? env the-empty-environment)
          (error 'set-var "Unbound variable -- SET!" var)
          (let ((frame (first-frame env)))
            (scan (frame-variables frame)
                  (frame-values frame)))))
    (env-loop env))

  (define (define-variable! var val env)
    (let ((frame (first-frame env)))
      (define (scan vars vals)
        (cond ((null? vars)
               (add-binding-to-frame! var val frame))
              ((eq? var (car vars))
               (set-car! vals val))
              (else (scan (cdr vars) (cdr vals)))))
      (scan (frame-variables frame)
            (frame-values frame))))
  (define (primitive-procedure? proc)
    (tagged-list? proc 'primitive))

  (define (primitive-implementation proc) (cadr proc))

  (define primitive-procedures
    (list (list '+ +)
          (list '- -)
          (list '* *)
          (list '/ /)
          (list '= =)
          (list 'car car)
          (list 'cdr cdr)
          (list 'cons cons)
          (list 'list list)
          (list 'map map)
          (list 'null? null?)))

  (define (primitive-procedure-names)
    (map car
         primitive-procedures))

  (define (primitive-procedure-objects)
    (map (lambda (proc) (list 'primitive (cadr proc)))
         primitive-procedures))

  (define (setup-environment)
    (let ((initial-env
           (extend-environment (primitive-procedure-names)
                               (primitive-procedure-objects)
                               the-empty-environment)))
      (define-variable! 'true #t initial-env)
      (define-variable! 'false #f initial-env)
      initial-env))
  (define the-global-environment (setup-environment))

  (define (apply-primitive-procedure proc args)
    (apply-in-underlying-scheme
     (primitive-implementation proc) args))

  (define input-prompt ";;; M-Eval input:")
  (define output-prompt ";;; M-Eval value:")
  (define (driver-loop)
    (prompt-for-input input-prompt)
    (let ((input (read)))
      (let ((output (eval input the-global-environment)))
        (announce-output output-prompt)
        (user-print output)))
    (driver-loop))
  (define (prompt-for-input string)
    (newline) (newline) (display string) (newline))

  (define (announce-output string)
    (newline) (display string) (newline))

  (define (user-print object)
    (if (compound-procedure? object)
        (display (list 'compound-procedure
                       (procedure-parameters object)
                       (procedure-body object)
                       '<procedure-env>))
        (display object)))

  (define (actual-value exp env)
    (force-it (eval exp env)))

  (define (eval exp env)
    (cond ((self-evaluating? exp) exp)
          ((variable? exp) (lookup-variable-value exp env))
          ((quoted? exp) (text-of-quotation exp))
          ((assignment? exp) (eval-assignment exp env))
          ((definition? exp) (eval-definition exp env))
          ((if? exp) (eval-if exp env))
          ((lambda? exp)
           (make-procedure (lambda-parameters exp)
                           (lambda-body exp)
                           env))
          ((begin? exp) 
           (eval-sequence (begin-actions exp) env))
          ((cond? exp) (eval (cond->if exp) env))
          ((let? exp) (eval (let->combination exp) env))
          ((application? exp)
           (apply-lazy (actual-value (operator exp) env)
                       (operands exp)
                       env))
          (else
           (error 'eval "Unknown expression type" exp))))

  (define (apply-lazy procedure arguments env)
    (cond ((primitive-procedure? procedure)
           (apply-primitive-procedure
            procedure
            (list-of-arg-values arguments env))) ; changed
          ((compound-procedure? procedure)
           (eval-sequence
            (procedure-body procedure)
            (extend-environment
             (procedure-parameters procedure)
             (list-of-delayed-args arguments env) ; changed
             (procedure-environment procedure))))
          (else
           (error 'apply-lazy "Unknown procedure type" procedure))))

  (define (list-of-arg-values exps env)
    (if (no-operands? exps)
        '()
        (cons (actual-value (first-operand exps) env)
              (list-of-arg-values (rest-operands exps)
                                  env))))

  (define (list-of-delayed-args exps env)
    (if (no-operands? exps)
        '()
        (cons (delay-it (first-operand exps) env)
              (list-of-delayed-args (rest-operands exps)
                                    env))))

  (define input-prompt-lazy ";;; L-Eval input:")
  (define output-prompt-lazy ";;; L-Eval value:")
  (define (driver-loop-lazy)
    (prompt-for-input input-prompt-lazy)
    (let ([input (read)])
      (let ([output (actual-value input the-global-environment)])
        (announce-output output-prompt)
        (user-print output)))
    (driver-loop-lazy))

  (define (delay-it exp env)
    (list 'thunk exp env))

  (define (thunk? obj)
    (tagged-list? obj 'thunk))

  (define (thunk-exp thunk) (cadr thunk))

  (define (thunk-env thunk) (caddr thunk))

  (define (evaluated-thunk? obj)
    (tagged-list? obj 'evaluated-thunk))

  (define (thunk-value evaluated-thunk) (cadr evaluated-thunk))

  (define (force-it obj)
    (cond ((thunk? obj)
           (let ((result (actual-value
                          (thunk-exp obj)
                          (thunk-env obj))))
             (set-car! obj 'evaluated-thunk)
             (set-car! (cdr obj) result)  ; replace exp with its value
             (set-cdr! (cdr obj) '())     ; forget unneeded env
             result))
          ((evaluated-thunk? obj)
           (thunk-value obj))
          (else obj))))

