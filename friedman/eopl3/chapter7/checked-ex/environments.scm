(module environments (lib "eopl.ss" "eopl") 
  
  (require "data-structures.scm")

  (provide init-env empty-env extend-env apply-env)

;;;;;;;;;;;;;;;; initial environment ;;;;;;;;;;;;;;;;
  
  ;; init-env : () -> environment

  ;; (init-env) builds an environment in which i is bound to the
  ;; expressed value 1, v is bound to the expressed value 5, and x is
  ;; bound to the expressed value 10.  

  (define init-env 
    (lambda ()
      (extend-env 
       'i (num-val 1)
       (extend-env
        'v (num-val 5)
        (extend-env
         'x (num-val 10)
         (empty-env))))))

;;;;;;;;;;;;;;;; environment constructors and observers ;;;;;;;;;;;;;;;;

  (define apply-env
    (lambda (env search-sym)
      (cases environment env
        (empty-env ()
          (eopl:error 'apply-env "No binding for ~s" search-sym))
        (extend-env (bvar bval saved-env)
	  (if (eqv? search-sym bvar)
	    bval
	    (apply-env saved-env search-sym)))
        (extend-env-rec
         (p-names b-vars-list p-bodies saved-env)
         (let loop ([p-names p-names]
                    [b-vars-list b-vars-list]
                    [p-bodies p-bodies])
           (cond
            [(null? p-names) (apply-env saved-env search-sym)]
            [(eqv? search-sym (car p-names))
             (proc-val
              (procedure
               (car b-vars-list) (car p-bodies) env))]
            [else (loop (cdr p-names)
                        (cdr b-vars-list)
                        (cdr p-bodies))]))))))
    
  )
