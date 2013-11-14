set nocompatible
set ambiwidth=single

" The basics
set number
set ruler
set hidden
syntax on
color Tomorrow
hi SignColumn ctermbg=255
set colorcolumn=80
set showcmd

" Automatically load external changes to files that don't have unsaved changes
set autoread

" Keep some padding between the cursor and the edge of the screen
set scrolloff=1
set sidescrolloff=5

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

" Map \h to remove search highlights
map <Leader>h :noh<CR>

" Map \r to toggle relative line numbering
function! ToggleNumbering()
  if &number
    set relativenumber
  else
    set number
  endif
endf
nmap <silent> <Leader>r :call ToggleNumbering()<CR>

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

" When there's wrapping, show whatever instead of not showing incomplete lines
set display+=lastline

" Allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Don't try to complete included files
set complete-=i

" Show matching brackets (but not for very long)
set showmatch
set matchtime=1

" Insert/remove tabs at beginning of line based on sw instead of ts/sts
set smarttab

" Evaluate current line as a Ruby expression
map <C-e> yyV:!ruby -e "puts <C-r>0"<CR>

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
  " \a to Ag for word under cursor
  map <Leader>a "zyw:exe "Ag! ".@z.""<CR>

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
Bundle 'slim-template/vim-slim'
Bundle 'pangloss/vim-javascript'
Bundle 'briancollins/vim-jst'
Bundle 'jnwhiteh/vim-golang'
Bundle 'digitaltoad/vim-jade'
Bundle 'guns/vim-clojure-static'
Bundle 'vim-ruby/vim-ruby'
Bundle 'wting/rust.vim'

"" Color schemes

Bundle 'chriskempson/base16-vim'
Bundle 'noahfrederick/Hemisu'
Bundle 'Solarized'
  let g:solarized_style='light'
Bundle 'dterei/VimCobaltColourScheme'
Bundle 'https://bitbucket.org/kisom/eink.vim.git'

"" Misc.

Bundle 'airblade/vim-gitgutter'
  nmap ]g :GitGutterNextHunk<CR>
  nmap [g :GitGutterPrevHunk<CR>

Bundle 'tpope/vim-fugitive'
  nmap <Leader>gs :Gstatus<CR>
  nmap <Leader>gc :Gcommit<CR>

Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-unimpaired'
Bundle 'tpope/vim-speeddating'
Bundle 'tpope/vim-dispatch'

Bundle 'sjl/gundo.vim'
  nnoremap <D-u> :GundoToggle<CR>
  let g:gundo_right=1
  let g:gundo_help=0

Bundle 'scrooloose/nerdcommenter'
  map <Leader>/ <plug>NERDCommenterToggle<CR>
  map <D-/> <plug>NERDCommenterToggle<CR>

Bundle 'SirVer/ultisnips'
  "let g:UltiSnipsSnippetDirectories=["snippets"]
  let g:UltiSnipsExpandTrigger='<C-e>'

Bundle 'jpalardy/vim-slime'
  let g:slime_target = 'tmux'

let g:paredit_leader = '\'
Bundle 'https://bitbucket.org/kovisoft/paredit'

Bundle 'xolox/vim-misc'
Bundle 'xolox/vim-notes'
  let g:notes_directories = ['~/.vim/notes']

Bundle 'mjbrownie/swapit'
  let g:swap_lists = [{'name':'todo_done', 'options': ['TODO', 'DONE']}]

Bundle 'ConradIrwin/vim-bracketed-paste'

Bundle 'Valloric/YouCompleteMe'
  set completeopt-=preview

Bundle 'nsf/gocode', {'rtp': 'vim/'}

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
au FileType go set noexpandtab tabstop=4 shiftwidth=4
