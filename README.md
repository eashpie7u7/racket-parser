



Palabras reservadas:

- `if`
- `else`
- `for`
- `while`
- `break`
- `continue`
- `return`
- `function`
- `var`
- `let`
- `const`
- `class`




Operadores:
- `+`
- `-`
- `*`
- `/`
- `=`
- `==`
- `!=`
- `<`
- `>`
- `<=`
- `>=`
- `&&`
- `||`



Puntuacion:
- `;`
- `(`
- `)`
- `[`
- `]`
- `{`
- `}`  


Literales:
- `1`   Números 
- `"Hola"` Cadenas de texto 
- `true` Booleanos 
- `null` Null 
- `undefined` Undefined 
- `{}` Objetos literales 
- `[]` Arreglos literales 



Comentarios:
- `//` 
- `/*  */`





Formal language :

`PROGRAM` ⟶ STATEMENT_LIST

`STATEMENT_LIST` ⟶ (STATEMENT)*

`STATEMENT` ⟶ (VAR_DECLARATION ";") | (ASSIGNMENT ";") | IF_STATEMENT | WHILE_LOOP | CLASS_DECLARATION | FUNCTION_DECLARATION | FOR_LOOP | (FUNCTION_CALL ";")

`FUNCTION_CALL` ⟶ IDENTIFIER "(" ((IDENTIFIER | LITERAL) ("," (IDENTIFIER | LITERAL)  )*)? ")"  

`VAR_DECLARATION` ⟶ ("let" | "const" | "var") IDENTIFIER ("=" EXPRESSION)? 

`FUNCTION_DECLARATION` ⟶ "function " IDENTIFIER "(" FUNCTION_ARGS* ")" "{" STATEMENT_LIST "}"


`FOR_LOOP` ⟶ "for " "("VAR_DECLARATION ";" CONDITION ";" EXPRESSION ")"

`CLASS_DECLARATION` ⟶ "class " IDENTIFIER OBJECT

`ASSIGNMENT` ⟶ IDENTIFIER "=" EXPRESSION 

`IF_STATEMENT` ⟶ "if" "("  CONDITION ")" "{" STATEMENT_LIST "}" ("else"(IF_STATEMENT | ("{" STATEMENT_LIST "}" )  ) )?

`WHILE_LOOP` ⟶ "while" "(" CONDITION ")" "{" STATEMENT_LIST "}"

`CONDITION` ⟶ EXPRESSION CONDITIONAL_SYMBOL EXPRESSION

`CONDITIONAL_SYMBOL` ⟶ "==" | "!=" | "<" | ">" | "<=" | ">="

`EXPRESSION` ⟶ TERM | FUNCTION_CALL | ARRAY_ACCESS |( ("+" | "-") TERM )*

`TERM` ⟶ FACTOR | (TERM_OPERATORS FACTOR)

`TERM_OPERATORS` ⟶ "*" | "==" | "!=" | "<" | ">" | "<=" | ">=" | "&&" | "||"

`FACTOR` ⟶ IDENTIFIER | NUMBER | "(" EXPRESSION ")"

`IDENTIFIER` ⟶ (LETTER | "_") (LETTER | DIGIT)*

`LITERAL` ⟶ NUMBER | STRING | BOOL | "null" | "undefined" | OBJECT | ARRAY

`NUMBER` ⟶ (DIGIT* ".")? DIGIT+

`STRING` ⟶   (") [^"]* (")

`BOOL` ⟶ "true" | "false"

`OBJECT` ⟶ "{" (OBJECT_MEMBER ("," OBJECT_MEMBER)*)? "}"

`OBJECT_MEMBER` ⟶ OBJECT_ATTRIBUTE | OBJECT_METHOD

`OBJECT_ATTRIBUTE` ⟶ IDENTIFIER ":" LITERAL

`OBJECT_METHOD` ⟶ IDENTIFIER "(" FUNCTION_ARGS ")"

`FUNCTION_ARGS` ⟶ (IDENTIFIER ("," IDENTIFIER)*)?

`ARRAY` ⟶ "[" (LITERAL ("," LITERAL)*)? "]"

`ARRAY_ACCESS` ⟶ IDENTIFIER "[" EXPRESSION "]"

`LETTER` ⟶ "a" | ... | "z" | "A" | ... | "Z"

`DIGIT` ⟶ "0" | "1" | "2" | "3" | "4" | "5" | "6" | "7" | "8" | "9"


