" disables the arrow keys, the hjkl keys, the page up/down keys, and a handful of other keys which allow one to rely on character-wise navigation
NeoBundle "wikitopian/hardmode"

"autocmd MyAutoCmd VimEnter,BufNewFile,BufReadPost * silent! call HardMode()
nnoremap <leader>o <Esc>:call ToggleHardMode()<CR>
