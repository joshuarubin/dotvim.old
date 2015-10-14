" make scrolling more pleasant
NeoBundle "terryma/vim-smooth-scroll"

noremap <silent> <c-y> :call smooth_scroll#up(&scroll, 5, 1)<cr>
noremap <silent> <c-e> :call smooth_scroll#down(&scroll, 5, 1)<cr>
