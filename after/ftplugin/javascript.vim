let l:trim = 1
setlocal shiftwidth=2 tabstop=2 softtabstop=2

" enable omni completion
setlocal omnifunc=javascriptcomplete#CompleteJS

" prettier
if executable('prettier')
  if !exists('s:bufs')
    let s:bufs = []
  endif

  if (index(s:bufs, bufnr('%')) == -1)
    call add(s:bufs, bufnr('%'))
    autocmd MyAutoCmd BufWritePre <buffer> call rubix#prettier()
    let l:trim = 0
  endif
endif

if l:trim == 1
  let b:auto_strip_trailing_whitespace = 1
endif
