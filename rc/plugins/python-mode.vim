" disable if python support not present
let g:rubix_python_mode = 0
if has('python') || has('python3')
  let g:rubix_python_mode = 1
endif

" helps you to create python code very quickly
Plug 'klen/python-mode', Cond(g:rubix_python_mode, { 'for': 'python' })

if !g:rubix_python_mode
  finish
endif

let g:pymode_folding  = 0
let g:pymode_lint     = 0
let g:pymode_options  = 0
let g:pymode_rope     = 0  " disable to fix conflict with jedi
let g:pymode_doc_bind = "" " disable, use jedi instead
