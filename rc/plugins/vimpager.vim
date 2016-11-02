" use vim as $PAGER
NeoBundle "rkitover/vimpager.git", {
  \ 'build' : {
    \   'others': 'sh -c "make && ln -s man man1"',
  \   }
  \ }

let g:vimpager = {}
let g:vimpager.passthrough = 0

nnoremap <silent> <leader>v :Page<cr>

autocmd MyAutoCmd FileType man :Page
