 ;; 01 - Continuation and Coroutines
;; make-coroutine: (resume -> (value -> z)) -> (value -> z)
;; f: resume -> (value -> z)

;; (make-coroutine
;;  (lambda (resume)
;;    (lambda (init) ...)))

(define make-coroutine1
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

(define c1
  (make-coroutine1
   (lambda (resume)
     (lambda (init)
       ))))

(define make-coroutine2
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
	   (f resume
	      (resume maker
		      (lambda (v) (LCS v))))
	   (error 'resume  "coroutine-fell-off-end" #f)))))))

