function! per_project_rc_file#load()
  let whitelist_file = g:vimfiles_dir . "/per-project-rc-whitelist"

  if filereadable(whitelist_file)
    let whitelist = readfile(whitelist_file)
    call map(whitelist, "substitute(v:val, '[ \n\r\t]', '', 'g')")
    call filter(whitelist, "len(v:val > 0)")

    let pwd = getcwd()
    let fname = expand("%:p")

    for whitelisted_dir in whitelist
      if whitelisted_dir == pwd[0 : (len(whitelisted_dir) - 1)]
            \ || whitelisted_dir == fname[0 : (len(whitelisted_dir) - 1)]
        let rcfile = whitelisted_dir . "/.vimrc"

        if filereadable(rcfile)
          exec "source " . rcfile
        endif
      endif
    endfor
  endif
endfunction
