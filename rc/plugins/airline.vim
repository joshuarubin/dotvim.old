finish " disabled in favor of lightline

" lean & mean status/tabline for vim that's light as air, replaced Lokaltog/powerline
NeoBundle "vim-airline/vim-airline"
NeoBundle "vim-airline/vim-airline-themes"

let g:airline_theme = "apprentice"
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#show_splits = 0
let g:airline#extensions#tabline#tab_nr_type = 1 " tab number
let g:airline#extensions#tabline#tab_min_count = 1
let g:airline#extensions#tabline#buffer_min_count = 1
let g:airline#extensions#tabline#fnamemod = ":t"
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#buffer_nr_format = "%s "
let g:airline#extensions#tabline#buffers_label = 'buffers %{strftime("%l:%M")}'
let g:airline#extensions#tabline#tabs_label = 'tabs %{strftime("%l:%M")}'
" let g:airline#extensions#default#section_truncate_width = {}
let g:airline#extensions#wordcount#enabled = 0

autocmd MyAutoCmd CursorMoved,CursorMovedI * let &ro = &ro

" let g:airline_left_sep = ''
" let g:airline_left_alt_sep = ''
" let g:airline_right_sep = ''
" let g:airline_right_alt_sep = ''

nnoremap <leader>1 <Plug>AirlineSelectTab1
nnoremap <leader>2 <Plug>AirlineSelectTab2
nnoremap <leader>3 <Plug>AirlineSelectTab3
nnoremap <leader>4 <Plug>AirlineSelectTab4
nnoremap <leader>5 <Plug>AirlineSelectTab5
nnoremap <leader>6 <Plug>AirlineSelectTab6
nnoremap <leader>7 <Plug>AirlineSelectTab7
nnoremap <leader>8 <Plug>AirlineSelectTab8
nnoremap <leader>9 <Plug>AirlineSelectTab9
nnoremap <leader>- <Plug>AirlineSelectPrevTab
nnoremap <leader>+ <Plug>AirlineSelectNextTab
