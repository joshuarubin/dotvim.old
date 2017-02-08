let s:cache_dir = '~/.vim/.cache/'

function! rubix#cache#dir(suffix) abort
  let l:dir = resolve(expand(s:cache_dir . a:suffix))

  if !isdirectory(expand(l:dir))
    call mkdir(expand(l:dir), 'p')
  endif

  return l:dir
endfunction
