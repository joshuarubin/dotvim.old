scriptencoding utf-8

highlight link ALEErrorSign   ErrorMsg
highlight link ALEWarningSign Type

let g:ale_lint_delay      = 1000
let g:ale_echo_msg_format = '[%severity%] %s [%linter%]'
let g:ale_sign_error      = '⨉'
let g:ale_sign_warning    = '⚠'
let g:ale_sign_info       = 'ℹ'
let g:ale_fix_on_save     = 1

let g:ale_fixers = {
\   'javascript': ['prettier_standard'],
\   'typescript': ['prettier'],
\   'css':        ['prettier'],
\   'scss':       ['prettier'],
\   'less':       ['prettier'],
\   'json':       ['prettier'],
\}

let g:ale_linters = {
\   'javascript': [ 'standard' ],
\   'jsx':        [ 'standard', 'stylelint' ],
\   'text':       [ 'proselint', 'vale', 'write-good' ],
\   'go':         [ 'gofmt', 'golint', 'go vet', 'go build', 'gometalinter' ],
\}

let g:ale_linter_aliases = {'jsx': 'css'}

let g:ale_css_stylelint_options = ''
\   . ' --config-basedir '.systemlist('npm root --global')[0]

let g:ale_stylus_stylelint_options = ''
\   . ' --config-basedir '.systemlist('npm root --global')[0]

let g:ale_javascript_standard_options = ''
\   . ' --plugin react'
\   . ' --plugin flowtype'
\   . ' --parser babel-eslint'

" if ale gofmt  isn't enabled add    '-E gofmt'
" if ale golint isn't enabled remove '-D golint'
" if ale go vet isn't enabled remove '-D vet'
let g:ale_go_gometalinter_options = ''
\   . ' -j 7'
\   . ' --tests'
\   . ' --deadline 30s'
\   . ' -D aligncheck'
\   . ' -D gocyclo'
\   . ' -D gotype'
\   . ' -D interfacer'
\   . ' -D structcheck'
\   . ' -D unconvert'
\   . ' -D varcheck'
\   . ' -D golint'
\   . ' -D vet'
\   . ' -E goimports'
\   . ' -E misspell'
