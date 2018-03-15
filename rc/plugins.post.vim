" settings after plugins are loaded

" install missing plugins on start
autocmd MyAutoCmd VimEnter *
  \  if !empty(filter(copy(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall
  \| endif

if exists('*deoplete#custom#set')
  call deoplete#custom#set('_', 'converters', [
    \   'converter_auto_paren',
    \   'converter_remove_overlap',
    \   'converter_truncate_abbr',
    \   'converter_truncate_menu',
    \   'converter_auto_delimiter',
    \ ])
endif

let g:neosnippet#snippets_directory = globpath(&runtimepath, 'snippets', 0, 1)
let g:neosnippet#snippets_directory += globpath(&runtimepath, 'neosnippets', 0, 1)

let g:startify_skiplist = add(
      \ map(split(&runtimepath, ','), 'escape(resolve(v:val . ''/doc''), ''\'')'),
      \ 'COMMIT_EDITMSG')

autocmd MyAutoCmd User GoyoEnter nested call rubix#goyo#enter()
autocmd MyAutoCmd User GoyoLeave nested call rubix#goyo#leave()
