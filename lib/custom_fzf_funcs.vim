function! s:notes_handler(lines)
  let query = a:lines[0]
  let key   = a:lines[1]
  let lines = len(a:lines) > 2 ? a:lines[2:] : [query]

  let filenames = map(lines,
    \ 'substitute(g:notes_dir . v:val . ".otl", " ", "\\\\ ", "g")')

  exec get(g:fzf_action, key, '')
  exec 'args ' . join(filenames, ' ')
endfunction

function! custom_fzf_funcs#notes()
  let dir_len = strlen(g:notes_dir)
  let filenames = split(glob(g:notes_dir . '**/*.otl'), '\n')
  let notes = map(filenames,
    \ 'strpart(v:val, ' . dir_len . ', strlen(v:val) - ' . dir_len . ' - 4)')

  call fzf#run({
  \ 'source':  notes,
  \ 'sink*':   function('s:notes_handler'),
  \ 'options': '--multi --prompt "Notes> " --print-query ' .
  \            '--bind ctrl-a:select-all,ctrl-d:deselect-all ' .
  \            '--expect=' . join(keys(g:fzf_action), ','),
  \ 'down':    '~10',
  \})
endfunction

function! s:ag_to_qf(line)
  let parts = split(a:line, ':')
  return {'filename': parts[0], 'lnum': parts[1], 'col': parts[2],
        \ 'text': join(parts[3:], ':')}
endfunction

function! s:ag_handler(lines)
  if len(a:lines) < 2
    return
  endif

  let cmd = get(g:fzf_action, a:lines[0], 'e')
  let list = map(a:lines[1:], 's:ag_to_qf(v:val)')

  let first = list[0]
  execute cmd escape(first.filename, ' %#''"\')
  execute first.lnum
  execute 'normal!' first.col.'|zz'

  if len(list) > 1
    call setqflist(list)
    copen
    wincmd J
    10 wincmd _
    wincmd p
  endif
endfunction

function! custom_fzf_funcs#ag(query)
  call fzf#run({
  \ 'source':  printf('ag --nogroup --column --color %s', a:query),
  \ 'sink*':   function('s:ag_handler'),
  \ 'options': '--ansi --delimiter : --nth 4..,.. --prompt "Ag> " ' .
  \            '--multi --bind ctrl-a:select-all,ctrl-d:deselect-all ' .
  \            '--expect=' . join(keys(g:fzf_action), ','),
  \ 'down':    '~20'
  \})
endfunction

function! s:get_registers()
  function! s:get_registers_inner()
    redir => output
    registers
    redir END
    return output
  endfunction

  silent let registers_output = s:get_registers_inner()
  let register_list = split(registers_output, "\n")[1:]
  let register_list = map(register_list, 'v:val[1:]')
  let uniq_register_list = []
  let seen_register_contents = {}

  for line in register_list
    if !get(seen_register_contents, line[1:], 0)
      let seen_register_contents[line[1:]] = 1
      call add(uniq_register_list, line)
    end
  endfor

  return uniq_register_list
endfunction

function! s:paste_handler(line)
  let register = a:line[0]
  exec 'normal "' . register . 'p'
endfunction

function! custom_fzf_funcs#paste()
  let registers = s:get_registers()

  call fzf#run({
  \ 'source':  s:get_registers(),
  \ 'sink':    function('s:paste_handler'),
  \ 'options': '--ansi --prompt "Paste> " ',
  \ 'down':    '~20'
  \})
endfunction
