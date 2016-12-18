function! s:wiki_handler(lines)
  let query = a:lines[0]
  let key   = a:lines[1]
  let lines = len(a:lines) > 2 ? a:lines[2:] : [query]

  let filenames = map(lines,
    \ 'substitute(VimwikiGet("path") . v:val . ".md", " ", "\\\\ ", "g")')

  exec get(g:fzf_action, key, '')
  exec 'args ' . join(filenames, ' ')
endfunction

function! custom_fzf_funcs#wiki()
  let dir_len = strlen(VimwikiGet('path'))
  let filenames = vimwiki#base#find_files(0, 0)
  let pages = map(filenames,
    \ 'strpart(v:val, ' . dir_len . ', strlen(v:val) - ' . dir_len . ' - 3)')

  call fzf#run({
  \ 'source':  pages,
  \ 'sink*':   function('s:wiki_handler'),
  \ 'options': '--multi --prompt "Wiki> " --print-query ' .
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

function! s:tag_line_to_tag_obj(tag_line)
  let line = substitute(a:tag_line, "\\e[38;5;245m|\\e[0m", "", "g")
  let parts = split(line, "\t")
  return { 'kind': parts[0], 'cmd': parts[1], 'filename': parts[2] }
endfunction

function! s:tag_obj_to_tag_line(tag)
  let cmd = substitute(a:tag.cmd, "\t", "\\\\t", "g")
  let b = "\e[38;5;245m"
  let e = "\e[0m"
  return join([b.(a:tag.kind).e, cmd, b.(a:tag.filename).e], "\t")
endfunction

function! s:tag_obj_to_qf(tag)
  let pattern = a:tag.cmd[1:(len(a:tag.cmd) - 2)]
  return { 'filename': a:tag.filename, 'pattern': pattern, 'text': pattern }
endfunction

function! s:go_to_tag(cmd, tag)
  execute a:cmd escape(a:tag.filename, ' %#''"\')
  silent execute a:tag.cmd
endfunction

function! s:tag_handler(lines)
  if len(a:lines) < 2
    return
  endif

  let cmd = get(g:fzf_action, a:lines[0], 'e')
  let tags = map(a:lines[1:], 's:tag_line_to_tag_obj(v:val)')

  call s:go_to_tag(cmd, tags[0])

  if len(tags) > 1
    call setqflist(map(tags, 's:tag_obj_to_qf(v:val)'))
    copen
    wincmd J
    10 wincmd _
    wincmd p
  endif
endfunction

function! custom_fzf_funcs#tags(identifier, auto_jump)
  let tags = taglist("^" . a:identifier . "$")

  if len(tags) == 0
    " Show normal error message
    echohl WarningMsg | echo 'E426: tag not found: ' . a:identifier | echohl None
    return
  endif

  if len(tags) == 1 && a:auto_jump == '1'
    call s:go_to_tag('edit', tags[0])
    return
  endif

  call fzf#run({
  \ 'source':  map(tags, 's:tag_obj_to_tag_line(v:val)'),
  \ 'sink*':   function('s:tag_handler'),
  \ 'options': '--ansi --delimiter "\t" --prompt "Tag> " ' .
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
