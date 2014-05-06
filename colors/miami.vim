let s:white = "ffffff"
let s:gray9 = "f3f3f3"
let s:gray8 = "dddddd"
let s:gray7 = "cccccc"
let s:gray6 = "bbbbbb"
let s:gray5 = "999999"
let s:gray4 = "888888"
let s:gray3 = "777777"
let s:gray2 = "555555"
let s:gray1 = "444444"
let s:gray0 = "333333"
let s:black = "222222"

if &background == "dark"
  let s:orange       = "d75f00"
  let s:green        = "00af5f"
  let s:lime         = "87d700"
  let s:blue         = "5fafff"
  let s:purple       = "d75fd7"
  let s:red          = "ff5f87"
  let s:yellow       = "ffd7af"
  let s:bg_purple_br = "5f0087"
  let s:bg_purple    = "5f005f"

  let s:foreground   = s:gray8
  let s:background   = s:black
  let s:line         = s:gray0
  let s:selection    = s:gray1
  let s:searchbg     = s:bg_purple
  let s:incsearchbg  = s:bg_purple_br
  let s:window       = s:gray2
  let s:tablinebg    = s:gray2
  let s:statuslinenc = s:gray5
  let s:statusline   = s:gray8
  let s:linenum      = s:gray2
  let s:linenum_hl   = s:gray5
  let s:directory    = s:gray6
else
  let s:orange       = "ff5f00"
  let s:green        = "5f8700"
  let s:lime         = "87af00"
  let s:blue         = "0087ff"
  let s:purple       = "af0087"
  let s:red          = "d70000"
  let s:yellow       = "d7af00"
  let s:bg_blue      = "afd7ff"
  let s:bg_pink_br   = "ffd7ff"
  let s:bg_pink      = "ffafff"

  let s:foreground   = s:black
  let s:background   = s:white
  let s:line         = s:gray9
  let s:selection    = s:bg_blue
  let s:searchbg     = s:bg_pink
  let s:incsearchbg  = s:bg_pink_br
  let s:window       = s:gray8
  let s:tablinebg    = s:gray6
  let s:statuslinenc = s:gray5
  let s:statusline   = s:black
  let s:linenum      = s:gray7
  let s:linenum_hl   = s:gray5
  let s:directory    = s:gray3
endif

let s:comment = s:gray5

hi clear
syntax reset

let g:colors_name = 'miami'

