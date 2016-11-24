let g:rubix_jedi = 0
if has('python')
  " require python support
  let g:rubix_jedi = 1
endif

" awesome python autocompletion
Plug 'davidhalter/jedi-vim', { 'for': 'python' }

if !g:rubix_jedi
  finish
endif

let g:jedi#popup_on_dot           = 0
let g:jedi#use_splits_not_buffers = "bottom"
let g:jedi#completions_enabled    = 0

let g:jedi#goto_command             = "gd"        " change from <leader>d
let g:jedi#usages_command           = ""          " don't collide with <leader>n :nohlsearch
let g:jedi#rename_command           = "<leader>e" " change from <leader>r to not collide with :PymodeRun
let g:jedi#documentation_command    = ""          " use dash instead (for <leader>d and K)
let g:jedi#goto_assignments_command = "<leader>g" " default
" let g:jedi#goto_definitions_command = ""

" autocmd MyAutoCmd FileType python nmap <buffer> <leader>d K
