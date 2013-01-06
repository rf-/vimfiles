color Tomorrow-Night-Eighties
set guifont=Pragmata:h13
set linespace=0
set antialias
set colorcolumn=80

set lines=60
set columns=115

" Don't break visual mode with the arrow keys
behave xterm

" No scrollbars or toolbar
set go=egm

" Fullscreen takes up entire screen
set fuoptions=maxhorz,maxvert

" TextMate-style indentation
nmap <D-[> <<
nmap <D-]> >>
vmap <D-[> <gv
vmap <D-]> >gv

" Command-Return for fullscreen
macmenu Window.Toggle\ Full\ Screen\ Mode key=<D-CR>

" Clear shortcuts
macmenu &File.New\ Tab key=<D-N>
macmenu &File.Open\ Tab\.\.\. key=<nop>
macmenu &File.Close\ Window key=<nop>
