(module lang (lib "eopl.ss" "eopl") 

  ;; grammar for the CHECKED language
  
  (require "drscheme-init.scm")
  
  (provide (all-defined-out))

  ;;;;;;;;;;;;;;;; grammatical specification ;;;;;;;;;;;;;;;;
  
  (define the-lexical-spec
    '((whitespace (whitespace) skip)
      (comment ("%" (arbno (not #\newline))) skip)
      (identifier
       (letter (arbno (or letter digit "_" "-" "?")))
       symbol)
      (number (digit (arbno digit)) number)
      (number ("-" digit (arbno digit)) number)
      ))
  
  (define the-grammar
    '((program (expression) a-program)

      (expression (number) const-exp)
      (expression
        ("-" "(" expression "," expression ")")
        diff-exp)
      
      (expression
       ("zero?" "(" expression ")")
       zero?-exp)

      (expression
       ("if" expression "then" expression "else" expression)
       if-exp)

      (expression (identifier) var-exp)

      ;; Exercise 7.5
      (expression
       ("let" (arbno identifier "=" expression) "in" expression)
       let-exp)

      ;; Exercise 7.8 - unpair
      (expression
       ("letp" "(" identifier "," identifier ")" "=" expression "in" expression)
       unpair-exp)

      (expression
       ("proc" "(" (arbno identifier ":" type) ")" expression)
       proc-exp)

      (expression
       ("(" expression (arbno expression) ")")
       call-exp)

      (expression
        ("letrec"
         (arbno type identifier "(" (arbno identifier ":" type) ")" "=" expression)
         "in" expression)
        letrec-exp)

      (expression
       ("pair" "(" expression "," expression ")")
       pair-exp)

      (type
       ("int")
       int-type)
      
      (type
       ("bool")
       bool-type)

      (type
       ("(#" type "*" type ")")
       pair-type)
      
      (type
       ("(" (arbno type) "->" type ")")
       proc-type)
      
      ))

  ;;;;;;;;;;;;;;;; sllgen boilerplate ;;;;;;;;;;;;;;;;
  
  (sllgen:make-define-datatypes the-lexical-spec the-grammar)
  
  (define show-the-datatypes
    (lambda () (sllgen:list-define-datatypes the-lexical-spec the-grammar)))
  
  (define scan&parse
    (sllgen:make-string-parser the-lexical-spec the-grammar))
  
  (define just-scan
    (sllgen:make-string-scanner the-lexical-spec the-grammar))
  
;;;;;;;;;;;;;;;; type-to-external-form ;;;;;;;;;;;;;;;;

  ;; type-to-external-form : Type -> List
  ;; Page: 243
  (define type-to-external-form
    (lambda (ty)
      (cases type ty
        (int-type () 'int)
        (bool-type () 'bool)
        (pair-type
         (ty1 ty2)
         
         (list
          (type-to-external-form ty1)
          '*
          (type-to-external-form ty2)))
        (proc-type
         (arg-types result-type)
         (let ([arg-external-types
                (map (lambda (arg-type)
                       (type-to-external-form arg-type))
                     arg-types)])
           (append
            arg-external-types
            (list '-> (type-to-external-form result-type))))))))
  

  )
