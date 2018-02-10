(library (assembler)
  (export assemble)
  (import)

  (define (assemble controller-text machine)
    (extract-labels controller-text
                    (lambda (insts labels)
                      (update-insts! insts labels machine)
                      insts)))

  (define (extract-labels text receive)
    (if (null? text)
        (receive '() '())
        (extract-labels (cdr text)
                        (lambda (insts labels)
                          (let ((next-inst (car text)))
                            (if (symbol? next-inst)
                                (if (assq next-inst labels)
                                    (error 'extract-labesl "Duplicate labels" next-inst)
                                    (receive insts
                                             (cons (make-label-entry next-inst
                                                                     insts)
                                                   labels)))
                                (receive (cons (make-instruction next-inst)
                                               insts)
                                         labels)))))))

  (define (update-insts! insts labels machine)
    (let ((pc (get-register machine 'pc))
          (flag (get-register machine 'flag))
          (stack (machine 'stack))
          (ops (machine 'operations)))
      (for-each
       (lambda (inst)
         (set-instruction-execution-proc! 
          inst
          (make-execution-procedure
           (instruction-text inst) labels machine
           pc flag stack ops)))
       insts)))

  (define (make-instruction text)
    (cons text '()))
  (define (instruction-text inst)
    (car inst))
  (define (instruction-execution-proc inst)
    (cdr inst))
  (define (set-instruction-execution-proc! inst proc)
    (set-cdr! inst proc))

  (define (make-label-entry label-name insts)
    (cons label-name insts))

  (define (lookup-label labels label-name)
    (let ((val (assoc label-name labels)))
      (if val
          (cdr val)
          (error 'lookup-label "Undefined label -- ASSEMBLE" label-name))))


  (define (make-execution-procedure inst labels machine
                                    pc flag stack ops)
    (cond ((eq? (car inst) 'assign)
           (make-assign inst machine labels ops pc))
          ((eq? (car inst) 'test)
           (make-test inst machine labels ops flag pc))
          ((eq? (car inst) 'branch)
           (make-branch inst machine labels flag pc))
          ((eq? (car inst) 'goto)
           (make-goto inst machine labels pc))
          ((eq? (car inst) 'save)
           (make-save inst machine stack pc))
          ((eq? (car inst) 'restore)
           (make-restore inst machine stack pc))
          ((eq? (car inst) 'perform)
           (make-perform inst machine labels ops pc))
          (else (error "Unknown instruction type -- ASSEMBLE"
                       inst))))
  )
