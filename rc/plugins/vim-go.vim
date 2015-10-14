if $GOPATH != ""
  NeoBundle "fatih/vim-go" " full featured go development environment support for vim

  let g:go_def_mapping_enabled = 0
  let g:go_fmt_command = "goimports"
  let g:go_fmt_fail_silently = 1
  " let g:go_auto_type_info = 1
  " let g:go_dispatch_enabled = 1

  autocmd MyAutoCmd FileType go nmap <buffer> <leader>d <plug>(go-doc)
  autocmd MyAutoCmd FileType go nmap <buffer> <leader>r <plug>(go-run)
  autocmd MyAutoCmd FileType go nmap <buffer> <leader>b <plug>(go-build)
  autocmd MyAutoCmd FileType go nmap <buffer> <leader>t <plug>(go-test)
  autocmd MyAutoCmd FileType go nmap <buffer> <leader>e <plug>(go-rename)
  " autocmd MyAutoCmd FileType go nmap <buffer> <leader>ds <plug>(go-def-split)
  " autocmd MyAutoCmd FileType go nmap <buffer> <leader>dv <plug>(go-def-vertical)
  " autocmd MyAutoCmd FileType go nmap <buffer> <leader>dt <plug>(go-def-tab)
  autocmd MyAutoCmd FileType go nmap <buffer> gd <plug>(go-def-split)
endif
