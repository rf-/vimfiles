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

" Enable mouse support
set mouse=a

" Format options:
" * c: Autowrap comments using textwidth
" * r: Insert comment leader after hitting enter
" * o: Insert comment leader after hitting o or O
" * q: Allow formatting of comments with `gq`
" * j: Remove comment leader on join
set formatoptions=croqj
set textwidth=79
set nojoinspaces " don't use two spaces after periods

" Use space as leader
let mapleader=" "

" Automatically load external changes to files that don't have unsaved changes
set autoread

" Keep the current split at a min width of 88 cols and min height of 10 rows
set winwidth=88
set winheight=10

" Open new splits below and to the right
set splitbelow
set splitright

" Keep some padding between the cursor and the edge of the screen
set scrolloff=1
set sidescrolloff=5

" Set encoding
silent! set encoding=utf-8

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

" Improve ergonomics of global marks
nnoremap ~ `

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

" Make it possible to access digraphs despite remapping <C-k>
" (e.g., <M-k>'9 to produce ’)
inoremap <M-k> <C-k>

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

" Map <Leader>3 or <Leader># to go to alternate file
nnoremap <Leader># :e#<CR>
nnoremap <Leader>3 :e#<CR>

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

" Reload all changed files
command! ReloadAll :split <Bar> exec 'bufdo edit' <Bar> syntax on <Bar> quit

" Use <C-d> and <C-u> to scroll by 25% of window size
autocmd WinEnter * exec 'set scroll=' . (winheight(0) / 4)
nnoremap <C-d> :exec 'normal ' . &scroll . 'j'<CR>
nnoremap <C-u> :exec 'normal ' . &scroll . 'k'<CR>

"" Plugins

call plug#begin()

"" Navigation and search

Plug 'rf-/vim-bclose'
Plug 'scrooloose/nerdtree'

"" Languages

Plug 'elixir-lang/vim-elixir'
Plug 'slashmili/alchemist.vim'
Plug 'guns/vim-clojure-static'
Plug 'kchmck/vim-coffee-script'
Plug 'mxw/vim-jsx'
Plug 'noprompt/vim-yardoc'
Plug 'pangloss/vim-javascript'
Plug 'slim-template/vim-slim'
Plug 'tpope/vim-git'
Plug 'tpope/vim-haml'
Plug 'tpope/vim-markdown'
Plug 'vim-ruby/vim-ruby'
Plug 'derekwyatt/vim-scala'
Plug 'solarnz/thrift.vim'
Plug 'rust-lang/rust.vim'
Plug 'rhysd/vim-crystal'
Plug 'leafgarland/typescript-vim'
Plug 'reasonml/vim-reason-loader'
Plug 'zah/nim.vim'
Plug 'dleonard0/pony-vim-syntax'

"" Text objects

Plug 'kana/vim-textobj-user'
Plug 'glts/vim-textobj-comment'
Plug 'nelstrom/vim-textobj-rubyblock'

"" Misc.

Plug 'AndrewRadev/splitjoin.vim'
Plug 'SirVer/ultisnips'
Plug 'airblade/vim-gitgutter'
Plug 'godlygeek/tabular'
Plug 'kovisoft/paredit'
Plug 'mattn/calendar-vim'
Plug 'scrooloose/nerdcommenter'
Plug 'simnalamburt/vim-mundo'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'vimwiki/vimwiki'

"" Platform-specific

if has("nvim")
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }
  Plug 'junegunn/fzf.vim'
  Plug 'ludovicchabant/vim-gutentags'
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'zchee/deoplete-go', { 'do': 'make' }
  Plug 'sebastianmarkow/deoplete-rust'
  Plug 'w0rp/ale'
  Plug 'fatih/vim-go'
else
  Plug 'ConradIrwin/vim-bracketed-paste'
  Plug 'epmatsw/ag.vim'
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

" mundo
nnoremap <Leader>u :MundoToggle<CR>
let g:mundo_right = 1
let g:mundo_help = 0

" nerdcommenter
map <Leader>/ <plug>NERDCommenterToggle<CR>

" nerdtree
let g:NERDTreeHijackNetrw = '0'
map <Leader>n :NERDTreeToggle<CR>
map <Leader>N :NERDTree<CR>
nmap - :NERDTreeFind<CR>

" paredit
let g:paredit_leader = '\'

" rust.vim
let g:rustfmt_autosave = 1

" splitjoin.vim
nmap <Leader>j :SplitjoinJoin<cr>
nmap <Leader>s :SplitjoinSplit<cr>

" ultisnips
let g:UltiSnipsExpandTrigger='<C-e>'

" vim-bclose
nnoremap <Leader>bc :Bclose<CR>
nnoremap <Leader>BC :Bclose!<CR>

" vim-fugitive
nmap <Leader>gs :Gstatus<CR>
nmap <Leader>gc :Gcommit<CR>

" vim-gitgutter
nmap ]g :GitGutterNextHunk<CR>
nmap [g :GitGutterPrevHunk<CR>

" vim-jsx
let g:jsx_ext_required = 0

" vimwiki
let wiki = {}
let wiki.path = '~/.vim/wiki'
let wiki.auto_tags = 1
let wiki.syntax = 'markdown'
let wiki.ext = '.md'
let wiki.diary_rel_path = '.'
let wiki.index = 'Home'
let g:vimwiki_list = [wiki]
let g:vimwiki_hl_cb_checked = 1
let g:vimwiki_folding = 'expr'
let g:vimwiki_map_prefix = '<Leader><Leader>'
nnoremap <Leader><Leader>c :Calendar<CR>

"" File Types

" Thorfile, Rakefile, Vagrantfile and Gemfile are Ruby
autocmd BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,config.ru}
  \ set filetype=ruby

" Wrapping for text files
autocmd BufRead,BufNewFile *.txt setlocal wrap wrapmargin=2 textwidth=72

" Override stupid l option (TODO: figure out where it's coming from)
autocmd BufRead,BufNewFile * setlocal formatoptions-=l

" Remove unimpaired.vim mappings that interfere with =
autocmd FileType vimwiki silent! nunmap =p
autocmd FileType vimwiki silent! nunmap =P

" Default to open folds for note files
autocmd FileType vimwiki set foldlevel=2

" Turn on text wrapping in note files
autocmd FileType vimwiki setlocal formatoptions+=t

" Add custom mappings for note files
autocmd FileType vimwiki inoremap <buffer> <C-h> <Esc>hhmz<<`za
autocmd FileType vimwiki inoremap <buffer> <C-l> <Esc>llmz>>`za

" Include ? and ! in "words" in Ruby, so that tags work correctly with bang and
" question mark methods
autocmd FileType ruby setlocal iskeyword+=!,?

autocmd FileType coffee setlocal shiftwidth=2 softtabstop=2
autocmd FileType css setlocal shiftwidth=2 softtabstop=2
autocmd FileType go setlocal noexpandtab tabstop=4 shiftwidth=4
autocmd FileType haxe setlocal tabstop=4 shiftwidth=4 softtabstop=4
autocmd FileType javascript setlocal shiftwidth=2 softtabstop=2
autocmd FileType make setlocal noexpandtab
autocmd FileType python setlocal shiftwidth=4 softtabstop=4 textwidth=79
autocmd FileType scala setlocal colorcolumn=100
autocmd FileType scss setlocal shiftwidth=2 softtabstop=2
autocmd FileType jsx setlocal filetype=javascript
autocmd FileType vimwiki setlocal tw=0 wrap linebreak

" Fix highlighting of Rust doc comments
highlight link rustCommentLineDoc Comment

" Load implementation-specific config
let g:vimfiles_dir = fnamemodify(resolve(expand('<sfile>:p')), ':h')
if has("nvim")
  exec "source " . g:vimfiles_dir . "/vimrc-neo"
else
  exec "source " . g:vimfiles_dir . "/vimrc-paleo"
end
