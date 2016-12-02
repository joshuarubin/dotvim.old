if g:rubix_syntax == 'neomake'
  autocmd MyAutoCmd BufWritePost * if expand('%') !~ '^fugitive:\/\/' | Neomake | endif
endif

let g:neomake_error_sign   = {'text': '✖', 'texthl': 'NeomakeErrorSign'}
let g:neomake_warning_sign = {'text': '∆', 'texthl': 'NeomakeWarningSign'}
let g:neomake_message_sign = {'text': '➤', 'texthl': 'NeomakeMessageSign'}
let g:neomake_info_sign    = {'text': 'ℹ', 'texthl': 'NeomakeInfoSign'}

" javascript
let g:neomake_javascript_jshint_args = [ '--verbose', '--config', '~/.vim/misc/jshint.config.json' ]
let g:neomake_javascript_eslint_args = [ '-f', 'compact', '--config', '~/.vim/misc/eslint.config.json' ]
let g:neomake_javascript_standard_args = [ '--config', '~/.vim/misc/eslint.config.json' ]
let g:neomake_javascript_enabled_makers = [ 'standard' ]

" jsx (superset of javascript)
let g:neomake_jsx_enabled_makers = ['jshint', 'standard']

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
let g:neomake_go_enabled_makers = [ 'go', 'gometalinter' ]
let g:neomake_go_gometalinter_maker = {
  \ 'args': [
  \   '--tests',
  \   '--enable-gc',
  \   '--concurrency=3',
  \   '--fast',
  \   '-D', 'aligncheck',
  \   '-D', 'dupl',
  \   '-D', 'gocyclo',
  \   '-D', 'gotype',
  \   '-E', 'errcheck',
  \   '-E', 'misspell',
  \   '-E', 'unused',
  \   '%:p:h',
  \ ],
  \ 'append_file': 0,
  \ 'errorformat':
  \   '%E%f:%l:%c:%trror: %m,' .
  \   '%W%f:%l:%c:%tarning: %m,' .
  \   '%E%f:%l::%trror: %m,' .
  \   '%W%f:%l::%tarning: %m'
  \ }
