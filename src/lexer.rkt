#lang racket

(require parser-tools/lex)
;(require parser-tools/lex-sre)
(require (prefix-in : parser-tools/lex-sre))

(define-tokens literal-tokens (NUMBER STRING NULL BOOLEAN))
(define-tokens identifier-tokens (IDENTIFIER))

(define-empty-tokens keyword-tokens
                     (IF ELSE FOR WHILE BREAK CONTINUE RETURN FUNCTION VAR LET CONST CLASS))

(define-empty-tokens expression-operator-tokens (PLUS MINUS))

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
  ;WHITESPACE
  (lexer [#\space (lex input-port)]
         [#\newline (lex input-port)]
         ;COMMENTS
         [(:seq "//" (:* (:~ #\newline)) #\newline) (lex input-port)]
         ;KEYWORDS
         ["if" (token-IF)]
         ["else" (token-ELSE)]
         ["for" (token-FOR)]
         ["while" (token-WHILE)]
         ["break" (token-BREAK)]
         ["continue" (token-CONTINUE)]
         ["return" (token-RETURN)]
         ["function" (token-FUNCTION)]
         ["var" (token-VAR)]
         ["let" (token-LET)]
         ["const" (token-CONST)]
         ["class" (token-CLASS)]
         ;OPERATORS
         ["+" (token-PLUS)]
         ["-" (token-MINUS)]
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
         ;NULL LITERAL
         ["null" (token-NULL lexeme)]
         ;TRUE LITERAL
         ["true" (token-BOOLEAN lexeme)]
         ;FALSE LITERAL
         ["false" (token-BOOLEAN lexeme)]
         ;IDENTIFIERS
         [(:seq (:or alphabetic #\_) (:* (union alphabetic numeric #\_))) (token-IDENTIFIER lexeme)]
         ;EOF
         [(eof) (token-EOF)]
         ;any
         [any-char (lex input-port)]))

(define (tokenize input)
  (let loop ([tokens '()])
    (let ([next-token (lex input)])
      (if (eq? next-token `EOF)
          (reverse (cons (list 'eof "eof") tokens))
          (loop (cons next-token tokens))))))

(define (tokenize-file path)
  (tokenize (open-input-file path)))

(tokenize-file "src/test.js")

;exports
(provide tokenize-file)

(provide literal-tokens)
(provide identifier-tokens)
(provide keyword-tokens)
(provide expression-operator-tokens)
(provide term-operator-tokens)
(provide punctuation-tokens)
(provide lex)
