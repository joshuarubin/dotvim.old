" neocomplete + neosnippet + neosnippet-snippets requires lua
" youcompleteme + ultisnips is the fallback without lua
" nvim defaults to deoplete
if v:version < 704 || has("lua") || (!has("python") && !has("python3")) || has('nvim')
  finish
endif

NeoBundle "SirVer/ultisnips", {"vim_version": "7.4"}

let g:UltiSnipsExpandTrigger = "<c-j>"
let g:UltiSnipsJumpForwardTrigger = "<c-j>"
let g:UltiSnipsJumpBackwardTrigger = "<c-k>"
