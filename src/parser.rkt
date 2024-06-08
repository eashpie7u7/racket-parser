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
                      [(expr SEMICOLON) $1]
                      [(if-statement) $1]
                      [(for-statement) $1]
                      [(while-statement) $1]
                      [(do-while-statement) $1]
                      [(switch-statement) $1]
                      [(return-statement) $1]
                      [(continue-statement) $1]
                      [(function-call SEMICOLON) $1]]
           
           [if-statement [(IF LEFT_PAREN expr RIGHT_PAREN block) 
                         (list 'if $3 $5)]
                        [(IF LEFT_PAREN expr RIGHT_PAREN block ELSE block) 
                         (list 'if-else $3 $5 $7)]
                        [(IF LEFT_PAREN expr RIGHT_PAREN statement) 
                         (list 'if $3 $5)]
                        [(IF LEFT_PAREN expr RIGHT_PAREN statement ELSE statement) 
                         (list 'if-else $3 $5 $7)]]
           
           [for-statement [(FOR LEFT_PAREN for-init SEMICOLON for-cond SEMICOLON for-incr RIGHT_PAREN block)
                         (list 'for $3 $5 $7 $9)]
                        [(FOR LEFT_PAREN for-init SEMICOLON for-cond SEMICOLON for-incr RIGHT_PAREN statement)
                         (list 'for $3 $5 $7 $9)]]
           
           [while-statement [(WHILE LEFT_PAREN expr RIGHT_PAREN block)
                             (list 'while $3 $5)]
                            [(WHILE LEFT_PAREN expr RIGHT_PAREN statement)
                             (list 'while $3 $5)]]

           [do-while-statement [(DO block WHILE LEFT_PAREN expr RIGHT_PAREN SEMICOLON)
                                (list 'do-while $2 $5)]
                               [(DO statement WHILE LEFT_PAREN expr RIGHT_PAREN SEMICOLON)
                                (list 'do-while $2 $5)]]

           [switch-statement [(SWITCH LEFT_PAREN expr RIGHT_PAREN switch-block) 
                              (list 'switch $3 $5)]]

           [switch-block [(LEFT_BRACE case-statements RIGHT_BRACE) $2]]

           [case-statements [(case-statement case-statements) (cons $1 $2)]
                            [(default-statement case-statements) (cons $1 $2)]
                            [() '()]]

           [case-statement [(CASE expr COLON statements break-statement) 
                            (list 'case $2 $4 $5)]]

           [default-statement [(DEFAULT COLON statements break-statement) 
                              (list 'default $3 $4)]
                             [(DEFAULT COLON statements) 
                              (list 'default $3)]]

           [break-statement [(BREAK SEMICOLON) 'break]]
           
           [return-statement [(RETURN expr SEMICOLON) 
                             (list 'return $2)]
                            [(RETURN SEMICOLON)
                             'return]]
           
           [continue-statement [(CONTINUE SEMICOLON) 'continue]]

           [for-init [(declaration) $1]
                     [(expr) $1]
                     [() #f]]
           
           [for-cond [(expr) $1]
                     [() #t]]
           
           [for-incr [(expr) $1]
                     [() #f]]
           
           [function-call [(IDENTIFIER LEFT_PAREN args RIGHT_PAREN) (list 'call $1 $3)]]
           
           [args [(expr) (list $1)]
                 [() '()]]
           
           [declaration [(type-token IDENTIFIER) (list 'declare $1 $2)]
                       [(type-token IDENTIFIER ASSIGNMENT expr) (list 'declare-init $1 $2 $4)]]
           
           [type-token [(INT) 'int]
                       [(CHAR) 'char]
                       [(FLOAT) 'float]
                       [(DOUBLE) 'double]
                       [(VOID) 'void]]
           
           [expr [(IDENTIFIER ASSIGNMENT expr) (list 'assign $1 $3)]
                 [(expr PLUS expr) (list '+ $1 $3)]
                 [(expr MINUS expr) (list '- $1 $3)]
                 [(expr MULTIPLY expr) (list '* $1 $3)]
                 [(expr DIVIDE expr) (list '/ $1 $3)]
                 [(expr EQUAL expr) (list '== $1 $3)]
                 [(expr NOT_EQUAL expr) (list '!= $1 $3)]
                 [(expr LESS_THAN expr) (list '< $1 $3)]
                 [(expr GREATER_THAN expr) (list '> $1 $3)]
                 [(expr LESS_THAN_OR_EQUAL expr) (list '<= $1 $3)]
                 [(expr GREATER_THAN_OR_EQUAL expr) (list '>= $1 $3)]
                 [(expr AND expr) (list '&& $1 $3)]
                 [(expr OR expr) (list '|| $1 $3)]
                 [(expr INCREMENT) (increment $1)]
                 [(expr DECREMENT) (decrement $1)]
                 [(IDENTIFIER) $1]
                 [(NUMBER) $1]
                 [(LEFT_PAREN expr RIGHT_PAREN) $2]
                 [(STRING) $1]]

           [term [(IDENTIFIER) $1]
                 [(NUMBER) $1]
                 [(STRING) $1]
                 [(LEFT_PAREN expr RIGHT_PAREN) $2]
                 [(expr INCREMENT) (increment $1)]
                 [(expr DECREMENT) (decrement $1)]]
           ]))