finish " disabled in favor of gitgutter

" show a vcs diff using vim's sign column
NeoBundle "mhinz/vim-signify"

let g:signify_disable_by_default = 1
nnoremap <silent> <leader>gg :SignifyToggle<cr>
