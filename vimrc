set nocompatible

" The basics
set number
set ruler
set hidden
syntax on
color Tomorrow
hi SignColumn ctermbg=255
set colorcolumn=80

" Mouse support in the terminal
if !has("gui_running")
  set mouse=a
  set ttymouse=xterm2
end

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

" History and persistent undo
set history=1000
set undofile
set undodir=~/.vim/undo
set undolevels=2000
set undoreload=20000

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

" Quick macros!
nnoremap <Space> @s
nnoremap <S-Space> qs

" Map \h to remove search highlights
map <Leader>h :noh<CR>

" Arrow keys scroll by visible lines, not absolute lines
nnoremap <Down> gj
nnoremap <Up> gk
vnoremap <Down> gj
vnoremap <Up> gk
inoremap <Down> <C-o>gj
inoremap <Up> <C-o>gk

" Map <C-h,j,k,l> to switch between splits, in normal and insert mode
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
inoremap <C-h> <Esc><C-h>
inoremap <C-j> <Esc><C-j>
inoremap <C-k> <Esc><C-k>
inoremap <C-l> <Esc><C-l>

" Tab and Shift-Tab to switch between buffers
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>

" When there's wrapping, show whatever instead of not showing incomplete lines
set display+=lastline

" Allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Evaluate current line as a Ruby expression
map <C-e> yyV:!ruby -e "puts <C-r>0"<CR>
imap <C-e> <Esc><C-e>

" Run selection as a Ruby script
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

" \p to see registers and pick by number
function! PasteRegister(register)
  silent exec "normal \"" . a:register . "p"
endf
command! -nargs=1 PasteRegister :call PasteRegister(<f-args>)
nmap <Leader>p :registers<CR>:PasteRegister 

" \b to see buffers and pick by number
nmap <Leader>b :buffers<CR>:b

" TextMate-style indentation
nmap <D-[> <<
nmap <D-]> >>
vmap <D-[> <gv
vmap <D-]> >gv
nmap <Leader>[ <<
nmap <Leader>] >>
vmap <Leader>[ <gv
vmap <Leader>] >gv

" Disable annoying :only bindings
map <C-w>o <Nop>
map <C-w><C-o> <Nop>

" Fix highlighting in SignColumn
highlight clear SignColumn

"" Vundle

filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'

"" Navigation and search

Bundle 'wincent/Command-T'
  let g:CommandTMaxHeight=20
  map <D-t> :CommandTBuffer<CR>
  imap <D-t> <Esc>:CommandTBuffer<CR>
  map <D-T> :CommandT<CR>
  imap <D-T> <Esc>:CommandT<CR>
  map <Leader>t :CommandTBuffer<CR>
  map <Leader>T :CommandT<CR>

Bundle 'epmatsw/ag.vim'
  map <D-F> :Ag<space>
  imap <D-F> <Esc>:Ag<space>

Bundle 'rf-/vim-bclose'
  nmap <D-W> :Bclose<CR>
  imap <D-W> <Esc>:Bclose<CR>

Bundle 'scrooloose/nerdtree'
  let NERDTreeIgnore=['\.rbc$', '\~$']
  map <Leader>n :NERDTreeToggle<CR>
  map <Leader>N :NERDTree<CR>

"" Syntax, etc.

Bundle 'kchmck/vim-coffee-script'
Bundle 'tpope/vim-git'
Bundle 'tpope/vim-haml'
Bundle 'tpope/vim-markdown'
Bundle 'bbommarito/vim-slim'
Bundle 'pangloss/vim-javascript'
Bundle 'briancollins/vim-jst'
Bundle 'jnwhiteh/vim-golang'
Bundle 'digitaltoad/vim-jade'
Bundle 'guns/vim-clojure-static'

"" Color schemes

Bundle 'chriskempson/base16-vim'
Bundle 'noahfrederick/Hemisu'
Bundle 'Solarized'
  let g:solarized_style='light'
Bundle 'dterei/VimCobaltColourScheme'

"" Misc.

Bundle 'airblade/vim-gitgutter'
  nmap ]g :GitGutterNextHunk<CR>
  nmap [g :GitGutterPrevHunk<CR>

Bundle 'tpope/vim-fugitive'
  nmap <Leader>gs :Gstatus<CR>
  imap <Leader>gs <Esc>\gs
  vmap <Leader>gs <Esc>\gs
  nmap <Leader>gc :Gcommit<CR>
  imap <Leader>gc <Esc>\gc
  vmap <Leader>gc <Esc>\gc

Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-unimpaired'
Bundle 'tpope/vim-speeddating'

Bundle 'sjl/gundo.vim'
  nnoremap <D-u> :GundoToggle<CR>
  let g:gundo_right=1
  let g:gundo_help=0

Bundle 'scrooloose/nerdcommenter'
  map <Leader>/ <plug>NERDCommenterToggle<CR>
  map <D-/> <plug>NERDCommenterToggle<CR>

Bundle 'ervandew/supertab'

Bundle 'tomtom/tlib_vim'
Bundle 'MarcWeber/vim-addon-mw-utils'
Bundle 'garbas/vim-snipmate'

Bundle 'jpalardy/vim-slime'
  let g:slime_target = 'tmux'

let g:paredit_leader = '\'
Bundle 'https://bitbucket.org/kovisoft/paredit'

Bundle 'utl.vim'
Bundle 'xolox/vim-notes'
  let g:notes_directory = '~/.vim/notes'

Bundle 'mjbrownie/swapit'
  let g:swap_lists = [{'name':'todo_done', 'options': ['TODO', 'DONE']}]

Bundle 'godlygeek/csapprox'

filetype plugin indent on

"" File Types

" Thorfile, Rakefile, Vagrantfile and Gemfile are Ruby
au BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,config.ru} set ft=ruby

" Wrapping for text files
au BufRead,BufNewFile *.txt set wrap wm=2 textwidth=72

au FileType atlas set filetype=actionscript
au FileType make set noexpandtab
au FileType python set shiftwidth=4 softtabstop=4 textwidth=79
au FileType javascript set shiftwidth=4 softtabstop=4
au FileType coffee set shiftwidth=2 softtabstop=2
au FileType css set shiftwidth=4 softtabstop=4
au FileType scss set shiftwidth=4 softtabstop=4
au FileType actionscript set smartindent noexpandtab tabstop=4 softtabstop=4 shiftwidth=4
