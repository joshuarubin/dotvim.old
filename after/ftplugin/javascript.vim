let b:auto_strip_trailing_whitespace = 1
setlocal shiftwidth=2 tabstop=2 softtabstop=2

" enable omni completion
setlocal omnifunc=javascriptcomplete#CompleteJS

" prettier
if executable("prettier")
  if !exists('s:bufs')
    let s:bufs = []
  endif

  if (index(s:bufs, bufnr('%')) == -1)
    call add(s:bufs, bufnr('%'))
    autocmd BufWritePre <buffer> call rubix#prettier()
  endif
endif
