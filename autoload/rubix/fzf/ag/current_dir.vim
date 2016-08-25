function! rubix#fzf#ag#current_dir#cursor(...)
	return call('rubix#fzf#ag', extend([rubix#cursor_word(), rubix#current_dir()], a:000))
endfunction

function! rubix#fzf#ag#current_dir#prompt(...)
	return call('rubix#fzf#ag', extend([rubix#input_word(), rubix#current_dir()], a:000))
endfunction
