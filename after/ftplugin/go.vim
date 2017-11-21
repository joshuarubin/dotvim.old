" use real tabs in .go files, not spaces
setlocal shiftwidth=4 tabstop=4 softtabstop=4 noexpandtab

command! -bang A call go#alternate#Switch(<bang>0, 'edit')
command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
command! -bang AS call go#alternate#Switch(<bang>0, 'split')
command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')

" vim-go
nmap <buffer> <leader>r <plug>(go-run)
nmap <buffer> <silent> <leader>b :call rubix#go#build()<cr>
nmap <buffer> <leader>t <plug>(go-test)
nmap <buffer> <leader>e <plug>(go-rename)
nmap <buffer> <leader>i <plug>(go-info)

" disable ale, enable neomake
let b:ale_enabled = 0
autocmd MyAutoCmd BufWritePost,BufReadPost,FileType <buffer> call rubix#neomake()
