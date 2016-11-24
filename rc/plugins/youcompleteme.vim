" neocomplete + neosnippet + neosnippet-snippets requires lua
" youcompleteme + ultisnips is the fallback without lua
" nvim defaults to deoplete
if has("lua") || v:version < 703 || (v:version == 703 && !has("patch598")) || !has("python") || has('nvim')
  finish
endif

Plug 'Valloric/YouCompleteMe', { 'do': './install.py --gocode-completer --clang-completer' }

let g:ycm_collect_identifiers_from_tags_files = 1

let g:ycm_semantic_triggers =  {
  \   "c":          ["->", "."],
  \   "objc":       ["->", "."],
  \   "ocaml":      [".", "#"],
  \   "cpp,objcpp": ["->", ".", "::"],
  \   "perl":       ["->"],
  \   "php":        ["->", "::"],
  \   "cs,java,javascript,d,python,perl6,scala,vb,elixir,go": ["."],
  \   "vim":        ["re![_a-zA-Z]+[_\w]*\."],
  \   "ruby":       [".", "::"],
  \   "lua":        [".", ":"],
  \   "erlang":     [":"],
  \   "haskell":    ["."],
  \ }

function! s:cleverCr()
  return pumvisible() ? "\<c-y>" : "\<cr>"
endfunction

imap <silent> <cr> <c-r>=<sid>cleverCr()<cr>

" enable omni completion
autocmd MyAutoCmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd MyAutoCmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd MyAutoCmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd MyAutoCmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd MyAutoCmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd MyAutoCmd FileType ruby setlocal omnifunc=rubycomplete#Complete
