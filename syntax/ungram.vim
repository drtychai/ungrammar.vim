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

" Top-Level Node
syn match ungramNode /^\<[A-Z][a-zA-Z_0-9]\+\>*/ nextgroup=ungramNodeSeperator skipwhite
syn match ungramNodeSeperator /=/ contained nextgroup=ungramNodeName skipempty skipwhite

" Rules
syn region ungramRuleLine           start=/^\s\s/ end=/\(^[^ "^#~=*-]\)\@=/ contains=@ungramRules nextgroup=ungramRuleLineAfterFirst
syn region ungramRuleLineAfterFirst start=/^\|\s/ end=/\(^[^ "^#~=*-]\)\@=/ contains=@ungramRules nextgroup=ungramRuleLineAfterFirst,ungramNode,ungramLabeledRule
syn cluster ungramRules contains=ungramNodeName,ungramLabeledRule,ungramLabelSeperator,ungramComment,ungramLiteral,ungramRepetitionSeperator

" Labeled rule
syn match ungramNodeName       /\<[A-Z][a-zA-Z_0-9]\+\>*/ contained nextgroup=@ungramRules skipwhite
syn match ungramLabeledRule    /\<[a-z][a-z_0-9]\+\>/     contained nextgroup=@ungramRules skipwhite
syn match ungramLabelSeperator /:/            transparent contained nextgroup=@ungramRules skipwhite

" Node name as rule
syn match ungramRepetitionSeperator /[?\*]/ contained skipwhite skipempty nextgroup=@ungramRules
syn match ungramComment /\/\/.*/ skipempty 

" Special deliminaters
syn match ungramSpecial /[\-|:=!]/ contained
syn region ungramSpecialSequence   contained matchgroup=ungramSpecial nextgroup=@ungramRules start=/?/ end=/?/ 

" Literals (e.g., 'ident')
syn match ungramChar /[a-z].*/ contained 
syn region ungramLiteral start=/'/ end=/'/ matchgroup=ungramChar nextgroup=@ungramRules skipwhite
syn region ungramLiteral start=/(/ end=/)/ contains=@ungramRules skipwhite

let b:current_syntax = "ungram"

" Color of entire rules block
hi def link ungramNode                 Statement
hi def link ungramNodeName             Conditional
hi def link ungramLabeledRule          Comment

" Color of deliminaters and 
hi def link ungramLiteral              Label 
hi def link ungramComment              Comment

hi def link ungramNodeSeperator        Special
hi def link ungramLabelSeperator       Special
hi def link ungramRepetitionSeperator  Special
