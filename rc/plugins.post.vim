" settings after plugins are loaded

" install missing plugins on start
autocmd MyAutoCmd VimEnter *
  \  if !empty(filter(copy(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall
  \| endif

if g:rubix_snippet ==# 'neosnippet'
  let g:neosnippet#snippets_directory = globpath(&runtimepath, 'snippets', 0, 1)
endif

let g:startify_skiplist = add(
      \ map(split(&runtimepath, ','), 'escape(resolve(v:val . ''/doc''), ''\'')'),
      \ 'COMMIT_EDITMSG')
