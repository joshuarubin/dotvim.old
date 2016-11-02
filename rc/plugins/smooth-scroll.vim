" make scrolling more pleasant
" NeoBundle "terryma/vim-smooth-scroll"
"
" noremap <silent> <c-u> :call smooth_scroll#up(  &scroll, 4, 1)<cr>
" noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 4, 1)<cr>

inoremap <c-d> <s-down>
inoremap <c-u> <s-up>

inoremap <c-e> <c-x><c-e>
inoremap <c-y> <c-x><c-y>
