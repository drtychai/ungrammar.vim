" vim: ts=8
" Vim syntax file 
" \Language:     Ungrammar
"   //          -- comment
"   Name =      -- non-terminal definition
"   'ident'     -- token (terminal)
"   A B         -- sequence
"   A | B       -- alternation
"   A*          -- zero or more repetition
"   A?          -- zero or one repetition
"   (A)         -- same as A
"   label:A     -- suggested name for field of AST node

if exists("b:current_syntax")
  finish
endif

"syn match ungramName /\<[A-Za-z][a-zA-Z_0-9]\+\>/ contained
"syn match ungramLabel /\<[a-z_0-9]\+\>/ contained

" Node definition 
syn match ungramNode /^\<[A-Za-z][a-zA-Z_0-9]\+\>/

" Rule definition
syn match ungramRule /.\<[A-Z][a-zA-Z_0-9]\+\>/
"skipwhite skipempty nextgroup=ungramEndRule
syn match ungramRuleAndLabel /:\<[A-Z][a-zA-Z_0-9]\+\>/
"skipwhite skipempty nextgroup=ungramEndRule
"syn match ungramEndRule /[\.\n]/ 

" Rule label
syn match ungramLabel /\<[a-z][a-zA-z_0-9]\+\>/ nextgroup=ungramLabelSeperator

" Node,Rule seperator
"syn match ungramSeperator /=/ contained nextgroup=ungramRuleLabel,ungramRule skipwhite skipempty
syn match ungramLabelSeperator /:/ nextgroup=ungramRuleAndLabel

" Misc
syn match ungramSpecial /[\-\*:]/ contained
syn region ungramSpecialSequence matchgroup=Delimiter start=/?/ end=/?/ contained

syn match ungramCharacter '\\\(r\|n\|t\|f\|b\|"\|\'\|\\\|u\x\{4}\)' contained display
syn region ungramLiteral start=+'+ end=+'+ contains=ungramCharacter

" Terminal tokens
syn region ungramTerminal matchgroup=Delimiter start=/"/ end=/"/ contained
syn region ungramTerminal matchgroup=Delimiter start=/'/ end=/'/ contained
syn match  ungramComment /\/\/.*$/


hi def link ungramNode            Special 
hi def link ungramRule            Type
hi def link ungramRuleAndLabel    Type

hi def link ungramLabel           String
hi def link ungramLabelSeperator  ungramSpecial

hi def link ungramEndRule         ungramDelimiter
hi def link ungramSpecial         Special
hi def link ungramSpecialSequence Statement

hi def link ungramDelimiter       Delimiter
hi def link ungramTerminal        Constant
hi def link ungramComment         Comment

let b:current_syntax = "ungram"
