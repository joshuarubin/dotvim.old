if $GOPATH == ""
  finish
endif

NeoBundle "fatih/vim-go" " full featured go development environment support for vim

let g:go_def_mapping_enabled = 0
let g:go_fmt_command = "goimports"
let g:go_fmt_fail_silently = 1
let g:go_fmt_options = "-s "
" let g:go_auto_sameids = 1
let g:go_auto_type_info = 0

let g:go_list_height = 10
" let g:go_def_mode = "guru"
let g:go_def_mode = "godef"
let g:go_def_reuse_buffer = 1

" let g:go_highlight_operators = 1
" let g:go_highlight_functions = 1
" let g:go_highlight_methods = 1
" let g:go_highlight_types = 1
" let g:go_highlight_fields = 1
" let g:go_highlight_build_constraints = 1
" let g:go_highlight_structs = 1
" let g:go_highlight_interfaces = 1

let g:go_highlight_structs = 0
let g:go_highlight_interfaces = 0
let g:go_highlight_operators = 0
let g:go_highlight_fields = 0
let g:go_highlight_types = 0
let g:go_highlight_functions = 0
let g:go_highlight_methods = 0
let g:go_highlight_build_constraints = 0

let g:go_highlight_array_whitespace_error = 0
let g:go_highlight_chan_whitespace_error = 0
let g:go_highlight_space_tab_error = 0
let g:go_highlight_trailing_whitespace_error = 0

" let g:go_term_mode = "vsplit"
let g:go_term_enabled = 1
" let g:go_dispatch_enabled = 1

let g:go_metalinter_enabled  = [
\   'vet',
\   'golint',
\   'gotype',
\   'vetshadow',
\   'ineffassign',
\   'deadcode',
\   'goconst',
\   'gocyclo',
\   'lll',
\   'dupl'
\ ]

" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#cmd#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

" maps must be recursive

" autocmd MyAutoCmd FileType go nmap <buffer> <leader>d <plug>(go-doc)
autocmd MyAutoCmd FileType go nmap <buffer> <leader>r <plug>(go-run)
autocmd MyAutoCmd FileType go nmap <buffer> <leader>b :<c-u>call <sid>build_go_files()<cr>
" autocmd MyAutoCmd FileType go nmap <buffer> <leader>b <plug>(go-build)
autocmd MyAutoCmd FileType go nmap <buffer> <leader>t <plug>(go-test)
autocmd MyAutoCmd FileType go nmap <buffer> <leader>e <plug>(go-rename)
" autocmd MyAutoCmd FileType go nmap <buffer> <leader>ds <plug>(go-def-split)
" autocmd MyAutoCmd FileType go nmap <buffer> <leader>dv <plug>(go-def-vertical)
" autocmd MyAutoCmd FileType go nmap <buffer> <leader>dt <plug>(go-def-tab)
autocmd MyAutoCmd FileType go nmap <buffer> gd <plug>(go-def-split)
autocmd MyAutoCmd FileType go nmap <buffer> <leader>i <plug>(go-info)

autocmd MyAutoCmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
autocmd MyAutoCmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
autocmd MyAutoCmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
autocmd MyAutoCmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')

if neobundle#tap("vim-go")
  function! neobundle#hooks.on_post_source(bundle)
    set updatetime=100
  endfunction
endif
