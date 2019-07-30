(module environments (lib "eopl.ss" "eopl") 
  
  ;; builds environment interface, using data structures defined in
  ;; data-structures.scm. 

  (require "data-structures.scm")

  (provide init-env empty-env extend-env extend-env-rec apply-env)

;;;;;;;;;;;;;;;; initial environment ;;;;;;;;;;;;;;;;
  
  ;; init-env : () -> Env
  ;; usage: (init-env) = [i=1, v=5, x=10]
  ;; (init-env) builds an environment in which i is bound to the
  ;; expressed value 1, v is bound to the expressed value 5, and x is
  ;; bound to the expressed value 10.
  ;; Page: 69

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

  ;; Page: 86
  (define apply-env
    (lambda (env search-sym)
      (cases environment env
        (empty-env ()
          (eopl:error 'apply-env "No binding for ~s" search-sym))
        (extend-env (var val saved-env)
		    (if (vector? val)
			(let ([vec val]) ; env of rec
			  (let loop ([names var]
				     [index 0])
			    (if (null? names)
				(apply-env saved-env search-sym)
				(if (eqv? search-sym (car names))
				    (vector-ref vec index)
				    (loop (cdr names) (+ index 1))))))
			(if (eqv? search-sym var) ; normal env
			    val
			    (apply-env saved-env search-sym)))))))

  (define extend-env-rec
    (lambda (p-names b-vars-list bodies saved-env)
      (let ((vec (make-vector (length p-names))))
	(let ((new-env (extend-env p-names vec saved-env)))
	  (let loop ([vars-list b-vars-list]
		     [bodies bodies]
		     [index 0])
	    (if (null? vars-list)
		new-env
		(begin
		  (vector-set! vec index
			       (proc-val
				(procedure (car vars-list)
					   (car bodies)
					   new-env)))
		  (loop (cdr vars-list) (cdr bodies) (+ index 1)))))))))

    
  )
