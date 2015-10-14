" an extreme shell that doesn't depend on external shells but is written completely in pure vim script
NeoBundleLazy "Shougo/vimshell.vim", {"autoload":{"commands":[ "VimShell", "VimShellInteractive" ]}}

let g:vimshell_editor_command="vim"
let g:vimshell_right_prompt="getcwd()"
let g:vimshell_data_directory= GetCacheDir("vimshell")
let g:vimshell_vimshrc_path="~/.vim/vimshrc"

nnoremap <leader>c  :VimShell -split<cr>
nnoremap <leader>cc :VimShell -split<cr>
nnoremap <leader>cn :VimShellInteractive node<cr>
nnoremap <leader>cl :VimShellInteractive lua<cr>
nnoremap <leader>cr :VimShellInteractive irb<cr>
nnoremap <leader>cp :VimShellInteractive python<cr>
