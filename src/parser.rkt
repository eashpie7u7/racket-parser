#lang racket

(require "lexer.rkt")

(require parser-tools/yacc)

(define error-handler
  (lambda (tok-ok? tok-name tok-value start-pos end-pos)
    (printf "\n\n\nError: Invalid token detected: ~a, Value: ~a\n\n\n\n" tok-name tok-value)
    ;(printf "Start position: ~a, End position: ~a\n" start-pos end-pos)
    ))

(define the-parser
  (parser [start expr]
          [end EOF]
          [src-pos]
          [error error-handler]
          [tokens
           literal-tokens
           identifier-tokens
           keyword-tokens
           expression-operator-tokens
           term-operator-tokens
           punctuation-tokens]
          [grammar [expr [(NUMBER PLUS NUMBER) (+ $1 $3)]]]))

(define src-code (open-input-file "src/test.js"))
(port-count-lines! src-code) ;enable lines and cols nums

(define result (the-parser (λ () (lex src-code))))

(display result)
