let s:showtabline=&showtabline

function! rubix#goyo#enter() abort
  let s:showtabline=&showtabline
  set showtabline=0
endfunction

function! rubix#goyo#leave() abort
  let &showtabline=s:showtabline
endfunction
