if !executable("yapf")
  finish
endif

function! yapf#YAPF()
  " preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")

  let l:cmd = 'yapf'

  " Call YAPF with the current buffer
  let l:formatted_text = system(l:cmd, join(getline(1, '$'), "\n") . "\n")

  if v:shell_error != 0 && v:shell_error != 2
    return
  endif

  " Update the buffer.
  execute '1,' . string(line('$')) . 'delete'
  call setline(1, split(l:formatted_text, "\n"))

  " clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction

autocmd MyAutoCmd FileType python autocmd BufWritePre <buffer> call yapf#YAPF()
