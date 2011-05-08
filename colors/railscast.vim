" Vim color scheme
"
" Name:        railscast.vim
" Maintainer:  Josh O'Rourke <jorourke23@gmail.com> 
" License:     public domain
"

set background=dark
hi clear
if exists("syntax_on")
  syntax reset
endif
let g:colors_name = "railscast"

" Colors
" Brown        #bc9458
" Dark Blue    #7eb4db
" Dark Green   #519f50
" Dark Orange  #f27a18
" Light Blue   #d0d0ff
" Light Green  #d5fa7d
" Tan          #ffd88b
" Red          #e4301d

hi Normal       guifg=#dddddd   guibg=#1b1b1b
hi Cursor       guibg=#ffffff
hi CursorLine   guibg=#333435
hi LineNr       guifg=#888888 guibg=#171717
hi NonText      guifg=black
hi MatchParen   guifg=white   guibg=#3b3b3b gui=bold
hi Search       guifg=black   guibg=#5a647e
hi Visual       guibg=#5a647e
hi StatusLine   guifg=#f6f3e8 guibg=#444444 gui=italic
hi StatusLineNC guifg=#857b6f guibg=#444444 gui=NONE
hi VertSplit    guifg=#444444 guibg=#444444 gui=NONE
hi Title        guifg=#f6f3e8 guibg=NONE    gui=bold

" Folds
" -----
" line used for closed folds
hi Folded       guifg=#a0a8b0 guibg=#384048 gui=NONE

" Misc
" ----
" directory names and other special names in listings
hi Directory                 guifg=#d5fa7d gui=NONE

" Popup Menu
" ----------
" normal item in popup
hi Pmenu                     guifg=#F6F3E8 guibg=#444444 gui=NONE
" selected item in popup
hi PmenuSel                  guifg=#000000 guibg=#d5fa7d gui=NONE
" scrollbar in popup
hi PMenuSbar                 guibg=#5A647E gui=NONE
" thumb of the scrollbar in the popup
hi PMenuThumb                guibg=#AAAAAA gui=NONE


"rubyComment
hi Comment                   guifg=#BC9458 gui=italic
hi Todo                      guifg=#BC9458 guibg=NONE gui=italic

"rubyPseudoVariable
"nil, self, symbols, etc
hi Constant                  guifg=#7eb4db

"rubyClass, rubyModule, rubyDefine
"def, end, include, etc
hi Define                    guifg=#f27a18

"rubyInterpolation
hi Delimiter                 guifg=#519F50

"rubyError, rubyInvalidVariable
hi Error                     guifg=#FFFFFF guibg=#990000

"rubyFunction
hi Function                  guifg=#ffd88b gui=NONE

"rubyIdentifier
"@var, @@var, $var, etc
hi Identifier                guifg=#D0D0FF gui=NONE

"rubyInclude
"include, autoload, extend, load, require
hi Include                   guifg=#f27a18 gui=NONE

"rubyKeyword, rubyKeywordAsMethod
"alias, undef, super, yield, callcc, caller, lambda, proc
hi Keyword                   guifg=#f27a18

" same as define
hi Macro                     guifg=#f27a18 gui=NONE

"rubyInteger
hi Number                    guifg=#d5fa7d

" #if, #else, #endif
hi PreCondit                 guifg=#f27a18 gui=NONE

" generic preprocessor
hi PreProc                   guifg=#f27a18 gui=NONE

"rubyControl, rubyAccess, rubyEval
"case, begin, do, for, if unless, while, until else, etc.
hi Statement                 guifg=#f27a18 gui=NONE
hi RubyDefine                guifg=#f27a18 gui=NONE

"rubyString
hi String                    guifg=#d5fa7d

"rubyConstant
hi Type                      guifg=#DA4939 gui=NONE

hi DiffAdd                   guifg=#E6E1DC guibg=#144212
hi DiffDelete                guifg=#E6E1DC guibg=#660000

hi link htmlTag              xmlTag
hi link htmlTagName          xmlTagName
hi link htmlEndTag           xmlEndTag

hi xmlTag                    guifg=#E8BF6A
hi xmlTagName                guifg=#E8BF6A
hi xmlEndTag                 guifg=#E8BF6A
