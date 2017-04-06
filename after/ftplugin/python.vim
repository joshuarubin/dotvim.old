" setlocal foldmethod=indent
setlocal shiftwidth=4 tabstop=4 softtabstop=4

" dash
nmap <buffer> K <plug>DashSearch

" yapf
if executable('yapf')
  autocmd MyAutoCmd BufWritePre <buffer> call rubix#yapf()
else
  let b:auto_strip_trailing_whitespace = 1
endif
