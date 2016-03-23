" disable if python support not present
if !has("python") && !has("python3")
  finish
endif

" helps you to create python code very quickly
NeoBundleLazy "klen/python-mode", {"autoload":{"filetypes":["python"]}}

let g:pymode_folding = 0
let g:pymode_lint = 0
let g:pymode_options = 0
let g:pymode_rope = 0 " disable to fix conflict with jedi
let g:pymode_doc_bind = "" " disable, use jedi instead
