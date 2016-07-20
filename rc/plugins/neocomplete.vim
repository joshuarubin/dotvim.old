" neocomplete + neosnippet + neosnippet-snippets requires lua
" youcompleteme + ultisnips is the fallback without lua
" nvim defaults to deoplete
if !has("lua") || has('nvim')
  finish
endif

NeoBundleLazy "Shougo/neocomplete.vim", {"autoload":{"insert":1}, "vim_version":'7.3.885'}  " next generation completion framework
NeoBundle "Shougo/neosnippet"
NeoBundle "Shougo/neosnippet-snippets"
NeoBundle "Shougo/echodoc"
NeoBundle "tpope/vim-endwise"

let g:endwise_no_mappings = 1
let g:echodoc_enable_at_startup = 1
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#enable_auto_delimiter = 1
let g:neocomplete#data_directory=GetCacheDir("neocomplete")
let g:neocomplete#auto_completion_start_length = 1

let g:neosnippet#data_directory = GetCacheDir("neosnippet")
let g:neosnippet#snippets_directory = join(globpath(&rtp, "snippets", 0, 1) + globpath(&rtp, "gosnippets/snippets", 0, 1), ",")
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

function! CleverCr()
  if !pumvisible()
    return "\<cr>\<Plug>DiscretionaryEnd"
  endif

  if neosnippet#expandable()
    return "\<plug>(neosnippet_expand_or_jump)"
  endif

  return "\<c-y>"
endfunction

imap <expr> <cr> CleverCr()
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
