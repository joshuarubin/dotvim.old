let b:auto_strip_trailing_whitespace = 1

" sort properties in css blocks with <leader>S
nnoremap <silent> <buffer> <leader>S vi{:sort<cr>

" enable omni completion
setlocal omnifunc=csscomplete#CompleteCSS
