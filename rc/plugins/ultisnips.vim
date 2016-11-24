" neocomplete + neosnippet + neosnippet-snippets requires lua
" youcompleteme + ultisnips is the fallback without lua
" nvim defaults to deoplete

let g:rubix_ultisnips = 1

if v:version < 704 || has("lua") || (!has("python") && !has("python3")) || has('nvim')
  let g:rubix_ultisnips = 0
endif

Plug 'SirVer/ultisnips', Cond(g:rubix_ultisnips)

if !g:rubix_ultisnips
  finish
endif

let g:UltiSnipsExpandTrigger = "<c-j>"
let g:UltiSnipsJumpForwardTrigger = "<c-j>"
let g:UltiSnipsJumpBackwardTrigger = "<c-k>"
