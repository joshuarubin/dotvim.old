if !has("python")
  " disable if python support not present
  finish
endif

" awesome python autocompletion
NeoBundleLazy "davidhalter/jedi-vim", {"autoload":{"filetypes":["python"]}}

let g:jedi#popup_on_dot = 0
let g:jedi#use_splits_not_buffers = "bottom"

let g:jedi#goto_command = "gd"
let g:jedi#usages_command = ""
let g:jedi#rename_command = "<leader>e"
let g:jedi#completions_enabled = 0

autocmd MyAutoCmd FileType python nmap <buffer> <leader>d K
