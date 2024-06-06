#lang racket
(require parser-tools/lex)
(require (prefix-in : parser-tools/lex-sre))

(define-tokens literal-tokens (NUMBER STRING))
(define-tokens identifier-tokens (IDENTIFIER))

(define-empty-tokens keyword-tokens (IF ELSE FOR WHILE DO SWITCH CASE DEFAULT BREAK CONTINUE RETURN))
(define-empty-tokens type-tokens (INT CHAR FLOAT DOUBLE VOID))

(define-empty-tokens expression-operator-tokens (PLUS MINUS INCREMENT DECREMENT))
(define-empty-tokens term-operator-tokens
                     (MULTIPLY DIVIDE
                               ASSIGNMENT
                               EQUAL
                               NOT_EQUAL
                               LESS_THAN
                               GREATER_THAN
                               LESS_THAN_OR_EQUAL
                               GREATER_THAN_OR_EQUAL
                               AND
                               OR))

(define-empty-tokens
 punctuation-tokens
 (SEMICOLON COMMA DOT LEFT_BRACE RIGHT_BRACE LEFT_BRACKET RIGHT_BRACKET LEFT_PAREN RIGHT_PAREN EOF))

(define lex
  (lexer-src-pos
   ;COMMENTS
   [(:seq "/*" (:* (:~ #\*)) "*/") (return-without-pos (lex input-port))]
   ;WHITESPACE
   [whitespace (return-without-pos (lex input-port))]
   ;KEYWORDS
   ["if" (token-IF)]
   ["else" (token-ELSE)]
   ["for" (token-FOR)]
   ["while" (token-WHILE)]
   ["do" (token-DO)]
   ["switch" (token-SWITCH)]
   ["case" (token-CASE)]
   ["default" (token-DEFAULT)]
   ["break" (token-BREAK)]
   ["continue" (token-CONTINUE)]
   ["return" (token-RETURN)]
   ;TYPES
   ["int" (token-INT)]
   ["char" (token-CHAR)]
   ["float" (token-FLOAT)]
   ["double" (token-DOUBLE)]
   ["void" (token-VOID)]
   ;OPERATORS
   ["+" (token-PLUS)]
   ["-" (token-MINUS)]
   ["++" (token-INCREMENT)]
   ["--" (token-DECREMENT)]
   ["*" (token-MULTIPLY)]
   ["/" (token-DIVIDE)]
   ["=" (token-ASSIGNMENT)]
   ["==" (token-EQUAL)]
   ["!=" (token-NOT_EQUAL)]
   ["<" (token-LESS_THAN)]
   [">" (token-GREATER_THAN)]
   ["<=" (token-LESS_THAN_OR_EQUAL)]
   [">=" (token-GREATER_THAN_OR_EQUAL)]
   ["&&" (token-AND)]
   ["||" (token-OR)]
   ;PUNCTUATION
   [";" (token-SEMICOLON)]
   ["(" (token-LEFT_PAREN)]
   [")" (token-RIGHT_PAREN)]
   ["[" (token-LEFT_BRACKET)]
   ["]" (token-RIGHT_BRACKET)]
   ["{" (token-LEFT_BRACE)]
   ["}" (token-RIGHT_BRACE)]
   ["." (token-DOT)]
   ["," (token-COMMA)]
   ;STRING LITERAL
   [(:seq #\" (:* (:~ #\")) #\") (token-STRING lexeme)]
   ;NUMBER LITERAL
   [(:seq (:+ numeric) (:? (:seq #\. (:* numeric)))) (token-NUMBER (string->number lexeme))]
   ;IDENTIFIERS
   [(:seq (:or alphabetic #\_) (:* (union alphabetic numeric #\_))) (token-IDENTIFIER lexeme)]
   ;EOF
   [(eof) (token-EOF)]))

(define src-code (open-input-file "src/test.c"))
; (port-count-lines! src-code) ;enable lines and cols nums

;exports
(provide literal-tokens)
(provide identifier-tokens)
(provide keyword-tokens)
(provide type-tokens)
(provide expression-operator-tokens)
(provide term-operator-tokens)
(provide punctuation-tokens)
(provide lex)

;print tokens

(define sample-input "void main(){}")

(define (get-tokens a-lexer)
  (define p (open-input-string sample-input))
  (list (a-lexer p) (a-lexer p) (a-lexer p) (a-lexer p) (a-lexer p)))

(get-tokens lex)