if has("gui_running") || &t_Co == 88 || &t_Co == 256
	" Returns an approximate grey index for the given grey level
	fun! <SID>grey_number(x)
		if &t_Co == 88
			if a:x < 23
				return 0
			elseif a:x < 69
				return 1
			elseif a:x < 103
				return 2
			elseif a:x < 127
				return 3
			elseif a:x < 150
				return 4
			elseif a:x < 173
				return 5
			elseif a:x < 196
				return 6
			elseif a:x < 219
				return 7
			elseif a:x < 243
				return 8
			else
				return 9
			endif
		else
			if a:x < 14
				return 0
			else
				let l:n = (a:x - 8) / 10
				let l:m = (a:x - 8) % 10
				if l:m < 5
					return l:n
				else
					return l:n + 1
				endif
			endif
		endif
	endfun

	" Returns the actual grey level represented by the grey index
	fun! <SID>grey_level(n)
		if &t_Co == 88
			if a:n == 0
				return 0
			elseif a:n == 1
				return 46
			elseif a:n == 2
				return 92
			elseif a:n == 3
				return 115
			elseif a:n == 4
				return 139
			elseif a:n == 5
				return 162
			elseif a:n == 6
				return 185
			elseif a:n == 7
				return 208
			elseif a:n == 8
				return 231
			else
				return 255
			endif
		else
			if a:n == 0
				return 0
			else
				return 8 + (a:n * 10)
			endif
		endif
	endfun

	" Returns the palette index for the given grey index
	fun! <SID>grey_colour(n)
		if &t_Co == 88
			if a:n == 0
				return 16
			elseif a:n == 9
				return 79
			else
				return 79 + a:n
			endif
		else
			if a:n == 0
				return 16
			elseif a:n == 25
				return 231
			else
				return 231 + a:n
			endif
		endif
	endfun

	" Returns an approximate colour index for the given colour level
	fun! <SID>rgb_number(x)
		if &t_Co == 88
			if a:x < 69
				return 0
			elseif a:x < 172
				return 1
			elseif a:x < 230
				return 2
			else
				return 3
			endif
		else
			if a:x < 75
				return 0
			else
				let l:n = (a:x - 55) / 40
				let l:m = (a:x - 55) % 40
				if l:m < 20
					return l:n
				else
					return l:n + 1
				endif
			endif
		endif
	endfun

	" Returns the actual colour level for the given colour index
	fun! <SID>rgb_level(n)
		if &t_Co == 88
			if a:n == 0
				return 0
			elseif a:n == 1
				return 139
			elseif a:n == 2
				return 205
			else
				return 255
			endif
		else
			if a:n == 0
				return 0
			else
				return 55 + (a:n * 40)
			endif
		endif
	endfun

	" Returns the palette index for the given R/G/B colour indices
	fun! <SID>rgb_colour(x, y, z)
		if &t_Co == 88
			return 16 + (a:x * 16) + (a:y * 4) + a:z
		else
			return 16 + (a:x * 36) + (a:y * 6) + a:z
		endif
	endfun

	" Returns the palette index to approximate the given R/G/B colour levels
	fun! <SID>colour(r, g, b)
		" Get the closest grey
		let l:gx = <SID>grey_number(a:r)
		let l:gy = <SID>grey_number(a:g)
		let l:gz = <SID>grey_number(a:b)

		" Get the closest colour
		let l:x = <SID>rgb_number(a:r)
		let l:y = <SID>rgb_number(a:g)
		let l:z = <SID>rgb_number(a:b)

		if l:gx == l:gy && l:gy == l:gz
			" There are two possibilities
                        let l:dgr = <SID>grey_level(l:gx) - a:r
			let l:dgg = <SID>grey_level(l:gy) - a:g
			let l:dgb = <SID>grey_level(l:gz) - a:b
			let l:dgrey = (l:dgr * l:dgr) + (l:dgg * l:dgg) + (l:dgb * l:dgb)
			let l:dr = <SID>rgb_level(l:gx) - a:r
			let l:dg = <SID>rgb_level(l:gy) - a:g
			let l:db = <SID>rgb_level(l:gz) - a:b
			let l:drgb = (l:dr * l:dr) + (l:dg * l:dg) + (l:db * l:db)
			if l:dgrey < l:drgb
				" Use the grey
				return <SID>grey_colour(l:gx)
			else
				" Use the colour
				return <SID>rgb_colour(l:x, l:y, l:z)
			endif
		else
			" Only one possibility
			return <SID>rgb_colour(l:x, l:y, l:z)
		endif
	endfun

	" Returns the palette index to approximate the 'rrggbb' hex string
	fun! <SID>rgb(rgb)
		let l:r = ("0x" . strpart(a:rgb, 0, 2)) + 0
		let l:g = ("0x" . strpart(a:rgb, 2, 2)) + 0
		let l:b = ("0x" . strpart(a:rgb, 4, 2)) + 0

		return <SID>colour(l:r, l:g, l:b)
	endfun

	" Sets the highlighting for the given group
	fun! <SID>X(group, fg, bg, attr)
		if a:fg != ""
			exec "hi " . a:group . " guifg=#" . a:fg . " ctermfg=" . <SID>rgb(a:fg)
		endif
		if a:bg != ""
			exec "hi " . a:group . " guibg=#" . a:bg . " ctermbg=" . <SID>rgb(a:bg)
		endif
		if a:attr != ""
			exec "hi " . a:group . " gui=" . a:attr . " cterm=" . a:attr . " term=" . a:attr
		endif
	endfun

	" Vim Highlighting
        hi clear Search
        hi clear Cursor

	call <SID>X("Normal",       s:foreground, s:background,   "none")
	call <SID>X("LineNr",       s:linenum,    s:background,   "")
	call <SID>X("NonText",      s:gray3,      s:background,   "")
	call <SID>X("SpecialKey",   s:gray4,      "",             "")
	call <SID>X("Search",       "",           s:searchbg,     "none")
	call <SID>X("IncSearch",    "",           s:incsearchbg,  "none")
	call <SID>X("TabLine",      s:tablinebg,  s:background,   "reverse")
	call <SID>X("TabLineFill",  s:tablinebg,  s:background,   "reverse")
	call <SID>X("TabLineSel",   s:foreground, s:background,   "bold")
	call <SID>X("StatusLine",   s:window,     s:statusline,   "reverse")
	call <SID>X("StatusLineNC", s:window,     s:statuslinenc, "reverse")
	call <SID>X("VertSplit",    s:window,     s:window,       "")
	call <SID>X("SignColumn",   s:gray4,      s:background,   "")
	call <SID>X("Visual",       "",           s:selection,    "")
	call <SID>X("Directory",    s:directory,  s:background,   "")
	call <SID>X("Title",        s:comment,    s:background,   "bold")
	call <SID>X("ModeMsg",      s:green,      s:background,   "bold")
	call <SID>X("MoreMsg",      s:green,      s:background,   "bold")
	call <SID>X("Question",     s:green,      s:background,   "bold")
	call <SID>X("ErrorMsg",     s:red,        s:background,   "bold")
	call <SID>X("WarningMsg",   s:red,        s:background,   "bold")
	call <SID>X("MatchParen",   "",           s:selection,    "")
	call <SID>X("Folded",       s:comment,    s:background,   "")
	call <SID>X("FoldColumn",   "",           s:background,   "")
	call <SID>X("Conceal",      s:gray4,      "",             "")
	call <SID>X("Cursor",       "",           s:background,   "reverse")

	if version >= 700
		call <SID>X("CursorLine", "", s:line, "none")
		call <SID>X("CursorColumn", "", s:line, "none")
		call <SID>X("PMenu", s:foreground, s:selection, "none")
		call <SID>X("PMenuSel", s:foreground, s:selection, "reverse")
	end

	if version >= 703
		call <SID>X("ColorColumn", "", s:line, "none")
		call <SID>X("CursorLineNr", s:linenum_hl, s:line, "none")
	end

	" Standard Highlighting
	call <SID>X("Comment",     s:comment,    s:background, "italic")
	call <SID>X("Todo",        s:lime,       s:background, "italic")
	call <SID>X("Identifier",  s:yellow,     "",           "none")
	call <SID>X("Statement",   s:purple,     "",           "none")
	call <SID>X("Conditional", s:purple,     "",           "none")
	call <SID>X("Repeat",      s:purple,     "",           "none")
	call <SID>X("Structure",   s:red,        "",           "none")
	call <SID>X("Function",    s:lime,       "",           "none")
	call <SID>X("Constant",    s:red,        "",           "none")
	call <SID>X("String",      s:green,      "",           "none")
	call <SID>X("Special",     s:orange,     "",           "none")
	call <SID>X("PreProc",     s:purple,     "",           "none")
	call <SID>X("Operator",    s:foreground, "",           "none")
	call <SID>X("Type",        s:red,        "",           "none")
	call <SID>X("Define",      s:purple,     "",           "none")
	call <SID>X("Include",     s:purple,     "",           "none")

	" Vim Highlighting
	call <SID>X("vimCommand",     s:purple,  "",           "none")
	call <SID>X("vimLineComment", s:comment, s:background, "italic")

	" Ruby Highlighting
	call <SID>X("rubySymbol", s:blue, "", "")
	call <SID>X("rubyConstant", s:red, "", "")
	call <SID>X("rubyPredefinedConstant", s:red, "", "")
	call <SID>X("rubyAttribute", s:purple, "", "")
	call <SID>X("rubyInclude", s:purple, "", "")
	call <SID>X("rubyLocalVariableOrMethod", s:orange, "", "")
	call <SID>X("rubyStringDelimiter", s:green, "", "")
	call <SID>X("rubyInterpolationDelimiter", s:orange, "", "")
	call <SID>X("rubyConditional", s:purple, "", "")
	call <SID>X("rubyClass", s:purple, "", "")
	call <SID>X("rubyModule", s:purple, "", "")
	call <SID>X("rubyRepeat", s:purple, "", "none")
	call <SID>X("rubyCurlyBlockDelimiter", s:purple, "", "none")
	call <SID>X("rubyDefine", s:purple, "", "none")

        " CoffeeScript Highlighting
	call <SID>X("coffeeParens", s:yellow, "", "")

	" JavaScript Highlighting
	call <SID>X("jsFuncArgs", s:yellow, "", "")
	call <SID>X("jsObjectKey", s:yellow, "", "")
	call <SID>X("jsFuncCall", s:blue, "", "")
	call <SID>X("jsFunction", s:purple, "", "")
	"call <SID>X("javaScriptBraces", s:foreground, "", "")
	"call <SID>X("javaScriptFunction", s:foreground, "", "")
	"call <SID>X("javaScriptConditional", s:foreground, "", "")
	"call <SID>X("javaScriptRepeat", s:foreground, "", "")
	"call <SID>X("javaScriptNumber", s:foreground, "", "")
	"call <SID>X("javaScriptMember", s:foreground, "", "")

	" HTML Highlighting
	call <SID>X("htmlTag", s:purple, "", "")
	call <SID>X("htmlEndTag", s:purple, "", "")
	call <SID>X("htmlTagName", s:purple, "", "")
	call <SID>X("htmlArg", s:blue, "", "")
	call <SID>X("htmlScriptTag", s:purple, "", "")
	call <SID>X("xmlTag", s:purple, "", "")
	call <SID>X("xmlEndTag", s:purple, "", "")
	call <SID>X("xmlTagName", s:purple, "", "")
	call <SID>X("xmlEndTag", s:purple, "", "")

	" Diff Highlighting
	call <SID>X("diffAdded", s:green, "", "")
	call <SID>X("diffRemoved", s:red, "", "")

	" Delete Functions
	delf <SID>X
	delf <SID>rgb
	delf <SID>colour
	delf <SID>rgb_colour
	delf <SID>rgb_level
	delf <SID>rgb_number
	delf <SID>grey_colour
	delf <SID>grey_level
	delf <SID>grey_number
endif
