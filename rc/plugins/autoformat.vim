" automatically format code
" NeoBundle "Chiel92/vim-autoformat"
"
" function! RunAutoFormat() "{{{
"   if exists('b:runAutoFormat')
"     :Autoformat
"   endif
" endfunction "}}}
"
" autocmd MyAutoCmd BufWritePre * call RunAutoFormat()
" autocmd MyAutoCmd FileType javascript,typescript,python,json,ruby,css,scss,cs,cpp,c,objc,java let b:runAutoFormat = 1
