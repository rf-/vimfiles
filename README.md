This is based pretty heavily on [Janus](https://github.com/carlhuda/janus).

## Installation

 * [Compile and install MacVim](https://github.com/b4winckler/macvim/wiki/Building) with all the stuff in it.
 * Make this your .vim folder.
 * Symlink gvimrc and vimrc to the right places.

       ln -s ~/.vim/gvimrc ~/.gvimrc
       ln -s ~/.vim/vimrc ~/.vimrc

 * Install Ack.

       sudo cpan App::Ack

 * Install vundle.

       cd ~/.vim
       git submodule init
       git submodule update

 * Install bundles by running `:BundleInstall` in vim. This will generate a ton
   of errors. It's OK.

 * Install the native C part of Command-T.

       cd ~/.vim/bundle/Command-T/ruby/command-t
       /usr/bin/ruby extconf.rb
       make

 * Restart MacVim.

## Some stuff you can do

Note that in all of this, when I say 'window' I mean a frame inside the actual
MacVim window. I never use tabs, and I generally only open a new MacVim window
if I want to work in a different project/context.

### Tabs, splitting, and window management

You can have a bunch of files open at once, and a bunch of views open, and
switch among them independently.

Use :split to split the window horizontally and :vsplit to split it vertically.

Ctrl-tab switches which file is shown in the current window. Ctrl-<arrow key>
moves the cursor between your open windows.

When you have more than one file open, MiniBufExpl will pop open at the top to
show them and highlight the ones that are open. You can double-click on a file
up there to open it in the current window, or move the cursor up there and hit
enter on a file name, or just use ctrl-tab instead.

To close a window without closing the file, hit cmd-w. To close a file without
closing the window (much more common/desirable for me), hit cmd-shift-w.

Remember that you can drag borders with the mouse to resize windows.
Occasionally it'll get confused and make NERDTree huge or put things in weird
places, etc., but it's easy to fix by just closing most of the windows and
dragging the borders back to where they should be.

### NERDTree and other project management

Hit \n to bring up a tree view of your current directory. You can change
directories within NERDTree by hitting `C` (change NERDTree's root directory) or
`cd` (change vim's working directory). In general, you can use `:cd <directory>`
to do both.

Hit cmd-t to do TextMate-style fuzzy filename matching within the project, and
then enter to open the one you want from the list. `:CommandTFlush` resets the
index so you can find newly added files.

Alternately, you can open any file non-fuzzily by typing :e <filename>, or do
the same thing with your current location autofilled by typing \e. Here, as
everywhere, tab completion is a really good idea.

Hit cmd-shift-f to do TextMate-style regex search within the project (or just
type `:Ack`). This is a thin layer on top of the Ack command-line tool, so there
are some annoying things about it. One is that you have to quote your search
string if it has spaces in it. Another is that vim tries to do weird
substitution of # characters and so it's (almost?) impossible to search for a
literal #. Usually in that situation I'll just use normal Ack from the terminal.
It's often handy to use the -Q flag to search for a literal string, so I can
find things like 'foo(' without worrying about escaping the parenthesis.

### Snipmate

This is like TextMate's snippets. I don't consciously use it very often, but
it's kind of nice that you can just type 'def<Tab>' or whatever and get some
boilerplate filled in.

### Tab completion

It's not very smart, but you can just type tab in insert mode (not at the
beginning of a line) to get pretty decent autocomplete. It basically just looks
at all the words in all your open files, but that's good enough to save some
typing.

### Conque-Shell

Cmd-E opens a shell in your current directory.

### HexHighlight

I haven't assigned a shortcut for this, but it's useful sometimes. `:call
HexHighlight()` searches for hex color codes in the current file and makes them
look like blocks of the appropriate color.

### Gundo.vim

This is awesome. You can hit cmd-u to see a tree representation of the undo
history of the current file and revisit previous revisions. That means that it's
impossible to lose any work without closing the file. If you hit undo like fifty
times in a row and then accidentally make a change, you can just bring up gundo
and find the point you want to go back to.

For more details check out the [BitBucket repo](http://sjl.bitbucket.org/gundo.vim/).

### Align

I think there are better plugins I could get for this, but for now I'm using
this one. If you want to line some stuff up, highlight those lines (shift-v for
visual line mode, up or down arrow to expand) and then type `:Align <character
you want to line up by>`.

### Other key bindings

`Cmd-[` and `Cmd-]` shift indentation, just like TextMate.

`Cmd-/` toggles commentedness on your current line (or selected lines), which
might be like TextMate, I forget.

`Cmd-Enter` is full screen, like every other Mac program.

Typing `jj` in insert mode is the same as hitting escape, which some people
like, but I always forget to use it.

## Colors

I've modified most or all of the included color schemes, which is why they're in
colors/ and not bundled.

