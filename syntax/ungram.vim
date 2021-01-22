" vim: ts=8
" Vim syntax file
" Language:     Ungrammar

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

"syn keyword ungramKeyword grammar lexer parser tree header members options fragment returns throws scope init

syn match ungramCharacter '\\\(r\|n\|t\|f\|b\|"\|\'\|\\\|u\x\{4}\)' contained display
syn match ungramToken "\<[A-Z_][a-zA-Z_0-9]\+\>"
syn match ungramRule "[a-z][a-zA-Z_0-9]\+"
syn match ungramScopeVariable '$\k\+::\k\+'

syn match ungramOperator "[:;@.]"
syn match ungramOperator "[()]"
syn match ungramOperator "[?+*~|!]"
syn match ungramOperator "[->=^]"

syn match ungramBrace "[{}]"
syn match ungramBrace "[\[\]]"
syn region ungramAction matchgroup=ungramBrace start="[{\[]" end="[}\]]" contains=ungramVariable,ungramLiteral,ungramComment
syn match ungramVariable contained "$[a-zA-Z][a-zA-Z_0-9]*"

syn region ungramLiteral start=+'+ end=+'+ contains=ungramCharacter
syn region ungramLiteral start=+"+ end=+"+ contains=ungramCharacter

"syn region ungramComment start="/\*" end="\*/"
syn match  ungramComment "///.*$"

hi link ungramLiteral           String
hi def link ungramVariable      term=bold cterm=bold gui=bold
hi link ungramBrace             Operator
hi link ungramCharacter         Special
hi link ungramComment           Comment
hi link ungramOperator          Operator
hi link ungramKeyword           Keyword
hi link ungramToken             PreProc
hi link ungramScopeVariable     Identifier
hi link ungramRule              Type

let b:current_syntax = "ungram"
