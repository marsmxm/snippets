(define empty-env
  (lambda ()
    (lambda (search-var)
      (report-no-binding-found search-var))))

(define extend-env
  (lambda (saved-var saved-val saved-env)
    (lambda (search-var)
      (if (eqv? search-var saved-var)
	  saved-val
	  (apply-env saved-env search-var)))))

(define extend-env-rec
  (lambda (name var body saved-env)
    (lambda (search-var)
      (if (eqv? search-var name)
	  (proc-val
	   (procedure var body
		      (extend-env-rec name var body saved-env)))
	  (saved-env search-var)))))

(define apply-env
  (lambda (env search-var)
    (env search-var)))
