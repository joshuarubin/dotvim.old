" format javascript files with js-beautify
NeoBundleLazy "maksimr/vim-jsbeautify", {"autoload":{"filetypes":["javascript"]}}

nnoremap <leader>fjs :call JsBeautify()<cr>
