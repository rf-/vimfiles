let g:vimfiles_dir = fnamemodify(resolve(expand('<sfile>:p')), ':h')

set ambiwidth=single

" The basics
set number
set ruler
set hidden
set colorcolumn=80
set showcmd
set noshowmode
syntax on

" Choose theme depending on system dark mode
if trim(system('defaults read -g AppleInterfaceStyle')) == 'Dark'
  set background=dark
else
  set background=light
endif
color miami

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
"set winheight=10 " Disabled until I figure out how to turn it off in floats

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

" Map <C-w><C-p> to close preview window, since <C-w><C-z> is very awkward
nnoremap <C-w><C-p> :pclose!<CR>

" Map <Leader>3 or <Leader># to go to alternate file
nnoremap <Leader># :e#<CR>
nnoremap <Leader>3 :e#<CR>

" When there's wrapping, show whatever instead of not showing incomplete lines
set display+=lastline

" Allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Don't try to complete included files
set complete-=i

" Don't show completion messages in status line
set shortmess+=c

" Show matching brackets (but not for very long)
set showmatch
set matchtime=1

" Remember last location in file
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
  \| exe "normal g'\"" | endif

" Complete longest common string first, then open menu
set wildmode=longest:full

" Never automatically select or insert autocomplete match
set completeopt=menu,menuone,preview,noinsert,noselect

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
nnoremap <silent> <C-d> :exec 'normal ' . &scroll . 'j'<CR>
nnoremap <silent> <C-u> :exec 'normal ' . &scroll . 'k'<CR>

" Add visual mappings to paste from "0, which isn't replaced when deleting text
vnoremap <Leader>p "0p
vnoremap <Leader>P "0P

" Use custom paths for Python in Neovim if present
if !empty($NEOVIM_PYTHON2_PATH)
  let g:python_host_prog = $NEOVIM_PYTHON2_PATH
endif
if !empty($NEOVIM_PYTHON3_PATH)
  let g:python3_host_prog = $NEOVIM_PYTHON3_PATH
endif

"" Plugins

call plug#begin()

"" Navigation and search

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }
Plug 'junegunn/fzf.vim'
Plug 'ludovicchabant/vim-gutentags'
Plug 'rf-/vim-bclose'
Plug 'scrooloose/nerdtree'

"" Languages

Plug 'sheerun/vim-polyglot'
Plug 'slashmili/alchemist.vim'
Plug 'galooshi/vim-import-js'

"" Text objects

Plug 'kana/vim-textobj-user'
Plug 'glts/vim-textobj-comment'
Plug 'nelstrom/vim-textobj-rubyblock'

"" Misc.

Plug 'AndrewRadev/splitjoin.vim'
Plug 'airblade/vim-gitgutter'
Plug 'godlygeek/tabular'
Plug 'kovisoft/paredit'
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

"" Platform-specific

if has("nvim")
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'Shougo/echodoc.vim'
  Plug 'dense-analysis/ale'
  Plug 'neovim/nvim-lsp'
else
  Plug 'ConradIrwin/vim-bracketed-paste'
end

" vim-import-js -- configure above plug#end to avoid double mappings
autocmd FileType javascript,typescript,typescriptreact nnoremap <buffer> <silent> <Leader>ii :ImportJSWord<CR>
autocmd FileType javascript,typescript,typescriptreact nnoremap <buffer> <silent> <Leader>if :ImportJSFix<CR>
autocmd FileType javascript,typescript,typescriptreact nnoremap <buffer> <silent> <Leader>ig :ImportJSGoto<CR>

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

" vim-bclose
nnoremap <Leader>bc :Bclose<CR>
nnoremap <Leader>BC :Bclose!<CR>

" vim-fugitive
nmap <Leader>gs :Gstatus<CR>
nmap <Leader>gc :Gcommit<CR>

" vim-gitgutter
nmap ]g :GitGutterNextHunk<CR>
nmap [g :GitGutterPrevHunk<CR>

" vim-javascript
let g:javascript_plugin_flow = 1

" vim-jsx
let g:jsx_ext_required = 0

" fzf.vim
let g:fzf_command_prefix = 'Fzf'
let g:fzf_nvim_statusline = 0
let g:fzf_layout = { 'down': '~20' }
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit',
  \ 'ctrl-e': 'pedit'
  \ }

