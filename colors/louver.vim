" Name:			louver.vim
" Maintainer:	Kojo Sugita
" Last Change:  2008-08-15
" Version:		1.0

set background=light
hi clear
if exists("syntax_on")
  syntax reset
endif
let g:colors_name = 'louver'

if (&term == "xterm") || (&term == "linux")
	set t_Co=16
elseif &term == "vt320"
	set t_Co=8
endif

" Normal
hi Normal		guifg=black			guibg=white			gui=none
hi NonText		guifg=darkgray
hi SpecialKey	        guifg=darkgray

hi Cursor		guifg=white			guibg=#333333
hi lCursor		guifg=white			guibg=#333333
hi CursorIM		guifg=white			guibg=#333333

" Search
hi Search		guifg=black			guibg=lightred
hi IncSearch	guifg=black			guibg=lightred

" Matches
hi MatchParen	guifg=black			guibg=darkgray		gui=none

" status line
hi StatusLine	guifg=white			guibg=darkgray		gui=bold
hi StatusLineNC	guifg=#e0e0e0			guibg=darkgray		gui=none

" Diff
hi DiffAdd		guifg=darkmagenta	guibg=#f4f4f4			gui=none
hi DiffChange	guifg=darkmagenta	guibg=#f4f4f4			gui=none
hi DiffDelete	guifg=white			guibg=black			gui=none
hi DiffText		guifg=darkmagenta	guibg=#f4f4f4			gui=bold

" Folds
hi Folded		guifg=black			guibg=gray			gui=none
hi FoldColumn	guifg=black			guibg=gray			gui=none

" Syntax
hi Number		guifg=#0000d0
hi Char			guifg=#0000d0
hi String		guifg=#0000d0
hi Boolean		guifg=#0000d0
hi Constant		guifg=darkred

hi Statement	guifg=darkred
hi Comment		guifg=#006000
hi Identifier	guifg=darkmagenta
hi Function		guifg=darkmagenta
hi PreProc		guifg=darkmagenta
hi Type			guifg=darkblue

"\n, \0, %d, %s, etc...
hi Special		guifg=darkred

" Tree
hi Directory	guifg=darkmagenta gui=bold

" Message
hi ModeMsg		guifg=black
hi MoreMsg		guifg=black
hi WarningMsg	guifg=red
hi ErrorMsg		guifg=white			guibg=red
hi Question		guifg=black

hi VertSplit	guifg=darkgray guibg=darkgray
hi LineNr		guifg=black			guibg=#f0f0f0
hi Title		guifg=darkmagenta	gui=bold
hi Visual		guibg=#cedefd
hi VisualNOS	guifg=white			guibg=black
hi WildMenu		guifg=white			guibg=black

"Define, def
hi Underlined	guifg=darkmagenta	gui=underline
hi Error		guifg=red
hi Todo			guifg=black
hi SignColumn	guifg=black

if version >= 700
  "Pmenu
  hi Pmenu							guibg=gray
  hi PmenuSel	guifg=white			guibg=black
  hi PmenuSbar						guibg=gray

  "Tab
  hi TabLine		guifg=gray		guibg=#505050		gui=none
  hi TabLineFill	guifg=gray		guibg=gray			gui=none
  hi TabLineSel		guifg=white		guibg=black			gui=none
endif

finish

" vim: set foldmethod=marker: set fenc=utf-8:
