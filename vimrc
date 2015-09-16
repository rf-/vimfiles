set nocompatible
set ambiwidth=single

" The basics
set number
set ruler
set hidden
set colorcolumn=80
set showcmd
syntax on

command! DarkTheme  :set background=dark  | color miami
command! LightTheme :set background=light | color miami

LightTheme

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

" Set encoding
set encoding=utf-8

" Whitespace stuff
set nowrap
set tabstop=8
set shiftwidth=2
set softtabstop=2
set expandtab
set list listchars=tab:\ \ ,trail:·

" Insert/remove tabs at beginning of line based on sw instead of ts/sts
set smarttab

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

" Copy and paste to/from system clipboard
set clipboard=unnamedplus

" Map <Leader>h to remove search highlights
map <Leader>h :noh<CR>

" Map <Leader>q to close the current split (or quit Vim)
map <Leader>q :q<CR>

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

" Remember last location in file
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
  \| exe "normal g'\"" | endif

" Tab completion and Command-T ignores
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.class,.svn,vendor/gems/*,.idea,node_modules

" TextMate-style indentation
nmap <Leader>[ <<
nmap <Leader>] >>
vmap <Leader>[ <gv
vmap <Leader>] >gv

" Save easily
nnoremap <Leader>w :w<CR>

" Fix highlighting in SignColumn
highlight clear SignColumn

"" Plugins

call plug#begin()

"" Navigation and search

Plug 'epmatsw/ag.vim'
Plug 'rf-/vim-bclose'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-vinegar'

"" Languages

Plug 'guns/vim-clojure-static'
Plug 'jdonaldson/vaxe'
Plug 'jnwhiteh/vim-golang'
Plug 'kchmck/vim-coffee-script'
Plug 'mxw/vim-jsx'
Plug 'noprompt/vim-yardoc'
Plug 'nsf/gocode', {'rtp': 'vim/'}
Plug 'pangloss/vim-javascript'
Plug 'slim-template/vim-slim'
Plug 'tpope/vim-git'
Plug 'tpope/vim-haml'
Plug 'tpope/vim-markdown'
Plug 'vim-ruby/vim-ruby'

"" Misc.

Plug 'AndrewRadev/splitjoin.vim'
Plug 'SirVer/ultisnips'
Plug 'Valloric/YouCompleteMe', { 'do': './install.sh' }
Plug 'airblade/vim-gitgutter'
Plug 'godlygeek/tabular'
Plug 'kovisoft/paredit'
Plug 'mjbrownie/swapit'
Plug 'scrooloose/nerdcommenter'
Plug 'sjl/gundo.vim'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'

"" Platform-specific

if has("nvim")
  Plug 'Shougo/unite.vim'
else
  Plug 'ConradIrwin/vim-bracketed-paste'
  Plug 'trotzig/import-js'

  function! BuildCommandT(info)
    if a:info.status == 'installed' || a:info.force
      ruby VIM.command("let g:ruby_executable_path = '#{RbConfig.ruby}'")
      exec "!cd ruby/command-t && " . g:ruby_executable_path . " extconf.rb && make"
    endif
  endfunction

  Plug 'wincent/Command-T', { 'do': function('BuildCommandT') }
end

call plug#end()

" ag.vim
map <Leader>f :Ag<Space>
map <Leader>a "zyiw:exe "Ag! ".@z.""<CR>

" gundo.vim
nnoremap <Leader>u :GundoToggle<CR>
let g:gundo_right = 1
let g:gundo_help = 0

" nerdcommenter
map <Leader>/ <plug>NERDCommenterToggle<CR>

" nerdtree
let g:NERDTreeHijackNetrw = '0'
map <Leader>n :NERDTreeToggle<CR>

" paredit
let g:paredit_leader = '\'

" splitjoin.vim
nmap <Leader>j :SplitjoinJoin<cr>
nmap <Leader>s :SplitjoinSplit<cr>

" ultisnips
let g:UltiSnipsExpandTrigger='<C-e>'

" vim-bclose
nnoremap <Leader>bc :Bclose<CR>

" vim-fugitive
nmap <Leader>gs :Gstatus<CR>
nmap <Leader>gc :Gcommit<CR>

" vim-gitgutter
nmap ]g :GitGutterNextHunk<CR>
nmap [g :GitGutterPrevHunk<CR>

" vim-jsx
let g:jsx_ext_required = 0

" YouCompleteMe
set completeopt-=preview

"" File Types

" Thorfile, Rakefile, Vagrantfile and Gemfile are Ruby
au BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,config.ru}
  \ set filetype=ruby

" Wrapping for text files
au BufRead,BufNewFile *.txt set wrap wrapmargin=2 textwidth=72

" Override stupid l option (TODO: figure out where it's coming from)
au BufRead,BufNewFile * set formatoptions-=l

au FileType coffee set shiftwidth=2 softtabstop=2
au FileType css set shiftwidth=2 softtabstop=2
au FileType go set noexpandtab tabstop=4 shiftwidth=4
au FileType haxe set tabstop=4 shiftwidth=4 softtabstop=4
au FileType javascript set shiftwidth=2 softtabstop=2
au FileType make set noexpandtab
au FileType python set shiftwidth=4 softtabstop=4 textwidth=79
au FileType scss set shiftwidth=2 softtabstop=2

" Load implementation-specific config
let s:vimdir = fnamemodify(resolve(expand('<sfile>:p')), ':h')
if has("nvim")
  exec "source " . s:vimdir . "/vimrc-neo"
else
  exec "source " . s:vimdir . "/vimrc-paleo"
end
