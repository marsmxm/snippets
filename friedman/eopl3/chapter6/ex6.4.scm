(module
 top
 (lib "eopl.ss" "eopl")
        
 (define end-cont
  (lambda (v)
    (begin
      (eopl:printf "End of computation. ~%")
      (eopl:printf "This sentence should appear only once.~%")
      v)))
 
 (define remove-first
  (lambda (s los)
    (if (null? los)
        '()
        (if (eqv? (car los) s)
            (cdr los)
            (cons (car los) (remove-first s (cdr los)))))))

 (define remove-first/k
  (lambda (s los cont)
    (if (null? los)
        (cont '())
        (if (eqv? (car los) s)
            (cont (cdr los))
            (remove-first/k
             s (cdr los) (lambda (v)
                           (cont (cons (car los) v))))))))

 (define list-sum
   (lambda (loi)
     (if (null? loi)
         0
         (+ (car loi)
            (list-sum (cdr loi))))))

 (define list-sum/k
   (lambda (loi cont)
     (if (null? loi)
         (cont 0)
         (list-sum/k (cdr loi)
                     (lambda (v)
                       (cont (+ (car loi) v)))))))

 (define occurs-free?
   (lambda (var exp)
     (cond
       [(symbol? exp) (eqv? var exp)]
       [(eqv? (car exp) 'lambda)
        (and (not (eqv? var (car (cadr exp))))
             (occurs-free? var (caddr exp)))]
       [else (or (occurs-free? var (car exp))
                 (occurs-free? var (cadr exp)))])))

 (define occurs-free?/k
   (lambda (var exp cont)
     (cond
       [(symbol? exp) (cont (eqv? var exp))]
       [(eqv? (car exp) 'lambda)
        (if (not (eqv? var (car (cadr exp))))
            (cont #t)
            (occurs-free?/k var (caddr exp) cont))]
       [else (occurs-free?/k var (car exp)
                             (lambda (v)
                               (if v
                                   (cont v)
                                   (occurs-free?/k var (cadr exp) cont))))])))

 (define subst
   (lambda (new old slist)
     (if (null? slist)
         '()
         (cons
          (subst-in-s-sexp new old (car slist))
          (subst new old (cdr slist))))))
 (define subst-in-s-sexp
   (lambda (new old sexp)
     (if (symbol? sexp)
         (if (eqv? sexp old) new sexp)
         (subst new old sexp))))

 (define subst/k
   (lambda (new old slist cont)
     (if (null? slist)
         (cont '())
         (subst-in-s-sexp/k new old (car slist)
                            (lambda (v1)
                              (subst/k new old (cdr slist)
                                       (lambda (v2)
                                         (cont (cons v1 v2)))))))))
 (define subst-in-s-sexp/k
   (lambda (new old sexp cont)
     (if (symbol? sexp)
         (if (eqv? sexp old)
             (cont new)
             (cont sexp))
         (subst/k new old sexp cont))))
 
  
 )
