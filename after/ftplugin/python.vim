" setlocal foldmethod=indent
setlocal shiftwidth=4 tabstop=4 softtabstop=4

" dash
nmap <buffer> K <plug>DashSearch

" enable omni completion
setlocal omnifunc=pythoncomplete#Complete

" yapf
if executable("yapf")
  autocmd BufWritePre <buffer> call rubix#yapf()
endif
