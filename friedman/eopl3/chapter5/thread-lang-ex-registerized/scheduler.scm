(module scheduler (lib "eopl.ss" "eopl")
  
  (require "drscheme-init.scm")
  (require "queues.scm")
  (require "data-structures.scm")       ; for continuation?
  (require "lang.scm")                  ; for expval?
  
  (provide
    initialize-scheduler!
    set-final-answer! 
    
    time-expired?
    decrement-timer!

    place-on-ready-queue!
    run-next-thread

    the-time-remaining

    exp env cont val proc1 unop1
    set-exp! set-env! set-cont! set-val! set-proc1! set-unop1!
    )

  ;; registers
  (define exp 'uninitialized)
  (define env 'uninitialized)
  (define cont 'uninitialized)
  (define val 'uninitialized)
  (define proc1 'uninitialized)
  (define unop1 'uninitialized)

  (define (set-exp! exp1) (set! exp exp1))
  (define (set-env! env1) (set! env env1))
  (define (set-cont! cont1) (set! cont cont1))
  (define (set-val! val1) (set! val val1))
  (define (set-proc1! p) (set! proc1 p))
  (define (set-unop1! u) (set! unop1 u))
  
  ;;;;;;;;;;;;;;;; the state ;;;;;;;;;;;;;;;;
  
  ;; components of the scheduler state:
  
  (define the-ready-queue   'uninitialized)         
  (define the-final-answer  'uninitialized)
  
  (define the-max-time-slice    'uninitialized)
  (define the-time-remaining    'uninitialized)

  ;; initialize-scheduler! : Int -> Unspecified
  (define initialize-scheduler!
    (lambda (ticks)
      (set! the-ready-queue (empty-queue))
      (set! the-final-answer 'uninitialized)
      (set! the-max-time-slice ticks)
      (set! the-time-remaining the-max-time-slice) 
      ))
  
  ;;;;;;;;;;;;;;;; the final answer ;;;;;;;;;;;;;;;;

  ;; place-on-ready-queue! : Thread -> Unspecified
  ;; Page: 184  
  (define place-on-ready-queue!
    (lambda (th)
      (cases
       thread th
       (a-thread
	(id thunk quantum sexp senv scont sval sproc1 sunop1)
	(let ([ticks (if (and quantum
			      (not (zero? quantum)))
			 quantum
			 the-max-time-slice)])
	  (set! the-ready-queue
		(enqueue the-ready-queue (a-thread id thunk ticks
                                                   sexp senv scont
                                                   sval sproc1
                                                   sunop1))))))))

  ;; run-next-thread : () -> FinalAnswer
  ;; Page: 184    
  (define run-next-thread
    (lambda ()
      (if (empty? the-ready-queue)
        the-final-answer
        (dequeue
	 the-ready-queue
	 (lambda (first-ready-thread other-ready-threads)
	   (cases
	    thread first-ready-thread
	    (a-thread
	     (id thunk quantum sexp senv scont sval sproc1 sunop1)
             (set! the-ready-queue other-ready-threads)            
             (set! the-time-remaining quantum)
             (set! exp sexp)
             (set! env senv)
             (set! cont scont)
             (set! val sval)
             (set! proc1 sproc1)
             (set! unop1 sunop1)
             (thunk))))))))

  ;; set-final-answer! : ExpVal -> Unspecified
  ;; Page: 184    
  (define set-final-answer!
    (lambda (val)
      (set! the-final-answer val)))

  ;; time-expired? : () -> Bool
  ;; Page: 184    
  (define time-expired?
    (lambda ()
      (zero? the-time-remaining)))

  ;; decrement-timer! : () -> Unspecified
  ;; Page: 184    
  (define decrement-timer!
    (lambda ()
      (set! the-time-remaining (- the-time-remaining 1))))

  )
