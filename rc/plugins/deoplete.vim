" neocomplete + neosnippet + neosnippet-snippets requires lua
" youcompleteme + ultisnips is the fallback without lua
" nvim defaults to deoplete
if !has('nvim') || !has('python3')
  finish
endif

NeoBundle "Shougo/deoplete.nvim"
NeoBundle "Shougo/neosnippet"
NeoBundle "Shougo/neosnippet-snippets"
NeoBundle "Shougo/echodoc"
NeoBundle 'zchee/deoplete-go', {'build': {'unix': 'make'}}

let g:echodoc_enable_at_startup = 1
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1

let g:neosnippet#data_directory = GetCacheDir("neosnippet")
let g:neosnippet#snippets_directory = "~/.vim/bundle/vim-snippets/snippets,~/.vim/snippets," . globpath(&rtp, "gosnippets/snippets")
let g:neosnippet#enable_snipmate_compatibility = 1
let g:go_snippet_engine = "neosnippet"

if !exists('g:deoplete#keyword_patterns')
    let g:deoplete#keyword_patterns = {}
endif

let g:deoplete#keyword_patterns['default'] = '\h\w*'

imap <c-k> <plug>(neosnippet_expand_or_jump)
smap <c-k> <plug>(neosnippet_expand_or_jump)
xmap <c-k> <plug>(neosnippet_expand_target)

smap <expr> <tab> neosnippet#expandable_or_jumpable() ? "\<plug>(neosnippet_expand_or_jump)" : "\<tab>"

imap <expr> <tab> pumvisible() ? "\<c-n>" : (neosnippet#expandable_or_jumpable() ? "\<plug>(neosnippet_expand_or_jump)" : "\<tab>")
imap <expr> <s-tab> pumvisible() ? "\<c-p>" : "\<tab>"

imap <expr> <c-g> deoplete#undo_completion()
" imap <expr> <c-l> deoplete#complete_common_string()

function! s:cleverCr()
  return pumvisible() ? "\<c-y>" : "\<cr>"
endfunction

imap <silent> <cr> <c-r>=<sid>cleverCr()<cr>
imap <expr> <s-cr> pumvisible() ? deoplete#smart_close_popup() . "\<cr>" : "\<cr>"

if !exists('g:deoplete#omni#input_patterns')
    let g:deoplete#omni#input_patterns = {}
endif

let g:deoplete#omni#input_patterns.php  = '[^. \t]->\h\w*\|\h\w*::'
let g:deoplete#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
let g:deoplete#omni#input_patterns.c    = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:deoplete#omni#input_patterns.cpp  = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
let g:deoplete#omni#input_patterns.ruby = '[^. *\t]\.\h\w*\|\h\w*::'

" enable omni completion
autocmd MyAutoCmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd MyAutoCmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd MyAutoCmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd MyAutoCmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd MyAutoCmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd MyAutoCmd FileType ruby setlocal omnifunc=rubycomplete#Complete

let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']
let g:deoplete#sources#go#align_class = 1

if neobundle#tap("deoplete.nvim")
  function! neobundle#hooks.on_post_source(bundle)
    call deoplete#custom#set('_', 'converters',
          \ ['converter_auto_paren',
          \  'converter_auto_delimiter',
          \  'converter_remove_overlap'])
  endfunction
endif
