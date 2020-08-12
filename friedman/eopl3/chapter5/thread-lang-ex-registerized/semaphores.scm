(module semaphores (lib "eopl.ss" "eopl")

  (require "drscheme-init.scm")
  (require "store.scm")                    ; for store ops
  (require "data-structures.scm")          ; for lock, a-lock
  (require "scheduler.scm")                ; for os calls
  (require "queues.scm")

  (provide (all-defined-out))

  ;; implements binary semaphores (mutexes).

  (define instrument-mutexes (make-parameter #f))

  ;; new-mutex () -> Mutex
  ;; Page: 188
  (define new-mutex
    (lambda ()
      (a-mutex
        (newref #f)                     
        (newref '()))))                 

  ; wait queue, initially empty

  ;; wait-for-mutex : Mutex * Thread -> FinalAnswer
  ;; waits for mutex to be open, then closes it.
  ;; Page: 190
  (define wait-for-mutex
    (lambda (m th)
      (cases mutex m
        (a-mutex (ref-to-closed? ref-to-wait-queue)
          (cond
            ((deref ref-to-closed?)                  
             (setref! ref-to-wait-queue
		      (enqueue (deref ref-to-wait-queue)
			       (list th the-time-remaining)))
             (run-next-thread))
            (else
             (setref! ref-to-closed? #t)
             (th)))))))

  ;; signal-mutex : Mutex * Thread -> FinalAnswer
  ;; Page 190
  (define signal-mutex
    (lambda (m th)
      (cases mutex m
        (a-mutex (ref-to-closed? ref-to-wait-queue)
          (let ((closed? (deref ref-to-closed?))
                (wait-queue (deref ref-to-wait-queue)))
            (when closed?
              (if (empty? wait-queue)
                (setref! ref-to-closed? #f)
                (dequeue
		 wait-queue
		 (lambda (first-waiting other-waitings)
		   (let ([th (car first-waiting)]
			 [ticks (cadr first-waiting)]
			 [tid (increase-get-thread-id)])
                     (place-on-ready-queue! (a-thread tid th ticks
                                                      exp env cont
                                                      val proc1 unop1))
                     (setref!
                      ref-to-wait-queue
                      other-waitings))))))
            (th))))))

  (define new-cond-var
    (lambda ()
      (a-cond-var
       (newref '()))))

  (define wait-for-cond
    (lambda (cond-var mutex th)
      (cases
       cond-variable cond-var
       (a-cond-var
	(ref-to-wait-queue)
	(signal-mutex
	 mutex
	 (lambda ()
	   (enqueue (deref ref-to-wait-queue)
		    (list th the-time-remaining mutex))))))))

  (define signal-cond
    (lambda (cond-var th)
      (cases
       cond-variable cond-var
       (a-cond-var
	(ref-to-wait-queue)
	(let ([wait-queue (deref ref-to-wait-queue)])
	  (when (not (empty? wait-queue))
	    (dequeue
	     wait-queue
	     (lambda (first-waiting other-waitings)
	       (let ([th (car first-waiting)]
		     [ticks (cadr first-waiting)]
		     [mutex (caddr first-waiting)])
		 (wait-for-mutex
		  mutex
		  (lambda ()
		    (place-on-ready-queue!
		     (a-thread (increase-get-thread-id) th ticks exp env cont val proc1 unop1))))))))
	  (th))))))

  )
