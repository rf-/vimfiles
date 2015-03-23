set nocompatible
set ambiwidth=single

" The basics
set number
set ruler
set hidden
set colorcolumn=80
set showcmd
syntax on

function! DarkTheme()
  set background=dark
  color miami
endfunction

function! LightTheme()
  set background=light
  color miami
endfunction

call LightTheme()

" Map jj to <Esc> (for pairing)
inoremap jj <Esc>

" Format options:
" * c: Autowrap comments using textwidth
" * r: Insert comment leader after hitting enter
" * o: Insert comment leader after hitting o or O
" * q: Allow formatting of comments with `gq`
" * j: Remove comment leader on join
set formatoptions=croqj
set textwidth=79

" Use space as leader
let mapleader=" "

" Automatically load external changes to files that don't have unsaved changes
set autoread

" Keep the current split at a min width of 88 cols and min height of 10 rows
set winwidth=88
set winheight=10

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

" Map <Leader>h to remove search highlights
map <Leader>h :noh<CR>

" Map F10 to show syntax groups under cursor
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" Remap Q to run macro in register q
nnoremap Q @q

" Map <Leader>r to toggle relative line numbering
function! ToggleNumbering()
  if &relativenumber
    set norelativenumber
  else
    set relativenumber
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
set wildignore+=*.o,*.obj,.git,*.rbc,*.class,.svn,vendor/gems/*,.idea,node_modules

" % to bounce from do to end etc.
runtime! macros/matchit.vim

" <Leader>p to see registers and pick by number
function! PasteRegister(register)
  silent exec "normal \"" . a:register . "p"
endf
command! -nargs=1 PasteRegister :call PasteRegister(<f-args>)
nmap <Leader>p :registers<CR>:PasteRegister 

" Delete all modifiable buffers with no unsaved changes
function! BcloseIfFile()
  if &modifiable
    silent! Bclose
  endif
endf
nnoremap <Leader>bc :Bclose<CR>
nnoremap <Leader>BC :bufdo call BcloseIfFile()<CR>

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

" Save easily
nnoremap <Leader>w :w<CR>

" Fix highlighting in SignColumn
highlight clear SignColumn

" <Leader>1 to run the given shell command and load it into a split
command! -nargs=* -complete=shellcmd ReadCmd
      \ vnew |
      \ setlocal buftype=nofile bufhidden=hide noswapfile filetype=railslog |
      \ setlocal modifiable noreadonly |
      \ silent read !<args>
nmap <Leader>1 :ReadCmd 

" <Leader>2 to run `tree` on the given dir and load it into a split
command! -nargs=* -complete=dir ReadTree
      \ vnew |
      \ setlocal buftype=nofile bufhidden=hide noswapfile |
      \ silent read !tree <args>
nmap <Leader>2 :ReadTree 

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
  " <Leader>a to Ag for word under cursor
  map <Leader>a "zyw:exe "Ag! ".@z.""<CR>

Bundle 'rf-/vim-bclose'
  nmap <D-W> :Bclose<CR>
  imap <D-W> <Esc>:Bclose<CR>

Bundle 'tpope/vim-vinegar'

Bundle 'scrooloose/nerdtree'
  let g:NERDTreeHijackNetrw='0'
  map <Leader>n :NERDTreeToggle<CR>

"" Syntax, etc.

Bundle 'kchmck/vim-coffee-script'
Bundle 'tpope/vim-git'
Bundle 'tpope/vim-haml'
Bundle 'tpope/vim-markdown'
Bundle 'slim-template/vim-slim'

  let javascript_enable_domhtmlcss   = '1'
  let g:javascript_conceal_function  = "ƒ"
  let g:javascript_conceal_null      = "ø"
  "let g:javascript_conceal_this      = "@"
  let g:javascript_conceal_return    = "⇚"
  let g:javascript_conceal_undefined = "¿"
  "let g:javascript_conceal_NaN       = "ℕ"
  "let g:javascript_conceal_prototype = "¶"
  "let g:javascript_conceal_static    = "•"
  "let g:javascript_conceal_super     = "Ω"
Bundle 'pangloss/vim-javascript'

Bundle 'briancollins/vim-jst'
Bundle 'jnwhiteh/vim-golang'
Bundle 'digitaltoad/vim-jade'
Bundle 'guns/vim-clojure-static'
Bundle 'vim-ruby/vim-ruby'
Bundle 'wting/rust.vim'
Bundle 'noprompt/vim-yardoc'
"Bundle 'mxw/vim-jsx'
Bundle 'jdonaldson/vaxe'

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
  let g:UltiSnipsExpandTrigger='<C-e>'

Bundle 'jpalardy/vim-slime'
  let g:slime_target = 'tmux'

let g:paredit_leader = '\'
Bundle 'kovisoft/paredit'

Bundle 'xolox/vim-misc'
Bundle 'xolox/vim-notes'
  let g:notes_directories = ['~/.vim/notes']

Bundle 'mjbrownie/swapit'
  let g:swap_lists = [{'name':'todo_done', 'options': ['TODO', 'DONE']}]

Bundle 'ConradIrwin/vim-bracketed-paste'

Bundle 'Valloric/YouCompleteMe'
  set completeopt-=preview

Bundle 'nsf/gocode', {'rtp': 'vim/'}

Bundle 'AndrewRadev/splitjoin.vim'
  nmap <Leader>j :SplitjoinJoin<cr>
  nmap <Leader>s :SplitjoinSplit<cr>

Bundle 'godlygeek/tabular'

  nmap <Leader>i :ImportJSImport<cr>
Bundle 'trotzig/import-js'

filetype plugin indent on

"" File Types

" Thorfile, Rakefile, Vagrantfile and Gemfile are Ruby
au BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,config.ru} set ft=ruby

" Wrapping for text files
au BufRead,BufNewFile *.txt set wrap wm=2 textwidth=72

" Override stupid l option (TODO: figure out where it's coming from)
au BufRead,BufNewFile * set formatoptions-=l

au FileType atlas set filetype=actionscript
au FileType make set noexpandtab
au FileType python set shiftwidth=4 softtabstop=4 textwidth=79
au FileType javascript set shiftwidth=2 softtabstop=2 conceallevel=1
au FileType coffee set shiftwidth=2 softtabstop=2
au FileType css set shiftwidth=2 softtabstop=2
au FileType scss set shiftwidth=2 softtabstop=2
au FileType actionscript set smartindent noexpandtab tabstop=4 softtabstop=4 shiftwidth=4
au FileType go set noexpandtab tabstop=4 shiftwidth=4
au FileType haxe set tabstop=4 shiftwidth=4 softtabstop=4
