" add a ruler to markdown files
" setlocal colorcolumn=81
setlocal shiftwidth=4 tabstop=4 softtabstop=4 textwidth=0 spell

" enable omni completion
setlocal omnifunc=htmlcomplete#CompleteTags

" textobj-quote
call textobj#quote#init()

" textobj-sentence
call textobj#sentence#init()
