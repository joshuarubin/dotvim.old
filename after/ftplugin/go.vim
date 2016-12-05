" use real tabs in .go files, not spaces
setlocal noexpandtab
setlocal shiftwidth=4 tabstop=4 softtabstop=4

command! -bang A call go#alternate#Switch(<bang>0, 'edit')
command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
command! -bang AS call go#alternate#Switch(<bang>0, 'split')
command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')
command! -nargs=* -complete=customlist,ge#complete#complete_package_id ZbDoc :execute rubix#go#doc(<f-args>)

" vim-go
nmap <buffer> <leader>r <plug>(go-run)
nmap <buffer> <leader>b :call rubix#go#build()<cr>
nmap <buffer> <leader>t <plug>(go-test)
nmap <buffer> <leader>e <plug>(go-rename)
nmap <buffer> gd <plug>(go-def-vertical)
nmap <buffer> <leader>i <plug>(go-info)
nmap <buffer> <silent> K :ZbDoc<cr>
