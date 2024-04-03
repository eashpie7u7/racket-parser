#lang racket

(require parser-tools/lex)

(define basic-printing-lexer
  (lexer [(repetition 1 +inf.0 (char-range #\a #\z))
          ; =>
          (begin
            (display "found an id: ")
            (display lexeme)
            (newline))]
         [(union #\space #\newline)
          ; =>
          (void)]))

(define (run-basic-printing-lexer port)
  (when (not (eq? 'eof (basic-printing-lexer port)))
    (run-basic-printing-lexer port)))

(run-basic-printing-lexer (open-input-string "foo    bar baz"))
