(module lang (lib "eopl.ss" "eopl")                
  
  ;; grammar for the LETREC language

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
       ("*" "(" expression "," expression ")")
       multiply-exp)
      
      (expression
       ("zero?" "(" expression ")")
       zero?-exp)

      (expression
       ("if" expression "then" expression "else" expression)
       if-exp)

      (expression (identifier) var-exp)

      (expression
       ("let" (separated-list identifier "=" expression ",") "in" expression)
       let-exp)

      (expression
       ("proc" "(" (separated-list identifier ",") ")" expression)
       proc-exp)

      (expression
       ("(" expression (arbno expression) ")")
       call-exp)

      (expression
        ("letrec"
         identifier "(" (separated-list identifier ",") ")" "=" expression
         "in" expression)
        letrec-exp)

      ;; for list
      (expression
       ("emptylist")
       emptylist-exp)

      (expression
       ("cons" "(" expression "," expression ")")
       cons-exp)

      (expression
       ("null?" "(" expression ")")
       null?-exp)

      (expression
       ("car" "(" expression ")")
       car-exp)

      (expression
       ("cdr" "(" expression ")")
       cdr-exp)

      (expression
       ("list" "(" (separated-list expression ",") ")")
       list-exp)

      (expression
       ("set" identifier "=" expression)
       set-exp)

      (expression
       ("begin" expression (arbno ";" expression) "end")
       begin-exp)
      ))

  ;;;;;;;;;;;;;;;; sllgen boilerplate ;;;;;;;;;;;;;;;;
  
  (sllgen:make-define-datatypes the-lexical-spec the-grammar)
  
  (define show-the-datatypes
    (lambda () (sllgen:list-define-datatypes the-lexical-spec the-grammar)))
  
  (define scan&parse
    (sllgen:make-string-parser the-lexical-spec the-grammar))
  
  (define just-scan
    (sllgen:make-string-scanner the-lexical-spec the-grammar))
  
  )
