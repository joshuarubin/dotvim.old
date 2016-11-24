" neocomplete + neosnippet + neosnippet-snippets requires lua
" youcompleteme + ultisnips is the fallback without lua
" nvim defaults to deoplete

let g:rubix_neocomplete = 0
if has('lua') && !has('nvim') && (v:version > 703 || v:version == 703 && has('patch885'))
  let g:rubix_neocomplete = 1
endif

" next generation completion framework
Plug 'Shougo/neocomplete.vim', Cond(g:rubix_neocomplete)

if !g:rubix_neocomplete
  finish
endif

let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#enable_auto_delimiter = 1
let g:neocomplete#data_directory=GetCacheDir("neocomplete")
let g:neocomplete#auto_completion_start_length = 1

if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif

let g:neocomplete#keyword_patterns['default'] = '\h\w*'

imap <expr> <c-g> neocomplete#undo_completion()
imap <expr> <c-l> neocomplete#complete_common_string()

imap <expr> <s-cr> pumvisible() ? neocomplete#smart_close_popup() . "\<cr>" : "\<cr>"

" imap <expr> <bs> neocomplete#smart_close_popup() . "\<c-h>"

if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif

let g:neocomplete#sources#omni#input_patterns.php  = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
let g:neocomplete#sources#omni#input_patterns.c    = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplete#sources#omni#input_patterns.cpp  = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
let g:neocomplete#sources#omni#input_patterns.ruby = '[^. *\t]\.\h\w*\|\h\w*::'

" enable omni completion
autocmd MyAutoCmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd MyAutoCmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd MyAutoCmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd MyAutoCmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd MyAutoCmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd MyAutoCmd FileType ruby setlocal omnifunc=rubycomplete#Complete
