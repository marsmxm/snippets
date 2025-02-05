(module lang

  ;; grammar for the LET language

  (lib "eopl.ss" "eopl")                
  
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

      ;; Ex 3.6
      (expression
        ("minus" "(" expression ")")
        minus-exp)

      ;; Ex 3.7
      (expression
        ("+" "(" expression "," expression ")")
        add-exp)

      (expression
        ("*" "(" expression "," expression ")")
        mult-exp)

      (expression
        ("/" "(" expression "," expression ")")
        quotient-exp)
      
      (expression
        ("-" "(" expression "," expression ")")
        diff-exp)
      
      (expression
       ("zero?" "(" expression ")")
       zero?-exp)

      ;; Ex 3.8
      (expression
       ("equal?" "(" expression "," expression ")")
       equal?-exp)
      (expression
       ("greater?" "(" expression "," expression ")")
       greater?-exp)
      (expression
       ("lesser?" "(" expression "," expression ")")
       lesser?-exp)

      (expression
       ("if" expression "then" expression "else" expression)
       if-exp)

      (expression (identifier) var-exp)

      ;; (expression
      ;;  ("let" identifier "=" expression "in" expression)
      ;;  let-exp)
      ;; Ex 3.16, 3.17
      (expression
       ("let" (arbno identifier "=" expression) "in" expression)
       let-exp)
      (expression
       ("let*" (arbno identifier "=" expression) "in" expression)
       let*-exp)

      ;; Ex 3.9
      (expression
       ("emptylist")
       emptylist-exp)
      (expression
       ("cons" "(" expression "," expression ")")
       cons-exp)
      (expression
       ("car" "(" expression ")")
       car-exp)
      (expression
       ("cdr" "(" expression ")")
       cdr-exp)
      (expression
       ("null?" "(" expression ")")
       null?-exp)

      ;; Ex 3.10
      (expression
       ("list" "(" (separated-list expression ",") ")")
       list-exp)

      ;; Ex 3.12
      (expression
       ("cond" (arbno expression "==>" expression) "end")
       cond-exp)

      ;; Ex 3.15
      (expression
       ("print" "(" expression ")")
       print-exp)

      ;; Ex 3.18
      (expression
       ("unpack" (arbno identifier) "=" expression "in" expression)
       unpack-exp)

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
