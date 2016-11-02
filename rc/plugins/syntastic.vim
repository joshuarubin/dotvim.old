if has("nvim")
  finish "use neomake
elseif v:version >= 800 && (v:version > 800 || has("patch0027"))
  finish "use neomake
endif

" syntax checking
NeoBundle "scrooloose/syntastic"

let g:syntastic_javascript_jshint_args = "--config ~/.vim/jshint.config.json"
let g:syntastic_javascript_eslint_args = "--config ~/.vim/eslint.config.json"
let g:syntastic_javascript_standard_args = "--config ~/.vim/eslint.config.json"
let g:syntastic_javascript_checkers = ["standard"]
let g:syntastic_python_checkers = ["python", "flake8"]
let g:syntastic_typescript_tsc_args = "-t ES5 --module commonjs"
let g:syntastic_typescript_tslint_args = "-c ~/.vim/tslint.config.json"
let g:syntastic_coffee_coffeelint_args = "--csv -f ~/.vim/coffeelint.config.json"
let g:syntastic_error_symbol = '✖'
let g:syntastic_style_error_symbol = '✠'
let g:syntastic_warning_symbol = '∆'
let g:syntastic_style_warning_symbol = '≈'
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0

let g:syntastic_go_gometalinter_args = "
  \ --vendor
  \ --tests
  \ --enable-gc
  \ --concurrency=3
  \ -D gocyclo
  \ -D dupl
  \ -D aligncheck
  \ -D test
  \ -D testify
  \ -D lll
  \ -D structcheck
  \ -D varcheck
  \ -D errcheck
  \ -D interfacer
  \ -D unconvert
  \ -D deadcode
  \ -E staticcheck
  \ -E gas
  \ -E vet
  \ -E golint
  \ -E vetshadow
  \ -E ineffassign
  \ -E goconst
  \ -E misspell
  \ -E unused
  \ -E gosimple
  \ -E gofmt
  \"


let g:syntastic_markdown_mdl_args = "-r '~MD013,~MD033'"

" highlight link SyntasticError WarningMsg
" highlight link SyntasticWarning Question
highlight link SyntasticErrorSign WarningMsg
highlight link SyntasticWarningSign Question

" show errors from all checkers
autocmd MyAutoCmd FileType go let g:syntastic_aggregate_errors = 1
autocmd MyAutoCmd FileType typescript let g:syntastic_aggregate_errors = 1

" autocmd MyAutoCmd FileType go let g:syntastic_go_checkers = ['go', 'govet', 'golint']
autocmd MyAutoCmd FileType go let g:syntastic_go_checkers = ['go', 'gometalinter']
autocmd MyAutoCmd FileType typescript let g:syntastic_typescript_checkers = ["tsc", "tslint"]
