(module data-structures (lib "eopl.ss" "eopl")

  ;; data structures for LEXADDR language

  (require "lang.scm")                  ; for expression?

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
     (list listval?)))

  (define-datatype listval listval?
    (empty-list)
    (non-empty-list
     (head expval?)
     (tail expval?)))

  (define empty-list?
    (lambda (lst)
      (cases
       listval lst
       (empty-list () #t)
       (else #f))))

;;; extractors:

  ;; expval->num : ExpVal -> Int
  (define expval->num
    (lambda (v)
      (cases expval v
	(num-val (num) num)
	(else (expval-extractor-error 'num v)))))

  ;; expval->bool : ExpVal -> Bool
  (define expval->bool
    (lambda (v)
      (cases expval v
	(bool-val (bool) bool)
	(else (expval-extractor-error 'bool v)))))

  ;; expval->proc : ExpVal -> Proc
  (define expval->proc
    (lambda (v)
      (cases expval v
	(proc-val (proc) proc)
	(else (expval-extractor-error 'proc v)))))

  (define expval->list
    (lambda (v)
      (cases expval v
	     (list-val (list) list)
	     (else (expval-extractor-error 'list v)))))

  (define expval-extractor-error
    (lambda (variant value)
      (eopl:error 'expval-extractors "Looking for a ~s, found ~s"
	variant value)))

;;;;;;;;;;;;;;;; procedures ;;;;;;;;;;;;;;;;


  ;; proc? : SchemeVal -> Bool
  ;; procedure : Exp * Nameless-env -> Proc
  (define-datatype proc proc?
    (procedure
      ;; in LEXADDR, bound variables are replaced by %nameless-vars, so
      ;; there is no need to declare bound variables.
      ;; (bvar symbol?)
      (body expression?)
      ;; and the closure contains a nameless environment
      (env nameless-environment?)))

;;;;;;;;;;;;;;;; environment constructors and observers ;;;;;;;;;;;;;;;;

  ;; nameless-environment? : SchemeVal -> Bool
  ;; Page: 99
  (define nameless-environment?
    (lambda (x)
      (let ([vals-or-vec (lambda (e)
			  (or ((list-of expval?) e)
			      (vector? e)))])
	((list-of vals-or-vec) x))))

  ;; empty-nameless-env : () -> Nameless-env
  ;; Page: 99
  (define empty-nameless-env
    (lambda ()
      '()))

  ;; empty-nameless-env? : Nameless-env -> Bool
  (define empty-nameless-env? 
    (lambda (x)
      (null? x)))

  ;; extend-nameless-env : ExpVal * Nameless-env -> Nameless-env
  ;; Page: 99
  (define extend-nameless-env
    (lambda (vals nameless-env)
      (cons vals nameless-env)))

  (define extend-nameless-env-rec
    (lambda (bodies saved-env)
      (let ((vec (make-vector (length bodies))))
	(let ((new-env (extend-nameless-env vec saved-env)))
	  (let loop ([bodies bodies]
		     [index 0])
	    (if (null? bodies)
		new-env
		(begin
		  (vector-set! vec index
			       (proc-val
				(procedure (car bodies)
					   new-env)))
		  (loop (cdr bodies)
                        (+ index 1)))))))))

   ;; apply-nameless-env : Nameless-env * Lexaddr -> ExpVal
   ;; Page: 99
   (define apply-nameless-env
     (lambda (nameless-env index sub-index)
       (list-ref
	(list-ref nameless-env index)
	sub-index)))

   (define apply-nameless-env-rec
     (lambda (nameless-env index sub-index)
       (let ([vec (list-ref nameless-env index)])
	  (vector-ref vec sub-index))))

)
