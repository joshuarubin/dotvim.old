scriptencoding utf-8

let g:neomake_serialize = 1
let g:neomake_serialize_abort_on_error = 1

if g:rubix_syntax ==# 'neomake'
  autocmd MyAutoCmd BufWritePost * if expand('%') !~ '^fugitive:\/\/' | Neomake | endif
endif

if exists('$ALACRITTY_PROGRAM')
  " this is temporary until alacritty supports fallback fonts
  let g:neomake_error_sign   = {'text': 'E>', 'texthl': 'ErrorMsg'}
  let g:neomake_warning_sign = {'text': 'W>', 'texthl': 'Type'}
  let g:neomake_message_sign = {'text': '>>', 'texthl': 'NeomakeMessageSign'}
  let g:neomake_info_sign    = {'text': 'I>', 'texthl': 'NeomakeInfoSign'}
else
  let g:neomake_error_sign   = {'text': '⨉', 'texthl': 'ErrorMsg'}
  let g:neomake_warning_sign = {'text': '⚠', 'texthl': 'Type'}
  let g:neomake_message_sign = {'text': '➤', 'texthl': 'NeomakeMessageSign'}
  let g:neomake_info_sign    = {'text': 'ℹ', 'texthl': 'NeomakeInfoSign'}
endif

" javascript
let g:neomake_javascript_standard_args = [
  \   '--plugin', 'react',
  \   '--plugin', 'flowtype',
  \   '--parser', 'babel-eslint',
  \ ]
let g:neomake_javascript_enabled_makers = [ 'standard' ]

" jsx (superset of javascript)
let g:neomake_jsx_enabled_makers = ['standard']

" typescript
let g:neomake_typescript_tsc_args = [ '-t', 'ES5', '--module', 'commonjs' ]
let g:neomake_typescript_tslint_args = [ '-c', '~/.vim/misc/tslint.config.json' ]
let g:neomake_typescript_enabled_makers = [ 'tsc', 'tslint' ]

" python
let g:neomake_python_enabled_makers = [ 'python', 'flake8' ]

" coffee
let g:neomake_coffee_coffeelint_args = [ '--reporter=csv', '-f', '~/.vim/misc/coffeelint.config.json' ]

" markdown
let g:neomake_markdown_mdl_args = [ '-r', '~MD013,~MD033' ]

" c
let g:neomake_c_clang_args = ['-fsyntax-only', '-Wall', '-Wextra', '-Weverything']

" go
let g:neomake_go_enabled_makers = [ 'gofmt', 'go', 'zblint' ]

let g:neomake_go_gofmt_maker = {
  \ 'args': ['-l', '-e'],
  \ 'errorformat': '%E%f:%l:%c: %m,'
  \ }

let g:neomake_go_zblint_maker = {
  \ 'exe': 'zb',
  \ 'args': [
  \   '--package',
  \   '--log-level', 'INFO',
  \   'lint',
  \   '--fast',
  \   '-n',
  \ ],
  \ 'append_file': 0,
  \ 'cwd': '%:h',
  \ 'errorformat':
  \   '%E%f:%l:%c:%trror: %m,' .
  \   '%W%f:%l:%c:%tarning: %m,' .
  \   '%E%f:%l::%trror: %m,' .
  \   '%W%f:%l::%tarning: %m'
  \ }

let g:neomake_go_gometalinter_maker = {
  \ 'args': [
  \   '--tests',
  \   '--enable-gc',
  \   '--concurrency=3',
  \   '--fast',
  \   '-D', 'aligncheck',
  \   '-D', 'gocyclo',
  \   '-E', 'gofmt',
  \   '-E', 'goimports',
  \   '-E', 'misspell',
  \   '-E', 'unused',
  \ ],
  \ 'append_file': 0,
  \ 'cwd': '%:h',
  \ 'mapexpr': 'neomake_bufdir . "/" . v:val',
  \ 'errorformat':
  \   '%E%f:%l:%c:%trror: %m,' .
  \   '%W%f:%l:%c:%tarning: %m,' .
  \   '%E%f:%l::%trror: %m,' .
  \   '%W%f:%l::%tarning: %m'
  \ }
