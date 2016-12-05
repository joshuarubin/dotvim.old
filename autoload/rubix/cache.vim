let s:cache_dir = "~/.vim/.cache/"

function! rubix#cache#dir(suffix)
  let dir = resolve(expand(s:cache_dir . a:suffix))

  if !isdirectory(expand(dir))
    call mkdir(expand(dir), 'p')
  endif

  return dir
endfunction
