" syntax/ungram.vim
" Language: Ungrammar
" =======================================================
" =======================================================
"    Grammar =
"      Node*
"    
"    Node =
"      name:'ident' '=' Rule
"    
"    Rule =
"      'ident'                // Alphabetic identifier
"    | 'token_ident'          // Single quoted string
"    | Rule*                  // Concatenation
"    | Rule ('|' Rule)*       // Alternation
"    | Rule '?'               // Zero or one repetition
"    | Rule '*'               // Kleene star
"    | '(' Rule ')'           // Grouping
"    | label:'ident' ':' Rule // Labeled rule
" =======================================================
" =======================================================
if exists("b:current_syntax")
  finish
endif

" Comments use // leader
syntax match ungramComment /\v\/\/.*$/

" Docs use /// leader
syntax match ungramDocComment /\v\/\/\/.*$/

" Operators [ : = ]
syntax match ungramOperator /\v\=/ 
syntax match ungramOperator /\v\:/

" Conditional [ ? | * ] 
syntax match ungramConditional /\v\|/
syntax match ungramConditional /\v\?/
syntax match ungramConditional /\v\*/

" String literals
syntax region ungramString start=/\v'/ skip=/\v\\./ end=/\v'/

" Node - matches all PascalCase
syntax match ungramNodeIdentifier /\('\)\@<![A-Z][_A-Za-z0-9]\+\('\)\@!/

" Node - only matches PascalCase declarations (beginning of line)
syntax match ungramNode /^\('\)\@<![A-Z][_A-Za-z0-9]\+\('\)\@!/

" Label associated with a given Node ( label:Node )
syntax match ungramLabel /\('\)\@<![a-z][_A-Za-z0-9]\+\('\)\@!/

let b:current_syntax = "ungram"
highlight link ungramComment        Comment
highlight link ungramDocComment     Special
highlight link ungramOperator       Operator
highlight link ungramConditional    Special
highlight link ungramString         String
highlight link ungramNodeIdentifier Type 
highlight link ungramNode           Identifier
highlight link ungramLabel          Special
