scriptencoding utf-8

let g:ale_lint_on_save = 1
let g:ale_echo_msg_format = '[%severity%] %s [%linter%]'
let g:ale_statusline_format = ['E•%d', 'W•%d', 'OK']

if exists('$ALACRITTY_PROGRAM')
  " this is temporary until alacritty supports fallback fonts
  let g:ale_sign_error   = 'E>'
  let g:ale_sign_warning = 'W>'
else
  let g:ale_sign_error   = '⨉'
  let g:ale_sign_warning = '⚠'
endif

let g:ale_experimental_multibuffer = 1
let g:ale_linters#go#gometalinter#args = [
      \ '--tests',
      \ '--enable-gc',
      \ '--concurrency', '3',
      \ '--fast',
      \ '-D', 'aligncheck',
      \ '-D', 'gocyclo',
      \ '-E', 'gofmt',
      \ '-E', 'goimports',
      \ '-E', 'misspell',
      \ '-E', 'unused',
      \ ]

let g:ale_javascript_standard_options = '--plugin react --plugin flowtype --parser babel-eslint'
let g:ale_c_clang_options = '-std=c11 -Wall -Wextra -Weverything'

let g:ale_linters = {
\   'go': [ 'zblint' ],
\   'javascript': [ 'standard' ],
\}
