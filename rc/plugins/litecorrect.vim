finish " disabled

" lightweight auto-correction
NeoBundle "reedes/vim-litecorrect"

augroup litecorrect
  autocmd!
  autocmd FileType markdown,mkd call litecorrect#init()
  autocmd FileType textile      call litecorrect#init()
  autocmd FileType text         call litecorrect#init()
augroup END
