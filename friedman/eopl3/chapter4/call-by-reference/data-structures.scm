(module data-structures (lib "eopl.ss" "eopl")

  ;; data structures for call-by-reference language

  (require "lang.scm")                  ; for expression?
  (require "store.scm")                 ; for reference?

  (require "pairvals.scm")
  (require "arrayvals.scm")

  (provide (all-defined-out))               ; too many things to list

;;;;;;;;;;;;;;;; expressed values ;;;;;;;;;;;;;;;;

;;; an expressed value is either a number, a boolean, a procval, a
;;; reference, or a mutable pair. 

  (define-datatype expval expval?
    (num-val
      (value number?))
    (bool-val
      (boolean boolean?))
    (proc-val 
      (proc proc?))
    (ref-val
      (ref reference?))
    (mutpair-val
     (p mutpair?))
    (array-val
     (arr array?))
    )

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

  (define expval->ref
    (lambda (v)
      (cases expval v
	(ref-val (ref) ref)
	(else (expval-extractor-error 'reference v)))))

  (define expval->mutpair
    (lambda (v)
      (cases expval v
	(mutpair-val (ref) ref)
	(else (expval-extractor-error 'mutable-pair v)))))

  (define expval->array
    (lambda (v)
      (cases expval v
             (array-val (ref) ref)
             (else (expval-extractor-error 'array v)))))

  (define expval-extractor-error
    (lambda (variant value)
      (eopl:error 'expval-extractors "Looking for a ~s, found ~s"
	variant value)))

;;;;;;;;;;;;;;;; procedures ;;;;;;;;;;;;;;;;

  (define-datatype proc proc?
    (procedure
     (bvars (list-of symbol?))
     (body expression?)
     (env environment?)
     (type number?)))
  
;;;;;;;;;;;;;;;; environment data structures ;;;;;;;;;;;;;;;;

  (define-datatype environment environment?
    (empty-env)
    (extend-env 
      (bvar symbol?)
      (bval reference?)                 
      (saved-env environment?))
    (extend-env-rec*
      (proc-names (list-of symbol?))
      (b-vars (list-of symbol?))
      (proc-bodies (list-of expression?))
      (saved-env environment?)))

  ;; env->list : Env -> List
  ;; used for pretty-printing and debugging
  (define env->list
    (lambda (env)
      (cases environment env
	(empty-env () '())
	(extend-env (sym val saved-env)
	  (cons
	    (list sym val)              ; val is a denoted value-- a
                                        ; reference. 
	    (env->list saved-env)))
	(extend-env-rec* (p-names b-vars p-bodies saved-env)
	  (cons
	    (list 'letrec p-names '...)
	    (env->list saved-env))))))

  ;; expval->printable : ExpVal -> List
  ;; returns a value like its argument, except procedures get cleaned
  ;; up with env->list 
  (define expval->printable
    (lambda (val)
      (cases expval val
	(proc-val (p)
	  (cases proc p
	    (procedure (var body saved-env type)
	      (list 'procedure var '... (env->list saved-env)))))
	(else val))))

)