nnoremap <C-e> :pclose<CR>

autocmd! FileType fzf
autocmd FileType fzf set laststatus=0 | autocmd BufLeave <buffer> set laststatus=2

function! s:fzf_set_color_options()
  if !exists('g:fzf_color_map')
    return
  endif
  let $FZF_DEFAULT_OPTS = '--color=' .
    \ join(values(map(copy(g:fzf_color_map), 'v:key . ":" . v:val')), ',')
endfunction

autocmd ColorScheme * call s:fzf_set_color_options()
call s:fzf_set_color_options()

nnoremap <silent> <Leader>t :FzfBuffers<CR>
nnoremap <silent> <Leader>T :call custom_fzf_funcs#files()<CR>

nnoremap <silent> <Leader>l :FzfBLines<CR>

nnoremap <silent> <C-]> :call search("\\k")<CR>"zyiw:call custom_fzf_funcs#tags(@z, '1')<CR>
vnoremap <silent> <C-]> "zy:call custom_fzf_funcs#tags(@z, '1')<CR>
nnoremap <silent> g<C-]> :call search("\\k")<CR>"zyiw:call custom_fzf_funcs#tags(@z, '0')<CR>
vnoremap <silent> g<C-]> "zy:call custom_fzf_funcs#tags(@z, '0')<CR>

" Load and bind custom FZF functions
exec "source " . g:vimfiles_dir . "/lib/custom_fzf_funcs.vim"

command! -bang -nargs=* -complete=dir Ag call custom_fzf_funcs#ag(<q-args>)

nnoremap <silent> <Leader>a "zyiw:exe "Ag ".@z.""<CR>
nnoremap <Leader>f :Ag<Space>
nnoremap <silent> <Leader>p :call custom_fzf_funcs#paste()<CR>

" gutentags
let g:gutentags_define_advanced_commands = 1
let g:gutentags_project_info = []
call add(g:gutentags_project_info, { "type": "crystal", "file": "shard.yml" })
" See https://gist.github.com/rf-/2b74152aae77a147a0dd1b7f102ea2ee
let g:gutentags_ctags_executable_crystal = "crystal-tags"

"" File Types

" Thorfile, Rakefile, Vagrantfile and Gemfile are Ruby
autocmd BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,config.ru}
  \ set filetype=ruby

" Wrapping for text files
autocmd BufRead,BufNewFile *.txt setlocal wrap wrapmargin=2 textwidth=72

" Override stupid l option (TODO: figure out where it's coming from)
autocmd BufRead,BufNewFile * setlocal formatoptions-=l

" Include ? and ! in "words" in Ruby, so that tags work correctly with bang and
" question mark methods
autocmd FileType ruby setlocal iskeyword+=!,?

autocmd FileType coffee setlocal shiftwidth=2 softtabstop=2
autocmd FileType css setlocal shiftwidth=2 softtabstop=2
autocmd FileType go setlocal noexpandtab tabstop=4 shiftwidth=4
autocmd FileType haxe setlocal tabstop=4 shiftwidth=4 softtabstop=4
autocmd FileType javascript,typescript,typescriptreact setlocal shiftwidth=2 softtabstop=2
autocmd FileType make setlocal noexpandtab
autocmd FileType python setlocal shiftwidth=4 softtabstop=4 textwidth=79
autocmd FileType scala setlocal colorcolumn=100
autocmd FileType scss setlocal shiftwidth=2 softtabstop=2
autocmd FileType jsx setlocal filetype=javascript

" Fix highlighting of Rust doc comments
highlight link rustCommentLineDoc Comment

" Disable awful default mappings for SQL
let g:omni_sql_no_default_maps = 1

" Load implementation-specific config
if has("nvim")
  exec "source " . g:vimfiles_dir . "/vimrc-neo"
else
  exec "source " . g:vimfiles_dir . "/vimrc-paleo"
end

" Load per-project rc file if applicable
exec "source " . g:vimfiles_dir . "/lib/per_project_rc_file.vim"
call per_project_rc_file#load()
