set nocompatible

" The basics
set number
set ruler
set hidden
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
nnoremap Y y$

" History and undo
set history=1000
set undolevels=2000

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

" Show the status bar
set laststatus=2

" Directories for swp files
set backupdir=~/.vim/backup//
set directory=~/.vim/backup//

" MacVIM shift+arrow-keys behavior (has to be in .vimrc)
let macvim_hig_shift_movement = 1

" Abbreviations etc.
imap <C-l>  => 

" Quick macros!
nnoremap <Space> @s
nnoremap <S-Space> qs

" Map \h to remove search highlights
map \h :noh<CR>

" Arrow keys scroll by visible lines, not absolute lines
nnoremap <Down> gj
nnoremap <Up> gk
vnoremap <Down> gj
vnoremap <Up> gk
inoremap <Down> <C-o>gj
inoremap <Up> <C-o>gk

" When there's wrapping, show whatever instead of not showing incomplete lines
set display+=lastline

" Allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Evaluate arbitrary Ruby one-liners
map <C-e> yyV:!ruby -e "puts <C-r>0"<CR>
imap <C-e> <Esc><C-e>

" Execute arbitrary selections in Ruby
vmap <C-e> :!ruby<CR>

" Remember last location in file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
endif

" Tab completion and Command-T ignores
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.class,.svn,vendor/gems/*,.idea

" % to bounce from do to end etc.
runtime! macros/matchit.vim

" <C-z> to see registers and pick by number
function! PasteRegister(register)
  silent exec "normal \"" . a:register . "p"
endf
command! -nargs=1 PasteRegister :call PasteRegister(<f-args>)
nmap \p :registers<CR>:PasteRegister 

"" File Types

" Thorfile, Rakefile, Vagrantfile and Gemfile are Ruby
au BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,config.ru} set ft=ruby

" Wrapping for text files
au BufRead,BufNewFile *.txt set wrap wm=2 textwidth=72

au FileType atlas set filetype=actionscript
au FileType make set noexpandtab
au FileType python set shiftwidth=4 softtabstop=4 textwidth=79
au FileType javascript set shiftwidth=4 softtabstop=4
au FileType css set shiftwidth=4 softtabstop=4
au FileType scss set shiftwidth=4 softtabstop=4
au FileType actionscript set smartindent noexpandtab tabstop=4 softtabstop=4 shiftwidth=4

"" Vundle

filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'

Bundle 'chriskempson/base16-vim'
Bundle 'kchmck/vim-coffee-script'

Bundle 'mileszs/ack.vim'
  map <D-F> :Ack<space>
  imap <D-F> <Esc>:Ack<space>

Bundle 'rf-/vim-bclose'
  nmap <D-W> :Bclose<CR>
  imap <D-W> <Esc>:Bclose<CR>

Bundle 'wincent/Command-T'
  let g:CommandTMaxHeight=20
  map <D-t> :CommandTBuffer<CR>
  imap <D-t> <Esc>:CommandTBuffer<CR>
  map <D-T> :CommandT<CR>
  imap <D-T> <Esc>:CommandT<CR>

Bundle 'tpope/vim-git'
Bundle 'tpope/vim-fugitive'
  nmap \gs :Gstatus<CR>
  imap \gs <Esc>\gs
  vmap \gs <Esc>\gs
  nmap \gc :Gcommit<CR>
  imap \gc <Esc>\gc
  vmap \gc <Esc>\gc

Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-unimpaired'

Bundle 'tpope/vim-haml'
Bundle 'tpope/vim-markdown'
Bundle 'bbommarito/vim-slim'

Bundle 'sjl/gundo.vim'
  nnoremap <D-u> :GundoToggle<CR>
  let g:gundo_right=1
  let g:gundo_help=0

Bundle 'tpope/vim-rails'

Bundle 'Solarized'
  let g:solarized_style='light'
  color solarized

Bundle 'scrooloose/nerdcommenter'
  map <D-/> <plug>NERDCommenterToggle<CR>

Bundle 'ervandew/supertab'

Bundle 'fholgado/minibufexpl.vim'
  " C-Tab to switch buffers in the current window (in insert mode too)
  let g:miniBufExplMapCTabSwitchBufs = 1
  inoremap <C-TAB> <Esc><C-TAB>
  inoremap <C-S-TAB> <Esc><C-S-TAB>

  " ctrl + arrow keys move from window to window
  let g:miniBufExplMapWindowNavArrows = 1
  nnoremap <C-h> <C-w>h
  nnoremap <C-j> <C-w>j
  nnoremap <C-k> <C-w>k
  nnoremap <C-l> <C-w>l
  inoremap <C-h> <Esc><C-h>
  inoremap <C-j> <Esc><C-j>
  inoremap <C-k> <Esc><C-k>
  inoremap <C-l> <Esc><C-l>

  " No idea what this does, but I put it in so I guess it's cool
  let g:miniBufExplModSelTarget = 1

Bundle 'scrooloose/nerdtree'
  let NERDTreeIgnore=['\.rbc$', '\~$']
  map <Leader>n :NERDTreeToggle<CR>

Bundle 'tomtom/tlib_vim'
Bundle 'MarcWeber/vim-addon-mw-utils'
Bundle 'garbas/vim-snipmate'

filetype plugin indent on
