;; 01 - Continuation and Coroutines
(define make-coroutine
  (lambda (f)
    (call/cc
     (lambda (maker)
       (let ([LCS '*])
	 (let ([resume
		(lambda (dest val)
		  (call/cc
		   (lambda (self)
		     (set! LCS self)
		     (dest val))))])
	   (let ([receiver (f resume)])
	     (receiver
	      (call/cc
	       (lambda (initk)
		 (set! LCS initk)
		 (maker
		  (lambda (v) (LCS v)))))))))))))

(make-coroutine
 (lambda (resume)
   (lambda (init) Body)))
