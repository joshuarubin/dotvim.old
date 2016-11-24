" search for terms using [Dash.app](http://kapeli.com/), making API lookups simple
Plug 'rizzatti/funcoo.vim' | Plug 'rizzatti/dash.vim'

" must be recursive
nmap <silent> <leader>d <plug>DashSearch
autocmd MyAutoCmd FileType python nmap <buffer> K <plug>DashSearch
