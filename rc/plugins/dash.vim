" search for terms using [Dash.app](http://kapeli.com/), making API lookups simple
NeoBundle "rizzatti/dash.vim", {"depends":"rizzatti/funcoo.vim"}

" must be recursive
nmap <silent> <leader>d <plug>DashSearch
autocmd MyAutoCmd FileType python nmap <buffer> K <plug>DashSearch
