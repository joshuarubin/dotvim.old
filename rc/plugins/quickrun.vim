" run a command and show its result quickly
NeoBundle "thinca/vim-quickrun"

let g:quickrun_config = {}
let g:quickrun_config.markdown = {
  \ "outputter": "null",
  \ "command":   "open",
  \ "cmdopt":    "-a",
  \ "args":      shellescape("Marked 2"),
  \ "exec":      "%c %o %a %s",
  \ }

" space: QuickRun
" xnoremap <space> :QuickRun<cr>

" <leader>?: Quickly open the README.md
execute "nnoremap <silent> <leader>? :QuickRun -srcfile ~/.vim/README.md -type markdown<cr>"
