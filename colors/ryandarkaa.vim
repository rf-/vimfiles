" Vim color scheme
"
" Name:        railscast.vim
" Maintainer:  Josh O'Rourke <jorourke23@gmail.com> 
" License:     public domain
"
" A GUI Only port of the RailsCasts TextMate theme [1] to Vim.
" Some parts of this theme were borrowed from the well-documented Lucius theme [2].
" 
" [1] http://railscasts.com/about 
" [2] http://www.vim.org/scripts/script.php?script_id=2536

set guifont=Menlo:h10
set linespace=2
set antialias

"set guifont=Monaco:h10
"set linespace=0
"set noantialias

set background=dark
hi clear
if exists("syntax_on")
  syntax reset
endif
let g:colors_name = "ryandark"

" Colors
" Brown        #BC9458
" Dark Blue    #7eb4db
" Dark Green   #519F50
" Dark Orange  #f27a18
" Light Blue   #D0D0FF
" Light Green  #d5fa7d
" Tan          #ffd88b
" Red          #e4301d

hi Normal                    guifg=white   guibg=#0b0b0b
hi Cursor                    guibg=#FFFFFF
hi CursorLine                guibg=#333435
hi LineNr                    guifg=#888888 guibg=#171717
hi NonText                   guifg=black
hi MatchParen                guifg=white   guibg=#3b3b3b gui=bold
hi Search                    guifg=black   guibg=#5A647E
hi Visual                    guibg=#5A647E

hi VertSplit guifg=gray guibg=gray
" Folds
" -----
" line used for closed folds
hi Folded                    guifg=#F6F3E8 guibg=#444444 gui=NONE

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

"rubyString
hi String                    guifg=#d5fa7d

hi Title                     guifg=#FFFFFF

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
