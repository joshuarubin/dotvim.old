" lean & mean status/tabline for vim that's light as air, replaced Lokaltog/powerline
NeoBundle "bling/vim-airline"

let g:airline_theme = "apprentice"
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ":t"
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#buffer_nr_format = "%s "
