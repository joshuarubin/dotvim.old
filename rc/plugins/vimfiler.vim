" a powerful file explorer
NeoBundle "Shougo/vimfiler.vim", {"vim_version": "7.3"}

if v:version < 703
  finish
endif

map <c-n> :VimFilerExplorer -parent<cr>

let g:vimfiler_as_default_explorer = 1
let g:vimfiler_tree_leaf_icon = ' '
let g:vimfiler_tree_opened_icon = '▾'
let g:vimfiler_tree_closed_icon = '▸'
let g:vimfiler_marked_file_icon = '✓'
let g:vimfiler_data_directory = GetCacheDir("vimfiler")
let g:vimfiler_quick_look_command = "qlmanage -p"
let g:vimfiler_ignore_filters = ['matcher_ignore_pattern', 'matcher_ignore_wildignore']

" make enter expand the directory like NERDTree
autocmd MyAutoCmd FileType vimfiler nmap <silent><buffer><expr> <cr> vimfiler#smart_cursor_map(
  \ "\<Plug>(vimfiler_expand_tree)",
  \ "\<Plug>(vimfiler_edit_file)")

autocmd MyAutoCmd FileType vimfiler nmap <buffer> <c-r> <Plug>(vimfiler_redraw_screen)
autocmd MyAutoCmd FileType vimfiler nmap <buffer> <c-h> <Plug>(vimfiler_switch_to_history_directory)

if neobundle#tap("vimfiler.vim")
  function! neobundle#hooks.on_post_source(bundle)
    call vimfiler#custom#profile("default", "context", {
          \ "auto_cd" : 1,
          \ "safe": 0,
          \ })
  endfunction

  call neobundle#untap()
endif
