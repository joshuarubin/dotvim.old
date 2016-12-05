let g:syntastic_javascript_jshint_args = "--config ~/.vim/misc/jshint.config.json"
let g:syntastic_javascript_eslint_args = "--config ~/.vim/misc/eslint.config.json"
let g:syntastic_javascript_standard_args = "--config ~/.vim/misc/eslint.config.json"
let g:syntastic_javascript_checkers = ["standard"]
let g:syntastic_python_checkers = ["python", "flake8"]
let g:syntastic_typescript_tsc_args = "-t ES5 --module commonjs"
let g:syntastic_typescript_tslint_args = "-c ~/.vim/tslint.config.json"
let g:syntastic_typescript_checkers = ["tsc", "tslint"]
let g:syntastic_coffee_coffeelint_args = "--csv -f ~/.vim/misc/coffeelint.config.json"
let g:syntastic_error_symbol = '✖'
let g:syntastic_style_error_symbol = '✠'
let g:syntastic_warning_symbol = '∆'
let g:syntastic_style_warning_symbol = '≈'
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_aggregate_errors = 1
let g:syntastic_go_checkers = ['go', 'gometalinter']

let g:syntastic_go_gometalinter_args = "
  \ --tests
  \ --enable-gc
  \ --concurrency=3
  \ --fast
  \ -D aligncheck
  \ -D dupl
  \ -D gocyclo
  \ -D gotype
  \ -E errcheck
  \ -E misspell
  \ -E unused
  \"

let g:syntastic_markdown_mdl_args = "-r '~MD013,~MD033'"

highlight link SyntasticErrorSign WarningMsg
highlight link SyntasticWarningSign Question
