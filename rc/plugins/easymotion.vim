" vim motions on speed!
NeoBundle "Lokaltog/vim-easymotion"

let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1
let g:EasyMotion_startofline = 0
let g:EasyMotion_move_highlight = 0

highlight link EasyMotionTarget WarningMsg
highlight link EasyMotionShade  Comment

map f <plug>(easymotion-f)
map t <plug>(easymotion-t)
map F <plug>(easymotion-F)
map T <plug>(easymotion-T)
"map s <Plug>(easymotion-s)
"map / <Plug>(easymotion-sn)
"omap / <Plug>(easymotion-tn)
map <leader>l <Plug>(easymotion-lineforward)
map <leader>j <plug>(easymotion-j)
map <leader>k <plug>(easymotion-k)
map <leader>h <Plug>(easymotion-linebackward)
