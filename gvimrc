" personal preferences, obvs

color railscast
set transparency=2
set guifont=Menlo:h11 linespace=2
set antialias

map <Leader>1 :set guifont=Menlo:h11 linespace=2
map <Leader>2 :set guifont=Monaco:h11 linespace=0
map <Leader>3 :set guifont=Monaco:h10 linespace=0

map <Leader>4 :color louver:set transparency=3
map <Leader>5 :color mayansmoke:set transparency=2
map <Leader>6 :color pyte:set transparency=2
map <Leader>7 :let g:solarized_style='light':color solarized:set transparency=3
map <Leader>8 :let g:solarized_style='dark':color solarized:set transparency=3
map <Leader>9 :color molokai:set transparency=2
map <Leader>0 :color railscast:set transparency=2
map <Leader>- :color wombat:set transparency=2

set lines=60
set columns=115

" don't break visual mode with the arrow keys
behave xterm

" no scrollbars or toolbar
set go=egm
"set go-=l set go-=L set go-=r set go-=R set go-=T

" Fullscreen takes up entire screen
set fuoptions=maxhorz,maxvert

" Command-R + Return to execute current file
nmap <D-r> :!% 

" TextMate-style indentation
nmap <D-[> <<
nmap <D-]> >>
vmap <D-[> <gv
vmap <D-]> >gv

" Command-Return for fullscreen
macmenu Window.Toggle\ Full\ Screen\ Mode key=<D-CR>

" Clear shortcuts
macmenu &File.New\ Tab key=<nop>
macmenu &File.Close\ Window key=<nop>

" Persistent undo across opens of a given file
set undodir=~/.vim/undo//
set undofile

" ack
map <D-F> :Ack<space>
imap <D-F> <Esc>:Ack<space>

" bclose
nmap <D-W> :Bclose<CR>
imap <D-W> <Esc>:Bclose<CR>
"nmap <C-D-W> :Bclose!<CR>
"imap <C-D-W> <Esc>:Bclose!<CR>

" commandt
map <D-t> :CommandT<CR>
imap <D-t> <Esc>:CommandT<CR>
let g:CommandTMaxHeight=30

" conqueshell
function StartTerm()
  execute 'ConqueTerm ' . $SHELL . ' --login'
  setlocal listchars=tab:\ \ 
endfunction
map <D-e> :call StartTerm()<CR>

" gundo
nnoremap <D-u> :GundoToggle<CR>
let g:gundo_right=1
let g:gundo_help=0

" nerdcommenter
map <D-/> <plug>NERDCommenterToggle<CR>

" (everything from here down is NERDtree stuff from Janus basically)

autocmd VimEnter * call s:CdIfDirectory(expand("<amatch>"))
autocmd FocusGained * call s:UpdateNERDTree()
autocmd WinEnter * call s:CloseIfOnlyNerdTreeLeft()

" Close all open buffers on entering a window if the only
" buffer that's left is the NERDTree buffer
function s:CloseIfOnlyNerdTreeLeft()
  if exists("t:NERDTreeBufName")
    if bufwinnr(t:NERDTreeBufName) != -1
      if winnr("$") == 1
        q
      endif
    endif
  endif
endfunction

" If the parameter is a directory, cd into it
function s:CdIfDirectory(directory)
  let explicitDirectory = isdirectory(a:directory)
  let directory = explicitDirectory || empty(a:directory)

  if explicitDirectory
    exe "cd " . fnameescape(a:directory)
  endif

  " Allows reading from stdin
  " ex: git diff | mvim -R -
  if strlen(a:directory) == 0 
    return
  endif

  if directory
    NERDTree
    wincmd p
    bd
  endif

  if explicitDirectory
    wincmd p
  endif
endfunction

" NERDTree utility function
function s:UpdateNERDTree(...)
  let stay = 0

  if(exists("a:1"))
    let stay = a:1
  end

  if exists("t:NERDTreeBufName")
    let nr = bufwinnr(t:NERDTreeBufName)
    if nr != -1
      exe nr . "wincmd w"
      exe substitute(mapcheck("R"), "<CR>", "", "")
      if !stay
        wincmd p
      end
    endif
  endif

  if exists(":CommandTFlush") == 2
    CommandTFlush
  endif
endfunction

" Utility functions to create file commands
function s:CommandCabbr(abbreviation, expansion)
  execute 'cabbrev ' . a:abbreviation . ' <c-r>=getcmdpos() == 1 && getcmdtype() == ":" ? "' . a:expansion . '" : "' . a:abbreviation . '"<CR>'
endfunction

function s:FileCommand(name, ...)
  if exists("a:1")
    let funcname = a:1
  else
    let funcname = a:name
  endif

  execute 'command -nargs=1 -complete=file ' . a:name . ' :call ' . funcname . '(<f-args>)'
endfunction

function s:DefineCommand(name, destination)
  call s:FileCommand(a:destination)
  call s:CommandCabbr(a:name, a:destination)
endfunction

" Public NERDTree-aware versions of builtin functions
function ChangeDirectory(dir, ...)
  execute "cd " . fnameescape(a:dir)
  let stay = exists("a:1") ? a:1 : 1

  NERDTree

  if !stay
    wincmd p
  endif
endfunction

function Touch(file)
  execute "!touch " . shellescape(a:file, 1)
  call s:UpdateNERDTree()
endfunction

function Remove(file)
  let current_path = expand("%")
  let removed_path = fnamemodify(a:file, ":p")

  if (current_path == removed_path) && (getbufvar("%", "&modified"))
    echo "You are trying to remove the file you are editing. Please close the buffer first."
  else
    execute "!rm " . shellescape(a:file, 1)
  endif

  call s:UpdateNERDTree()
endfunction

function Mkdir(file)
  execute "!mkdir " . shellescape(a:file, 1)
  call s:UpdateNERDTree()
endfunction

function Edit(file)
  if exists("b:NERDTreeRoot")
    wincmd p
  endif

  execute "e " . fnameescape(a:file)

ruby << RUBY
  destination = File.expand_path(VIM.evaluate(%{system("dirname " . shellescape(a:file, 1))}))
  pwd         = File.expand_path(Dir.pwd)
  home        = pwd == File.expand_path("~")

  if home || Regexp.new("^" + Regexp.escape(pwd)) !~ destination
    VIM.command(%{call ChangeDirectory(fnamemodify(a:file, ":h"), 0)})
  end
RUBY
endfunction

" Define the NERDTree-aware aliases
call s:DefineCommand("cd", "ChangeDirectory")
call s:DefineCommand("touch", "Touch")
call s:DefineCommand("rm", "Remove")
call s:DefineCommand("e", "Edit")
call s:DefineCommand("mkdir", "Mkdir")
