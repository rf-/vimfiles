set guifont=Source\ Code\ Pro:h12
set linespace=1
set antialias

set lines=60
set columns=100

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
