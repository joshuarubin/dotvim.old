" neocomplete + neosnippet + neosnippet-snippets requires lua
" youcompleteme + ultisnips is the fallback without lua
if v:version < 704 || has("lua")
  finish
endif

NeoBundle "SirVer/ultisnips", {"vim_version": "7.4"}

let g:UltiSnipsExpandTrigger = "<c-j>"
let g:UltiSnipsJumpForwardTrigger = "<c-j>"
let g:UltiSnipsJumpBackwardTrigger = "<c-k>"
