# justfile 语法

Justfiles 由温和的上下文敏感的标记化器，和深度(往下)递归解析器，处理。语法主要是 LL(1), 尽管多了个额外的前瞻标记，它用于区分，导出任务和带参数配方的。

> 这里，中文会不太清晰，还是看[english](./GRAMMAR.md)吧

## 标记(token)

```toml
BACKTICK   = `[^`\n\r]*`
COMMENT    = #([^!].*)?$
DEDENT     = emitted when indentation decreases
EOF        = emitted at the end of the file
INDENT     = emitted when indentation increases
LINE       = emitted before a recipe line
NAME       = [a-zA-Z_][a-zA-Z0-9_-]*
NEWLINE    = \n|\r\n
RAW_STRING = '[^'\r\n]*'
STRING     = "[^"]*" # also processes \n \r \t \" \\ escapes
TEXT       = recipe text, only matches in a recipe body
```

## 语言句法（grammar syntax）

```
|   alternation
()  grouping
_?  option (0 or 1 times)
_*  repetition (0 or more times)
_+  repetition (1 or more times)
```

## 语法

```
justfile      : item* EOF

item          : recipe
              | assignment
              | export
              | eol

eol           : NEWLINE
              | COMMENT NEWLINE

assignment    : NAME '=' expression eol

export        : 'export' assignment

expression    : value '+' expression
              | value

value         : NAME '(' arguments? ')'
              | STRING
              | RAW_STRING
              | BACKTICK
              | NAME

arguments     : expression ',' arguments
              | expression ','?

recipe        : '@'? NAME parameter* ('+' parameter)? ':' dependencies? body?

parameter     : NAME
              | NAME '=' STRING
              | NAME '=' RAW_STRING

dependencies  : NAME+

body          : INDENT line+ DEDENT

line          : LINE (TEXT | interpolation)+ NEWLINE
              | NEWLINE

interpolation : '{{' expression '}}'
```
