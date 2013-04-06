color Tomorrow-Night
set guifont=Pragmata:h13
set linespace=0
set antialias

set lines=60
set columns=115

" Don't break visual mode with the arrow keys
behave xterm

" No scrollbars or toolbar
set go=egm

" Fullscreen takes up entire screen
set fuoptions=maxhorz,maxvert

" Command-Return for fullscreen
macmenu Window.Toggle\ Full\ Screen\ Mode key=<D-CR>

" Clear shortcuts
macmenu &File.New\ Tab key=<D-N>
macmenu &File.Open\ Tab\.\.\. key=<nop>
macmenu &File.Close\ Window key=<nop>

" Font size shortcuts
map <Leader>fs :set guifont=Pragmata:h13<CR>
map <Leader>fm :set guifont=Pragmata:h16<CR>
map <Leader>fl :set guifont=Pragmata:h18<CR>
