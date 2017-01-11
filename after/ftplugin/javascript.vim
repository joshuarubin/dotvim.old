let b:auto_strip_trailing_whitespace = 1
setlocal shiftwidth=2 tabstop=2 softtabstop=2

" enable omni completion
setlocal omnifunc=javascriptcomplete#CompleteJS

" prettier
if executable("prettier")
  autocmd BufWritePre <buffer> call rubix#prettier()
endif
