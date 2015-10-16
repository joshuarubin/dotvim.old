" neocomplete + neosnippet + neosnippet-snippets requires lua
" youcompleteme + ultisnips is the fallback without lua
if !has("lua")
  finish
endif

NeoBundleLazy "Shougo/neocomplete.vim", {"autoload":{"insert":1}, "vim_version":'7.3.885'}  " next generation completion framework
NeoBundle "Shougo/neosnippet"
NeoBundle "Shougo/neosnippet-snippets"
NeoBundle "Shougo/echodoc"

let g:echodoc_enable_at_startup = 1
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#enable_auto_delimiter = 1
let g:neocomplete#data_directory=GetCacheDir("neocomplete")

let g:neosnippet#data_directory = GetCacheDir("neosnippet")
let g:neosnippet#snippets_directory = "~/.vim/bundle/vim-snippets/snippets,~/.vim/snippets," . globpath(&rtp, "gosnippets/snippets")
let g:neosnippet#enable_snipmate_compatibility = 1
let g:go_snippet_engine = "neosnippet"

if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif

let g:neocomplete#keyword_patterns['default'] = '\h\w*'

imap <c-k> <plug>(neosnippet_expand_or_jump)
smap <c-k> <plug>(neosnippet_expand_or_jump)
xmap <c-k> <plug>(neosnippet_expand_target)

smap <expr> <tab> neosnippet#expandable_or_jumpable() ? "\<plug>(neosnippet_expand_or_jump)" : "\<tab>"

imap <expr> <tab> pumvisible() ? "\<c-n>" : (neosnippet#expandable_or_jumpable() ? "\<plug>(neosnippet_expand_or_jump)" : "\<tab>")
imap <expr> <s-tab> pumvisible() ? "\<c-p>" : "\<tab>"

imap <expr> <c-g> neocomplete#undo_completion()
imap <expr> <c-l> neocomplete#complete_common_string()

function! s:cleverCr()
  return pumvisible() ? "\<c-y>" : "\<cr>"
endfunction

imap <silent> <cr> <c-r>=<sid>cleverCr()<cr>
imap <expr> <s-cr> pumvisible() ? neocomplete#smart_close_popup() . "\<cr>" : "\<cr>"

imap <expr> <bs> neocomplete#smart_close_popup() . "\<c-h>"

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
autocmd MyAutoCmd FileType ruby setlo:cal omnifunc=rubycomplete#Complete
