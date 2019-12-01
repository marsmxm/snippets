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

    )
  
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
	(id thunk quantum)
	(let ([ticks (if (and quantum
			      (not (zero? quantum)))
			 quantum
			 the-max-time-slice)])
	  (set! the-ready-queue
		(enqueue the-ready-queue (a-thread id thunk ticks))))))))

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
	     (id thunk quantum)
             (set! the-ready-queue other-ready-threads)            
             (set! the-time-remaining quantum) 
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
