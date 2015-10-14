" text filtering and alignment
NeoBundleLazy "godlygeek/tabular", {"autoload":{"commands":"Tabularize"}}

nmap <leader>a&     :Tabularize /&<cr>
vmap <leader>a&     :Tabularize /&<cr>

nmap <leader>a=     :Tabularize /=<cr>
vmap <leader>a=     :Tabularize /=<cr>

nmap <leader>a:     :Tabularize /:<cr>
vmap <leader>a:     :Tabularize /:<cr>

nmap <leader>a::    :Tabularize /:\zs<cr>
vmap <leader>a::    :Tabularize /:\zs<cr>

nmap <leader>a,     :Tabularize /,<cr>
vmap <leader>a,     :Tabularize /,<cr>

nmap <leader>a,,    :Tabularize /,\zs<cr>
vmap <leader>a,,    :Tabularize /,\zs<cr>

nmap <leader>a<bar> :Tabularize /<bar><cr>
vmap <leader>a<bar> :Tabularize /<bar><cr>

nmap <leader>a\|    :Tabularize /\|<cr>
vmap <leader>a\|    :Tabularize /\|<cr>

nmap <leader>a#     :Tabularize /#<cr>
vmap <leader>a#     :Tabularize /#<cr>
