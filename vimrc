set nocompatible

" The basics
set number
set ruler
syntax on

" Set encoding
set encoding=utf-8

" Whitespace stuff
set nowrap
set tabstop=8
set shiftwidth=2
set softtabstop=2
set expandtab
set list listchars=tab:\ \ ,trail:·

" Normalize the behavior of Y to match other capital letters
" nnoremap 

" History and undo
set history=1000
set undolevels=2000

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

" Leaders
let mapleader = "\\"
let maplocalleader = "-"

" Tab completion and Command-T ignores
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.class,.svn,test/fixtures/*,vendor/gems/*,.idea

" Show the status bar
set laststatus=2

" Without setting this, ZoomWin restores windows in a way that causes
" equalalways behavior to be triggered the next time CommandT is used.
" This is likely a bludgeon to solve some other issue, but it works
set noequalalways

" Put modified buffers into the background without vim complaining
set hidden

" Remember last location in file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
endif

" Default color scheme for console vim
color desert

" Directories for swp files
set backupdir=~/.vim/backup//
set directory=~/.vim/backup//

" MacVIM shift+arrow-keys behavior (has to be in .vimrc)
let macvim_hig_shift_movement = 1

" % to bounce from do to end etc.
runtime! macros/matchit.vim

" map 'jj' to leave insert mode
imap jj <Esc>
imap kj <Esc>
imap jk <Esc>

" quick macros!
nnoremap <Space> @q
nnoremap <S-Space> qq

" map <C-h> to remove search highlights
map <C-h> :noh<CR>

" Arrow keys scroll by visible lines, not absolute lines
nnoremap <Down> gj
nnoremap <Up> gk
vnoremap <Down> gj
vnoremap <Up> gk
inoremap <Down> <C-o>gj
inoremap <Up> <C-o>gk

" Evaluate arbitrary Ruby one-liners
map <C-e> yyV:!ruby -e "puts <C-r>0"<CR>
imap <C-e> <Esc><C-e>

" Execute arbitrary selections in Ruby
vmap <C-e> :!ruby<CR>

" Switch buffers by number with M-Tab
map <M-TAB> :b
imap <M-TAB> <Esc><M-TAB>

" when there's wrapping, show what you can instead of not showing incomplete lines
set display+=lastline

function s:setupWrapping()
  set wrap
  set wm=2
  set textwidth=72
endfunction

function s:setupMarkup()
  call s:setupWrapping()
  map <buffer> <Leader>p :Mm <CR>
endfunction

" Thorfile, Rakefile, Vagrantfile and Gemfile are Ruby
au BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,config.ru} set ft=ruby

" md, markdown, and mk are markdown and define buffer-local preview
au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn} call s:setupMarkup()

au BufRead,BufNewFile *.txt call s:setupWrapping()

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Opens an edit command with the path of the currently edited file filled in
" Normal mode: <Leader>e
map <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

" Inserts the path of the currently edited file into a command
" Command mode: Ctrl+P
cmap <C-P> <C-R>=expand("%:p:h") . "/" <CR>

" Show syntax highlighting groups for word under cursor
function! <SID>SynStack()
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
nmap <C-S-P> :call <SID>SynStack()<CR>

" w!! -> sudo write
cmap w!! w !sudo tee % >/dev/null

" pathogen + bundle settings
filetype off
call pathogen#runtime_append_all_bundles()

" minibufexpl
let g:miniBufExplMapCTabSwitchBufs = 1  " C-Tab to switch buffers in the current window (in insert mode too)
inoremap <C-TAB> <Esc><C-TAB>
inoremap <C-S-TAB> <Esc><C-S-TAB>

let g:miniBufExplMapWindowNavArrows = 1 " ctrl + arrow keys move from window to window, also ctrl + hjkl
" disabled since c-h is currently for clearing highlights
"nnoremap <C-h> <C-w>h
"nnoremap <C-j> <C-w>j
"nnoremap <C-k> <C-w>k
"nnoremap <C-l> <C-w>l
"inoremap <C-h> <Esc><C-h>
"inoremap <C-j> <Esc><C-j>
"inoremap <C-k> <Esc><C-k>
"inoremap <C-l> <Esc><C-l>

let g:miniBufExplModSelTarget = 1       " no idea what this does, but I put it in so I guess it's cool

" nerdtree (lots of NERDtree-specific stuff in gvimrc too)
let NERDTreeIgnore=['\.rbc$', '\~$']
map <Leader>n :NERDTreeToggle<CR>

filetype plugin indent on

au FileType make set noexpandtab
au FileType python set shiftwidth=4 softtabstop=4 textwidth=79
au FileType actionscript set shiftwidth=4 softtabstop=4
au FileType javascript set shiftwidth=4 softtabstop=4
au FileType css set shiftwidth=4 softtabstop=4
au FileType scss set shiftwidth=4 softtabstop=4
au FileType actionscript set smartindent noexpandtab tabstop=4 shiftwidth=4

function! TextEnableCodeSnip(filetype,start,end,textSnipHl) abort
  let ft=toupper(a:filetype)
  let group='textGroup'.ft
  if exists('b:current_syntax')
    let s:current_syntax=b:current_syntax
    " Remove current syntax definition, as some syntax files (e.g. cpp.vim)
    " do nothing if b:current_syntax is defined.
    unlet b:current_syntax
  endif
  execute 'syntax include @'.group.' syntax/'.a:filetype.'.vim'
  try
    execute 'syntax include @'.group.' after/syntax/'.a:filetype.'.vim'
  catch
  endtry
  if exists('s:current_syntax')
    let b:current_syntax=s:current_syntax
  else
    unlet b:current_syntax
  endif
  execute 'syntax region textSnip'.ft.'
  \ matchgroup='.a:textSnipHl.'
  \ start="'.a:start.'" end="'.a:end.'"
  \ contains=@'.group
endfunction

au FileType org call TextEnableCodeSnip('sh',         '=sh=',   '=end=', 'SpecialComment')
au FileType org call TextEnableCodeSnip('ruby',       '=ruby=', '=end=', 'SpecialComment')
au FileType org call TextEnableCodeSnip('javascript', '=js=',   '=end=', 'SpecialComment')
au FileType org call TextEnableCodeSnip('sql',        '=sql=',  '=end=', 'SpecialComment')
