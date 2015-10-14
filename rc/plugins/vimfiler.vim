" a powerful file explorer
NeoBundle "Shougo/vimfiler.vim", {"vim_version": "7.3"}

if v:version < 703
  finish
endif

map <c-n> :VimFilerExplorer<cr>

let g:vimfiler_as_default_explorer = 1
let g:vimfiler_tree_leaf_icon = ' '
let g:vimfiler_tree_opened_icon = '▾'
let g:vimfiler_tree_closed_icon = '▸'
let g:vimfiler_marked_file_icon = '✓'
let g:my_vimfiler_explorer_name = 'explorer'
let g:my_vimfiler_winwidth = 60
let g:vimfiler_safe_mode_by_default = 0
let g:vimfiler_data_directory = GetCacheDir("vimfiler")
let g:vimfiler_quick_look_command = "qlmanage -p"

" make enter expand the directory like NERDTree
autocmd MyAutoCmd FileType vimfiler nmap <silent><buffer><expr> <CR> vimfiler#smart_cursor_map(
  \ "\<Plug>(vimfiler_expand_tree)",
  \ "\<Plug>(vimfiler_edit_file)")

autocmd MyAutoCmd FileType vimfiler nmap <buffer> <c-r> <Plug>(vimfiler_redraw_screen)
autocmd MyAutoCmd FileType vimfiler nmap <buffer> <c-h> <Plug>(vimfiler_switch_to_history_directory)

" nnoremap <expr><f2> g:MyOpenExplorerCommand()
" function! g:MyOpenExplorerCommand()  " {{{
"   return printf(":\<c-u>VimFilerBufferDir -buffer-name=%s -split -auto-cd -toggle -no-quit -winwidth=%s\<cr>",
"     \ g:my_vimfiler_explorer_name,
"     \ g:my_vimfiler_winwidth)
" endfunction
" " }}}
