scriptencoding utf-8

highlight link ALEErrorSign   ErrorMsg
highlight link ALEWarningSign Type

let g:ale_emit_conflict_warnings = 0
let g:ale_lint_delay      = 1000
let g:ale_echo_msg_format = '[%severity%] %s [%linter%]'
let g:ale_sign_error      = '🔥'
let g:ale_sign_warning    = '🚧'
let g:ale_sign_info       = '💬'
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
\   'vimwiki':    [ 'alex', 'mdl', 'prettier', 'proselint', 'redpen', 'remark-lint', 'vale' ],
\   'text':       [ 'alex', 'proselint', 'vale', 'write-good', 'redpen' ],
\   'go':         [ 'gofmt', 'golint', 'go vet', 'go build', 'gometalinter' ],
\}

let g:ale_linter_aliases = {
\   'jsx': 'css',
\   'vimwiki': 'markdown',
\ }

let s:npm_root = systemlist('npm root --global')

if len(s:npm_root) > 0
  let g:ale_css_stylelint_options = ''
  \   . ' --config-basedir '.s:npm_root[0]

  let g:ale_stylus_stylelint_options = ''
  \   . ' --config-basedir '.s:npm_root[0]
endif

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

let g:ale_c_clang_options = '-std=c11 -Wall -Wextra -Weverything'
