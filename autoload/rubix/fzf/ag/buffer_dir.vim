function! rubix#fzf#ag#buffer_dir#cursor(...)
	return call('rubix#fzf#ag', extend([rubix#cursor_word(), rubix#buffer_dir()], a:000))
endfunction

function! rubix#fzf#ag#buffer_dir#prompt(...)
	return call('rubix#fzf#ag', extend([rubix#input_word(), rubix#buffer_dir()], a:000))
endfunction
