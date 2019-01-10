scriptencoding utf-8

let g:LanguageClient_rootMarkers = {}
let g:LanguageClient_serverCommands = {}
let g:LanguageClient_diagnosticsList = 'location'

let g:LanguageClient_diagnosticsDisplay = {
  \   1: {
  \     'name': 'Error',
  \     'texthl': 'ALEError',
  \     'signText': '🔥',
  \     'signTexthl': 'ALEErrorSign',
  \   },
  \   2: {
  \     'name': 'Warning',
  \     'texthl': 'ALEWarning',
  \     'signText': '🚧',
  \     'signTexthl': 'ALEWarningSign',
  \   },
  \   3: {
  \     'name': 'Information',
  \     'texthl': 'ALEInfo',
  \     'signText': '💬',
  \     'signTexthl': 'ALEInfoSign',
  \   },
  \   4: {
  \     'name': 'Hint',
  \     'texthl': 'ALEInfo',
  \     'signText': '📌',
  \     'signTexthl': 'ALEInfoSign',
  \   },
  \ }

function! s:lsp_key_mapping(lang) abort
  execute 'autocmd MyAutoCmd FileType ' . a:lang . ' nnoremap <buffer> <silent> gd :call LanguageClient#textDocument_definition()<cr>'
  execute 'autocmd MyAutoCmd FileType ' . a:lang . ' nnoremap <buffer> <silent> K :call LanguageClient#textDocument_hover()<cr>'
  execute 'autocmd MyAutoCmd FileType ' . a:lang . ' nnoremap <buffer> <silent> <f2> :call LanguageClient#textDocument_rename()<cr>'
  execute 'autocmd MyAutoCmd FileType ' . a:lang . ' nnoremap <buffer> <silent> <f5> :call LanguageClient_contextMenu()<cr>'

  execute 'autocmd MyAutoCmd FileType ' . a:lang . ' nnoremap <buffer> <silent> <leader>ld :call LanguageClient#textDocument_definition()<cr>'
  execute 'autocmd MyAutoCmd FileType ' . a:lang . ' nnoremap <buffer> <silent> <leader>lr :call LanguageClient#textDocument_rename()<cr>'
  execute 'autocmd MyAutoCmd FileType ' . a:lang . ' nnoremap <buffer> <silent> <leader>lf :call LanguageClient#textDocument_formatting()<cr>'
  execute 'autocmd MyAutoCmd FileType ' . a:lang . ' nnoremap <buffer> <silent> <leader>lt :call LanguageClient#textDocument_typeDefinition()<cr>'
  execute 'autocmd MyAutoCmd FileType ' . a:lang . ' nnoremap <buffer> <silent> <leader>lx :call LanguageClient#textDocument_references()<cr>'
  execute 'autocmd MyAutoCmd FileType ' . a:lang . ' nnoremap <buffer> <silent> <leader>la :call LanguageClient_workspace_applyEdit()<cr>'
  execute 'autocmd MyAutoCmd FileType ' . a:lang . ' nnoremap <buffer> <silent> <leader>lc :call LanguageClient#textDocument_completion()<cr>'
  execute 'autocmd MyAutoCmd FileType ' . a:lang . ' nnoremap <buffer> <silent> <leader>lh :call LanguageClient#textDocument_hover()<cr>'
  execute 'autocmd MyAutoCmd FileType ' . a:lang . ' nnoremap <buffer> <silent> <leader>ls :call LanguageClient_textDocument_documentSymbol()<cr>'
  execute 'autocmd MyAutoCmd FileType ' . a:lang . ' nnoremap <buffer> <silent> <leader>lm :call LanguageClient_contextMenu()<cr>'
endfunction

if executable('bingo')
  let g:LanguageClient_rootMarkers['go'] = ['go.mod', '.git']
  let g:LanguageClient_serverCommands['go'] = ['bingo', '--mode', 'stdio', '-enable-global-cache', '-format-style', 'goimports', '-diagnostics-style', 'instant']
  call s:lsp_key_mapping('go')
endif
