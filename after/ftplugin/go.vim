" use real tabs in .go files, not spaces
setlocal shiftwidth=4 tabstop=4 softtabstop=4 noexpandtab

command! -bang A call go#alternate#Switch(<bang>0, 'edit')
command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
command! -bang AS call go#alternate#Switch(<bang>0, 'split')
command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')
