function! rubix#fzf#files#project_dir(...)
  let args = copy(a:000)
  return call('fzf#vim#files', insert(args, rubix#project_dir()))
endfunction

function! rubix#fzf#files#buffer_dir(...)
  let args = copy(a:000)
  return call('fzf#vim#files', insert(args, rubix#buffer_dir()))
endfunction

function! rubix#fzf#files#current_dir(...)
  let args = copy(a:000)
  return call('fzf#vim#files', insert(args, rubix#current_dir()))
endfunction

function! rubix#fzf#files#input_dir(...)
  let args = copy(a:000)
  return call('fzf#vim#files', insert(args, rubix#input_dir()))
endfunction
