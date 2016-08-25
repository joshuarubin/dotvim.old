function! rubix#fzf#ag#project_dir#cursor(...)
	return call('rubix#fzf#ag', extend([rubix#cursor_word(), rubix#project_dir()], a:000))
endfunction

function! rubix#fzf#ag#project_dir#prompt(...)
	return call('rubix#fzf#ag', extend([rubix#input_word(), rubix#project_dir()], a:000))
endfunction
