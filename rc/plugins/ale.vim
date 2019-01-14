scriptencoding utf-8

highlight link ALEErrorSign   ErrorMsg
highlight link ALEWarningSign Type

let g:ale_emit_conflict_warnings = 1
let g:ale_echo_msg_format = '[%severity%] %s [%linter%]'
let g:ale_sign_error      = '🔥'
let g:ale_sign_warning    = '🚧'
let g:ale_sign_info       = '💬'
let g:ale_fix_on_save     = 1

let g:ale_fixers = {
\   'go':         [ 'goimports', 'gofmt' ],
\   'gomod':      [ 'gomod' ],
\   'javascript': [ 'prettier_standard' ],
\   'typescript': [ 'prettier' ],
\   'css':        [ 'prettier' ],
\   'scss':       [ 'prettier' ],
\   'less':       [ 'prettier' ],
\   'json':       [ 'prettier' ],
\   'terraform':  [ 'terraform' ],
\}

let g:ale_linters = {
\   'javascript': [ 'standard' ],
\   'jsx':        [ 'standard', 'stylelint' ],
\   'vimwiki':    [ 'alex', 'mdl', 'prettier', 'proselint', 'redpen', 'remark-lint', 'vale' ],
\   'text':       [ 'alex', 'proselint', 'vale', 'write-good', 'redpen' ],
\   'go':         [ 'govet', 'golangci-lint' ],
\   'proto':      [ 'prototool' ],
\}

let g:ale_go_govet_options = '-shadow'

let g:ale_go_gofmt_options = '-s'

let g:ale_go_golangci_lint_package = 1
let g:ale_go_golangci_lint_options = ''
\   . ' --exclude-use-default'
\   . ' --out-format=line-number'
\   . ' --tests'
\   . ' --print-issued-lines=false'
\   . ' --disable-all'
\   . ' --enable=deadcode'
\   . ' --enable=errcheck'
\   . ' --enable=golint'
\   . ' --enable=gosec'
\   . ' --enable=ineffassign'
\   . ' --enable=megacheck'
\   . ' --enable=misspell'
\   . ' --enable=prealloc'
\   . ' --enable=scopelint'
\   . ' --enable=structcheck'
\   . ' --enable=unconvert'
\   . ' --enable=varcheck'

let g:ale_linter_aliases = {
\   'jsx': 'css',
\   'vimwiki': 'markdown',
\ }

let s:npm_root = systemlist('npm root --global')

if len(s:npm_root) > 0
  let g:ale_css_stylelint_options = ''
  \   . ' --config-basedir '.s:npm_root[0]

  let g:ale_scss_stylelint_options = ''
  \   . ' --config-basedir '.s:npm_root[0]

  let g:ale_stylus_stylelint_options = ''
  \   . ' --config-basedir '.s:npm_root[0]
endif

let g:ale_javascript_standard_options = ''
\   . ' --plugin react'
\   . ' --plugin flowtype'
\   . ' --parser babel-eslint'

let g:ale_c_clang_options = '-std=c11 -Wall -Wextra -Weverything'
