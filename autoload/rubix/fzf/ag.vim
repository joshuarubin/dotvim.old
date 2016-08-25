function! rubix#fzf#ag#project_dir(query, ...)
	return call('rubix#fzf#ag', extend([a:query, rubix#project_dir()], a:000))
endfunction

function! rubix#fzf#ag#buffer_dir(query, ...)
	return call('rubix#fzf#ag', extend([a:query, rubix#buffer_dir()], a:000))
endfunction

function! rubix#fzf#ag#current_dir(query, ...)
  return call('rubix#fzf#ag', extend([a:query, rubix#current_dir()], a:000))
endfunction

function! rubix#fzf#ag#input_dir(query, ...)
  return call('rubix#fzf#ag', extend([a:query, rubix#input_dir()], a:000))
endfunction
