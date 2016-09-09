if !has("nvim") " use syntastic
  finish
endif

" asynchronous :make using neovim's job-control functionality
NeoBundle "neomake/neomake"

autocmd MyAutoCmd BufWritePost * if expand('%') !~ '^fugitive:\/\/' | Neomake | endif

let g:neomake_error_sign   = {'text': '✖', 'texthl': 'NeomakeErrorSign'}
let g:neomake_warning_sign = {'text': '∆', 'texthl': 'NeomakeWarningSign'}
let g:neomake_message_sign = {'text': '➤', 'texthl': 'NeomakeMessageSign'}
let g:neomake_info_sign    = {'text': 'ℹ', 'texthl': 'NeomakeInfoSign'}

" javascript
let g:neomake_javascript_jshint_args = [ '--verbose', '--config', '~/.vim/jshint.config.json' ]
let g:neomake_javascript_eslint_args = [ '-f', 'compact', '--config', '~/.vim/eslint.config.json' ]
let g:neomake_javascript_standard_args = [ '--config', '~/.vim/eslint.config.json' ]
let g:neomake_javascript_enabled_makers = [ 'standard' ]

" typescript
let g:neomake_typescript_tsc_args = [ '-t', 'ES5', '--module', 'commonjs' ]
let g:neomake_typescript_tslint_args = [ '-c', '~/.vim/tslint.config.json' ]
let g:neomake_typescript_enabled_makers = [ 'tsc', 'tslint' ]

" python
let g:neomake_python_enabled_makers = [ 'python', 'flake8' ]

" coffee
let g:neomake_coffee_coffeelint_args = [ '--reporter=csv', '-f', '~/.vim/coffeelint.config.json' ]

" markdown
let g:neomake_markdown_mdl_args = [ '-r', '~MD013,~MD033' ]

" c
let g:neomake_c_clang_args = ['-fsyntax-only', '-Wall', '-Wextra', '-Weverything']

" go
let g:neomake_go_enabled_makers = [ 'go', 'gometalinter' ]
let g:neomake_go_gometalinter_maker = {
  \ 'args': [
  \   '--vendor',
  \   '--tests',
  \   '--enable-gc',
  \   '--concurrency=7',
  \   '-D', 'gocyclo',
  \   '-D', 'structcheck',
  \   '-D', 'varcheck',
  \   '-D', 'aligncheck',
  \   '-D', 'testify',
  \   '-D', 'test',
  \   '-D', 'interfacer',
  \   '-D', 'unconvert',
  \   '-D', 'dupl',
  \   '-E', 'misspell',
  \   '-E', 'unused',
  \   '-E', 'gofmt',
  \   '%:p:h',
  \ ],
  \ 'append_file': 0,
  \ 'errorformat':
  \   '%E%f:%l:%c:%trror: %m,' .
  \   '%W%f:%l:%c:%tarning: %m,' .
  \   '%E%f:%l::%trror: %m,' .
  \   '%W%f:%l::%tarning: %m'
  \ }
