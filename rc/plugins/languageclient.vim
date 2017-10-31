scriptencoding utf-8

let g:LanguageClient_autoStart = 1
let g:LanguageClient_diagnosticsList = 'location'
let g:LanguageClient_serverCommands = {}
let g:LanguageClient_diagnosticsEnable = 0

if has('nvim')
  command! -nargs=* References call LanguageClient_textDocument_references()
endif

let g:LanguageClient_diagnosticsDisplay = {
  \    1: {
  \        'name': 'Error',
  \        'texthl': 'ALEError',
  \        'signText': '⨉',
  \        'signTexthl': 'ALEErrorSign',
  \    },
  \    2: {
  \        'name': 'Warning',
  \        'texthl': 'ALEWarning',
  \        'signText': '⚠',
  \        'signTexthl': 'ALEWarningSign',
  \    },
  \    3: {
  \        'name': 'Information',
  \        'texthl': 'ALEInfo',
  \        'signText': 'ℹ',
  \        'signTexthl': 'ALEInfoSign',
  \    },
  \    4: {
  \        'name': 'Hint',
  \        'texthl': 'ALEInfo',
  \        'signText': '➤',
  \        'signTexthl': 'ALEInfoSign',
  \    },
  \  }

if executable('go-langserver')
  let g:LanguageClient_serverCommands['go'] = ['go-langserver']
endif

if executable('rustup') && executable('rls')
  let g:LanguageClient_serverCommands['rust'] = ['rustup', 'run', 'nightly', 'rls']
endif

if executable('javascript-typescript-stdio')
  let g:LanguageClient_serverCommands['javascript']     = ['javascript-typescript-stdio']
  let g:LanguageClient_serverCommands['javascript.jsx'] = ['javascript-typescript-stdio']
  let g:LanguageClient_serverCommands['typescript']     = ['javascript-typescript-stdio']
endif

if executable('css-languageserver')
  let g:LanguageClient_serverCommands['css']  = ['css-languageserver', '--stdio']
  let g:LanguageClient_serverCommands['scss'] = ['css-languageserver', '--stdio']
  let g:LanguageClient_serverCommands['less'] = ['css-languageserver', '--stdio']
endif

if executable('json-languageserver')
  let g:LanguageClient_serverCommands['json'] = ['json-languageserver', '--stdio']
endif

if executable('html-languageserver')
  let g:LanguageClient_serverCommands['html'] = ['html-languageserver', '--stdio']
endif

if executable('docker-langserver')
  let g:LanguageClient_serverCommands['dockerfile'] = ['docker-langserver', '--stdio']
endif

if executable('pyls')
  let g:LanguageClient_serverCommands['python'] = ['pyls']
endif
