(module data-structures (lib "eopl.ss" "eopl")

  (require "lang.scm")                  ; for expression?
  (require "store.scm")
  
  (provide (all-defined-out))               ; too many things to list

;;;;;;;;;;;;;;;; expressed values ;;;;;;;;;;;;;;;;

;;; an expressed value is either a number, a boolean or a procval.

  (define-datatype expval expval?
    (num-val
     (value number?))
    (bool-val
     (boolean boolean?))
    (proc-val 
     (proc proc?))
    (list-val
     (a-list listval?)))

  (define-datatype
    listval listval?
    (emptylist)
    (conslist
     (head expval?)
     (tail listval?)))

;;; extractors:

  (define expval->num
    (lambda (v)
      (cases expval v
	(num-val (num) num)
	(else (expval-extractor-error 'num v)))))

  (define expval->bool
    (lambda (v)
      (cases expval v
	(bool-val (bool) bool)
	(else (expval-extractor-error 'bool v)))))

  (define expval->proc
    (lambda (v)
      (cases expval v
	(proc-val (proc) proc)
	(else (expval-extractor-error 'proc v)))))

  (define expval->list
    (lambda (v)
      (cases
       expval v
       (list-val (a-list) a-list)
       (else (expval-extractor-error 'list v)))))

  (define expval-extractor-error
    (lambda (variant value)
      (eopl:error 'expval-extractors "Looking for a ~s, found ~s"
	variant value)))

;;;;;;;;;;;;;;;; continuations ;;;;;;;;;;;;;;;;

  ;; Page: 148
  (define identifier? symbol?)

  (define-datatype continuation continuation?
    (end-cont)                 
    (zero1-cont
     (saved-cont continuation?))
    (let-exp-cont
     (var identifier?)
     (vars-left (list-of identifier?))
     (exps-left (list-of expression?))
     (body expression?)
     (saved-env environment?)
     (saved-cont continuation?))
    (if-test-cont 
      (exp2 expression?)
      (exp3 expression?)
      (saved-env environment?)
      (saved-cont continuation?))
    (binop1-cont                
     (exp2 expression?)
     (op procedure?)
     (saved-env environment?)
     (saved-cont continuation?))
    (binop2-cont                
     (val1 expval?)
     (op procedure?)
     (saved-cont continuation?))
    (rator-cont            
     (rands (list-of expression?))
     (saved-env environment?)
     (saved-cont continuation?))
    (rand-cont             
     (proc proc?)
     (rest-rands (list-of expression?))
     (vals (list-of expval?))
     (saved-env environment?)
     (saved-cont continuation?))
    ;; for list
    (cons1-cont
     (exp2 expression?)
     (saved-env environment?)
     (saved-cont continuation?))
    (cons2-cont
     (val1 expval?)
     (saved-cont continuation?))
    (null1-cont
     (saved-cont continuation?))
    (car1-cont
     (saved-cont continuation?))
    (cdr1-cont
     (saved-cont continuation?))
    (list-first-cont
     (rest-exps (list-of expression?))
     (saved-env environment?)
     (saved-cont continuation?))
    (list-rest-cont
     (vals (list-of expval?))
     (rest-exps (list-of expression?))
     (saved-env environment?)
     (saved-cont continuation?))
    ;; for implicit-refs
    (set-rhs-cont
     (ref reference?)
     (saved-cont continuation?))
    (begin1-cont
     (exps (list-of expression?))
     (saved-env environment?)
     (saved-cont continuation?))
    )

;;;;;;;;;;;;;;;; procedures ;;;;;;;;;;;;;;;;

  (define-datatype proc proc?
    (procedure
     (bvars (list-of symbol?))
     (body expression?)
     (env environment?)))
  
;;;;;;;;;;;;;;;; environment structures ;;;;;;;;;;;;;;;;

  (define-datatype environment environment?
    (empty-env)
    (extend-env 
      (bvar symbol?)
      (bval reference?)
      (saved-env environment?))
    (extend-env-rec
      (p-name symbol?)
      (b-vars (list-of symbol?))
      (p-body expression?)
      (saved-env environment?)))

)
