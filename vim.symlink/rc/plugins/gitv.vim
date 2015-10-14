" a gitk clone
NeoBundleLazy "gregsexton/gitv", {"depends":["tpope/vim-fugitive"], "autoload":{"commands":"Gitv"}}

nnoremap <silent> <leader>gv :Gitv<cr>
nnoremap <silent> <leader>gV :Gitv!<cr>
