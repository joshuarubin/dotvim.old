function! s:q1(str)
  return "'".substitute(a:str, "'", "'\\\\''", 'g')."'"
endfunction

let s:last = ["", ""]

" query, path, [[rg options], options]
function! rubix#fzf#rg(query, path, ...)
  let s:last = [a:query, a:path]
  let query = empty(a:query) ? '^(?=.)' : a:query
  let path = empty(a:path) ? rubix#current_dir() : a:path
  let args = copy(a:000)
  let rg_opts = len(args) > 1 ? remove(args, 0) : ''
  let command = rg_opts . ' ' . s:q1(query) . ' ' . s:q1(path)
  return call('rubix#fzf#rg_raw', insert(args, command))
endfunction

" query, path, [[ag options], options]
function! rubix#fzf#ag(query, path, ...)
  let s:last = [a:query, a:path]
  let query = empty(a:query) ? '^(?=.)' : a:query
  let path = empty(a:path) ? rubix#current_dir() : a:path
  let args = copy(a:000)
  let ag_opts = len(args) > 1 ? remove(args, 0) : ''
  let command = ag_opts . ' ' . s:q1(query) . ' ' . s:q1(path)
  return call('fzf#vim#ag_raw', insert(args, command))
endfunction

" rg command suffix, [options]
function! rubix#fzf#rg_raw(command_suffix, ...)
  return call('fzf#vim#grep', extend(['rg --no-heading --vimgrep --smart-case --follow '.a:command_suffix, 1], a:000))
endfunction

function! rubix#fzf#rg_repeat(...)
  return call('rubix#fzf#rg', extend(copy(s:last), copy(a:000)))
endfunction

function! rubix#fzf#ag_repeat(...)
  return call('rubix#fzf#ag', extend(copy(s:last), copy(a:000)))
endfunction
