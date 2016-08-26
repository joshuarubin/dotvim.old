" text filtering and alignment
NeoBundleLazy "godlygeek/tabular", {"autoload":{"commands":"Tabularize"}}

nnoremap <leader>a&     :Tabularize /&<cr>
vnoremap <leader>a&     :Tabularize /&<cr>

nnoremap <leader>a=     :Tabularize /=<cr>
vnoremap <leader>a=     :Tabularize /=<cr>

nnoremap <leader>a:     :Tabularize /:<cr>
vnoremap <leader>a:     :Tabularize /:<cr>

nnoremap <leader>a::    :Tabularize /:\zs<cr>
vnoremap <leader>a::    :Tabularize /:\zs<cr>

nnoremap <leader>a,     :Tabularize /,<cr>
vnoremap <leader>a,     :Tabularize /,<cr>

nnoremap <leader>a,,    :Tabularize /,\zs<cr>
vnoremap <leader>a,,    :Tabularize /,\zs<cr>

nnoremap <leader>a<bar> :Tabularize /<bar><cr>
vnoremap <leader>a<bar> :Tabularize /<bar><cr>

nnoremap <leader>a\|    :Tabularize /\|<cr>
vnoremap <leader>a\|    :Tabularize /\|<cr>

nnoremap <leader>a#     :Tabularize /#<cr>
vnoremap <leader>a#     :Tabularize /#<cr>
