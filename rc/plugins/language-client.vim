scriptencoding utf-8

let g:LanguageClient_rootMarkers = {}
let g:LanguageClient_serverCommands = {}
let g:LanguageClient_diagnosticsList = 'location'

let g:LanguageClient_diagnosticsDisplay = {
  \   1: {
  \     'name': 'Error',
  \     'texthl': 'ErrorMsg',
  \     'signText': '🔥',
  \     'signTexthl': 'ALEErrorSign',
  \   },
  \   2: {
  \     'name': 'Warning',
  \     'texthl': 'Type',
  \     'signText': '🚧',
  \     'signTexthl': 'ALEWarningSign',
  \   },
  \   3: {
  \     'name': 'Information',
  \     'texthl': 'NeomakeInfoSign',
  \     'signText': '💬',
  \     'signTexthl': 'ALEInfoSign',
  \   },
  \   4: {
  \     'name': 'Hint',
  \     'texthl': 'NeomakeMessageSign',
  \     'signText': '📌',
  \     'signTexthl': 'ALEInfoSign',
  \   },
  \ }

function! s:lsp_key_mapping(lang) abort
  execute 'autocmd MyAutoCmd FileType ' . a:lang . ' nnoremap <silent> gd :call LanguageClient#textDocument_definition()<cr>'
  execute 'autocmd MyAutoCmd FileType ' . a:lang . ' nnoremap <silent> K :call LanguageClient#textDocument_hover()<cr>'
  execute 'autocmd MyAutoCmd FileType ' . a:lang . ' nnoremap <silent> <f2> :call LanguageClient#textDocument_rename()<cr>'
  execute 'autocmd MyAutoCmd FileType ' . a:lang . ' nnoremap <f5> :call LanguageClient_contextMenu()<cr>'
endfunction

if executable('bingo')
  let g:LanguageClient_rootMarkers['go'] = ['go.mod', '.git']
  let g:LanguageClient_serverCommands['go'] = ['bingo', '--mode', 'stdio', '-enable-global-cache', '-format-style', 'goimports', '-diagnostics-style', 'instant']
  call s:lsp_key_mapping('go')
endif
