#lang racket

(require "lexer.rkt")

(require parser-tools/yacc)
(define (increment x) (+ x 1))
(define (decrement x) (- x 1))

(define error-handler
  (lambda (tok-ok? tok-name tok-value start-pos end-pos)
    (printf "\n\n\nError: Invalid token detected: ~a, Value: ~a\n\n\n\n" tok-name tok-value)
    ;(printf "Start position: ~a, End position: ~a\n" start-pos end-pos)
    ))
(define the-parser
  (parser [start c-program]
          [end EOF]
          [src-pos]
          [error error-handler]
          [tokens
           literal-tokens
           identifier-tokens
           keyword-tokens
           type-tokens
           expression-operator-tokens
           term-operator-tokens
           punctuation-tokens]
          [grammar 
           [c-program [(main-function) $1]]
           
           [main-function [(INT IDENTIFIER LEFT_PAREN RIGHT_PAREN block)
                          (if (equal? $2 "main")
                              (list 'main-function $5)
                              (error "Expected 'main' function"))]]
           
           [block [(LEFT_BRACE statements RIGHT_BRACE) $2]]
           
           [statements [(statement statements) (cons $1 $2)]
                       [() '()]]
           
           [statement [(declaration SEMICOLON) $1]
                      [(expr SEMICOLON) $1]]
           
           [declaration [(type-token IDENTIFIER) (list 'declare $1 $2)]
                       [(type-token IDENTIFIER ASSIGNMENT expr) (list 'declare-init $1 $2 $4)]]
           
           [type-token [(INT) 'int]
                       [(CHAR) 'char]
                       [(FLOAT) 'float]
                       [(DOUBLE) 'double]
                       [(VOID) 'void]]
           
           [expr [(IDENTIFIER ASSIGNMENT expr) (list 'assign $1 $3)]
                 [(NUMBER PLUS NUMBER) (+ $1 $3)]
                 [(NUMBER MINUS NUMBER) (- $1 $3)]
                 [(NUMBER MULTIPLY NUMBER) (* $1 $3)]
                 [(NUMBER DIVIDE NUMBER) (/ $1 $3)]
                 [(NUMBER INCREMENT) (increment $1)]
                 [(NUMBER DECREMENT) (decrement $1)]
                 [(IDENTIFIER) $1]
                 [(NUMBER) $1]
                 [(LEFT_PAREN expr RIGHT_PAREN) $2]]
           ]))




(define src-code (open-input-file "test.c"))
(port-count-lines! src-code) ;enable lines and cols nums

(define result (the-parser (λ () (lex src-code))))

(display result)