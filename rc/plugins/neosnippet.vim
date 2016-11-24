let g:rubix_neosnippet = 0
if has('nvim') && has('python3')
  " deoplete is enabled
  let g:rubix_neosnippet = 1
elseif has('lua') && !has('nvim') && (v:version > 703 || v:version == 703 && has('patch885'))
  " neocomplete is enabled
  let g:rubix_neosnippet = 1
endif

Plug 'Shougo/neosnippet', Cond(g:rubix_neosnippet)
Plug 'Shougo/neosnippet-snippets', Cond(g:rubix_neosnippet)
Plug 'Shougo/echodoc', Cond(g:rubix_neosnippet)
Plug 'tpope/vim-endwise', Cond(g:rubix_neosnippet)

if !g:rubix_neosnippet
  finish
endif

let g:endwise_no_mappings = 1
let g:echodoc_enable_at_startup = 0

let g:neosnippet#data_directory = GetCacheDir("neosnippet")
let g:neosnippet#snippets_directory = join(globpath(&rtp, "snippets", 0, 1) + globpath(&rtp, "gosnippets/snippets", 0, 1), ",")
let g:neosnippet#enable_snipmate_compatibility = 1
let g:go_snippet_engine = "neosnippet"

" must be recursive
imap <c-k> <plug>(neosnippet_expand_or_jump)
smap <c-k> <plug>(neosnippet_expand_or_jump)
xmap <c-k> <plug>(neosnippet_expand_target)

smap <expr> <tab> neosnippet#expandable_or_jumpable() ? "\<plug>(neosnippet_expand_or_jump)" : "\<tab>"

imap <expr> <tab> pumvisible() ? "\<c-n>" : (neosnippet#expandable_or_jumpable() ? "\<plug>(neosnippet_expand_or_jump)" : "\<tab>")
imap <expr> <s-tab> pumvisible() ? "\<c-p>" : "\<tab>"

function! CleverCr()
  if !pumvisible()
    " return "\<plug>(DiscretionaryEnd)"
    return "\<cr>"
  endif

  if neosnippet#expandable()
    return "\<plug>(neosnippet_expand_or_jump)"
  endif

  return "\<c-y>"
endfunction

" must be recursive
imap <expr> <cr> CleverCr()
