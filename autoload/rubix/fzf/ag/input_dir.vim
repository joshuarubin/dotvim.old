function! rubix#fzf#ag#input_dir#cursor(...)
	return call('rubix#fzf#ag', extend([rubix#cursor_word(), rubix#input_dir()], a:000))
endfunction

function! rubix#fzf#ag#input_dir#prompt(...)
	return call('rubix#fzf#ag', extend([rubix#input_word(), rubix#input_dir()], a:000))
endfunction
