(module
 arrayvals (lib "eopl.ss" "eopl")

 (require "store.scm")
 
 (provide (all-defined-out))


 (define array?
   (lambda (v) (procedure? v)))

 (define make-array
   (lambda (len init-val)
     (let ([ref -1])
       (let loop ([left len])
         (cond
          [(zero? left) (lambda (l)
                          (if (or (< l 0)
                                  (>= l len))
                              (eopl:error 'array-ref
                                          "index ~s out of range ~s"
                                          l len)
                              (list (+ ref l)
                                    len)))]
          [(eq? left len) (begin
                            (set! ref (newref init-val))
                            (loop (- left 1)))]
          [else (begin
                  (newref init-val)
                  (loop (- left 1)))])))))


 (define array-ref
   (lambda (arr index)
     (deref (car (arr index)))))

 (define array-ref-ref
   (lambda (arr index)
     (car (arr index))))

 (define array-set
   (lambda (arr index val)
     (setref! (car (arr index)) val)))

 (define array-length
   (lambda (arr)
     (cadr (arr 0))))

)

