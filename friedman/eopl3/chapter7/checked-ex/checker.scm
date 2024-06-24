(module checker (lib "eopl.ss" "eopl")

  (require "drscheme-init.scm")
  (require "lang.scm")

  (provide type-of type-of-program)

  ;; check-equal-type! : Type * Type * Exp -> Unspecified
  ;; Page: 242
  (define check-equal-type!
    (lambda (ty1 ty2 exp)
      (when (not (equal? ty1 ty2))
        (report-unequal-types ty1 ty2 exp))))

  (define check-equal-types!
    (lambda (tys1 tys2 exp)
      (if (eq? (length tys1)
               (length tys2))
          (when (not (null? tys1))
            (begin
              (check-equal-type! (car tys1) (car tys2) exp)
              (check-equal-types! (cdr tys1) (cdr tys2) exp)))
          (eopl:error 'check-equal-types!
                      "types count didn't match in ~a:~%tys1:~a~%tys2:~a"
                      exp
                      tys1
                      tys2))))

  ;; report-unequal-types : Type * Type * Exp -> Unspecified
  ;; Page: 243
  (define report-unequal-types
    (lambda (ty1 ty2 exp)
      (begin
        (display ty1)
        (newline)
        (display ty2)
        (newline)
        (eopl:error 'check-equal-type!  
                    "Types didn't match: ~s != ~a in~%~a"
                    (type-to-external-form ty1)
                    (type-to-external-form ty2)
                    exp))))

  ;;;;;;;;;;;;;;;; The Type Checker ;;;;;;;;;;;;;;;;
  
  ;; type-of-program : Program -> Type
  ;; Page: 244
  (define type-of-program
    (lambda (pgm)
      (cases program pgm
        (a-program (exp1) (type-of exp1 (init-tenv))))))

  ;; type-of : Exp * Tenv -> Type
  ;; Page 244--246
  (define type-of
    (lambda (exp tenv)
      (cases expression exp

        ;; \commentbox{\hastype{\tenv}{\mv{num}}{\mathtt{int}}}
        (const-exp (num) (int-type))

        ;; \commentbox{\hastype{\tenv}{\var{}}{\tenv{}(\var{})}}
        (var-exp (var) (apply-tenv tenv var))

        ;; \commentbox{\diffrule}
        (diff-exp (exp1 exp2)
          (let ((ty1 (type-of exp1 tenv))
                (ty2 (type-of exp2 tenv)))
            (check-equal-type! ty1 (int-type) exp1)
            (check-equal-type! ty2 (int-type) exp2)
            (int-type)))

        ;; \commentbox{\zerorule}
        (zero?-exp (exp1)
          (let ((ty1 (type-of exp1 tenv)))
            (check-equal-type! ty1 (int-type) exp1)
            (bool-type)))

        ;; \commentbox{\condrule}
        (if-exp (exp1 exp2 exp3)
          (let ((ty1 (type-of exp1 tenv))
                (ty2 (type-of exp2 tenv))
                (ty3 (type-of exp3 tenv)))
            (check-equal-type! ty1 (bool-type) exp1)
            (check-equal-type! ty2 ty3 exp)
            ty2))

        ;; \commentbox{\letrule}
        ;; Exercise 7.5
        (let-exp
         (vars exps body)
         (let ((exp-types (map
                           (lambda (exp1) (type-of exp1 tenv))
                           exps)))
           (type-of body
                    (extend-tenv* vars exp-types tenv))))
        
        ;; \commentbox{\procrulechurch}
        (proc-exp (vars var-types body)
                  (let ((result-type
                         (type-of body
                                  (extend-tenv* vars var-types tenv))))
                    (proc-type var-types result-type)))

        ;; \commentbox{\apprule}
        (call-exp (rator rands) 
          (let ((rator-type (type-of rator tenv))
                (rand-types  (map (lambda (rand)
                                    (type-of rand tenv))
                                  rands)))
            (cases type rator-type
              (proc-type (arg-types result-type)
                (begin
                  (check-equal-types! arg-types rand-types exp)
                  result-type))
              (else
                (report-rator-not-a-proc-type rator-type rator)))))

        ;; \commentbox{\letrecrule}
        (letrec-exp (p-result-types p-names b-vars-list b-var-types-list p-bodies
                      letrec-body)
          (let ((tenv-for-letrec-body
                  (extend-tenv* p-names
                                (map (lambda (p-result-type b-var-types)
                                       (proc-type b-var-types p-result-type))
                                     p-result-types
                                     b-var-types-list)
                                tenv)))
            (let check-p-body-types ([p-result-types p-result-types]
                                     [b-vars-list b-vars-list]
                                     [b-var-types-list b-var-types-list]
                                     [p-bodies p-bodies])
              (when (not (null? p-result-types))
                (let ([p-body-type
                       (type-of (car p-bodies)
                                (extend-tenv* (car b-vars-list)
                                              (car b-var-types-list)
                                              tenv-for-letrec-body))])
                  (check-equal-type!
                   p-body-type (car p-result-types) (car p-bodies))
                  (check-p-body-types (cdr p-result-types)
                                      (cdr b-vars-list)
                                      (cdr b-var-types-list)
                                      (cdr p-bodies)))))
            
            (type-of letrec-body tenv-for-letrec-body)))

        )))
    
  (define report-rator-not-a-proc-type
    (lambda (rator-type rator)
      (eopl:error 'type-of-expression
        "Rator not a proc type:~%~s~%had rator type ~s"   
           rator 
           (type-to-external-form rator-type))))

  ;;;;;;;;;;;;;;;; type environments ;;;;;;;;;;;;;;;;
    
  (define-datatype type-environment type-environment?
    (empty-tenv-record)
    (extended-tenv-record
      (sym symbol?)
      (type type?)
      (tenv type-environment?)))
    
  (define empty-tenv empty-tenv-record)
  (define extend-tenv extended-tenv-record)

  (define extend-tenv*
    (lambda (syms types tenv)
      (if (null? syms)
          tenv
          (extend-tenv* (cdr syms)
                        (cdr types)
                        (extended-tenv-record
                         (car syms)
                         (car types)
                         tenv)))))
    
  (define apply-tenv 
    (lambda (tenv sym)
      (cases type-environment tenv
        (empty-tenv-record ()
                           (eopl:error 'apply-tenv "Unbound variable ~s" sym))
        (extended-tenv-record (sym1 val1 old-env)
                              (if (eqv? sym sym1) 
                                  val1
                                  (apply-tenv old-env sym))))))
  
  (define init-tenv
    (lambda ()
      (extend-tenv 'x (int-type) 
        (extend-tenv 'v (int-type)
          (extend-tenv 'i (int-type)
            (empty-tenv))))))

  )
