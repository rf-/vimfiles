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

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

" Tab completion and Command-T ignores
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.class,.svn,test/fixtures/*,vendor/gems/*,.idea

" Show the status bar
set laststatus=2

" Without setting this, ZoomWin restores windows in a way that causes
" equalalways behavior to be triggered the next time CommandT is used.
" This is likely a bludgeon to solve some other issue, but it works
set noequalalways

" Put modified buffers into the 'background' without vim complaining
set hidden

" Remember last location in file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
endif

" Don't use modelines because who cares
set modelines=0
set nomodeline

" Default color scheme for console vim
color desert

" Directories for swp files
set backupdir=~/.vim/backup
set directory=~/.vim/backup

" Turn off jslint errors by default
let g:JSLintHighlightErrorLine = 0

" MacVIM shift+arrow-keys behavior (required in .vimrc)
let macvim_hig_shift_movement = 1

" % to bounce from do to end etc.
runtime! macros/matchit.vim

" map 'jj' to leave insert mode
imap jj <Esc>

" Arrow keys scroll by visible lines, not absolute lines
nnoremap <Down> gj
nnoremap <Up> gk
vnoremap <Down> gj
vnoremap <Up> gk
inoremap <Down> <C-o>gj
inoremap <Up> <C-o>gk

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

" make uses real tabs
au FileType make set noexpandtab

" Thorfile, Rakefile, Vagrantfile and Gemfile are Ruby
au BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,config.ru} set ft=ruby

" md, markdown, and mk are markdown and define buffer-local preview
au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn} call s:setupMarkup()

au BufRead,BufNewFile *.txt call s:setupWrapping()

" make python follow PEP8 ( http://www.python.org/dev/peps/pep-0008/ )
au FileType python set tabstop=4 textwidth=79

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

filetype off

" Vundle + bundles
set rtp+=~/.vim/vundle.git/
call vundle#rc()

Bundle "https://github.com/vim-scripts/matchit.zip.git"
runtime macros/matchit.vim

Bundle "https://github.com/vim-scripts/minibufexpl.vim.git"
let g:miniBufExplMapCTabSwitchBufs = 1  " C-Tab to switch buffers in the current window (in insert mode too)
inoremap <C-TAB> <Esc><C-TAB>
inoremap <C-S-TAB> <Esc><C-S-TAB>
let g:miniBufExplMapWindowNavArrows = 1 " ctrl + arrow keys move from window to window
let g:miniBufExplModSelTarget = 1       " no idea what this does, but I put it in so I guess it's cool

" lots of NERDtree-specific stuff in gvimrc too
Bundle "https://github.com/vim-scripts/The-NERD-tree.git"
let NERDTreeIgnore=['\.rbc$', '\~$']
map <Leader>n :NERDTreeToggle<CR>

Bundle "https://github.com/juvenn/mustache.vim.git"
Bundle "https://github.com/vim-scripts/actionscript.vim--Leider.git"
Bundle "https://github.com/vim-scripts/Align.git"
Bundle "https://github.com/vim-scripts/hexHighlight.vim.git"
Bundle "https://github.com/msanders/snipmate.vim.git"
Bundle "https://github.com/ervandew/supertab.git"
Bundle "https://github.com/kchmck/vim-coffee-script.git"
Bundle "https://github.com/tpope/vim-fugitive.git"
Bundle "https://github.com/tpope/vim-git.git"
Bundle "https://github.com/tpope/vim-haml.git"
Bundle "https://github.com/vim-scripts/vim-indent-object.git"
Bundle "https://github.com/pangloss/vim-javascript.git"
Bundle "https://github.com/tpope/vim-rails.git"
Bundle "https://github.com/tpope/vim-repeat.git"
Bundle "https://github.com/tpope/vim-surround.git"
Bundle "https://github.com/nelstrom/vim-textobj-rubyblock.git"
Bundle "https://github.com/kana/vim-textobj-user.git"
Bundle "https://github.com/vim-scripts/ZoomWin.git"

" this isn't in gvimrc because I wanted to keep the config with the bundles
" and I think vundler only reads the vimrc file
if has("gui_macvim")
  Bundle "https://github.com/vim-scripts/ack.vim.git"
  map <D-F> :Ack<space>
  imap <D-F> <Esc>:Ack<space>

  Bundle "https://github.com/rwfitzge/vim-bclose.git"
  nmap <D-W> :Bclose<CR>
  imap <D-W> <Esc>:Bclose<CR>
  "nmap <C-D-W> :Bclose!<CR>
  "imap <C-D-W> <Esc>:Bclose!<CR>

  Bundle "https://github.com/vim-scripts/Command-T.git"
  map <D-t> :CommandT<CR>
  imap <D-t> <Esc>:CommandT<CR>
  let g:CommandTMaxHeight=20

  Bundle "https://github.com/vim-scripts/Conque-Shell.git"
  function StartTerm()
    execute 'ConqueTerm ' . $SHELL . ' --login'
    setlocal listchars=tab:\ \ 
  endfunction
  map <D-e> :call StartTerm()<CR>

  Bundle "https://github.com/rwfitzge/gundo.vim.git"
  nnoremap <D-u> :GundoToggle<CR>
  let g:gundo_right=1
  let g:gundo_help=0

  Bundle "https://github.com/vim-scripts/The-NERD-Commenter.git"
  map <D-/> <plug>NERDCommenterToggle<CR>
endif

filetype plugin indent on

