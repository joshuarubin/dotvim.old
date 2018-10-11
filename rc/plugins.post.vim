" settings after plugins are loaded

" install missing plugins on start
autocmd MyAutoCmd VimEnter *
  \  if !empty(filter(copy(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall
  \| endif

autocmd MyAutoCmd BufEnter * call ncm2#enable_for_buffer()

let g:startify_skiplist = add(
      \ map(split(&runtimepath, ','), 'escape(resolve(v:val . ''/doc''), ''\'')'),
      \ 'COMMIT_EDITMSG')

autocmd MyAutoCmd User GoyoEnter nested call rubix#goyo#enter()
autocmd MyAutoCmd User GoyoLeave nested call rubix#goyo#leave()
