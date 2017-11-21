scriptencoding utf-8

let g:neomake_error_sign   = {'text': '⨉', 'texthl': 'ErrorMsg'}
let g:neomake_warning_sign = {'text': '⚠', 'texthl': 'Type'}
let g:neomake_message_sign = {'text': '➤', 'texthl': 'NeomakeMessageSign'}
let g:neomake_info_sign    = {'text': 'ℹ', 'texthl': 'NeomakeInfoSign'}

" go
let g:neomake_go_enabled_makers = [ 'go', 'golint', 'govet', 'gometalinter' ]

" if neomake gofmt  isn't enabled add    '-E gofmt'
" if neomake golint isn't enabled remove '-D golint'
" if neomake go vet isn't enabled remove '-D vet'
let g:neomake_go_gometalinter_args = [
  \ '--concurrency=7',
  \ '--tests',
  \ '--deadline=30s',
  \ '--disable=aligncheck',
  \ '--disable=gocyclo',
  \ '--disable=gotype',
  \ '--disable=interfacer',
  \ '--disable=structcheck',
  \ '--disable=unconvert',
  \ '--disable=varcheck',
  \ '--disable=golint',
  \ '--disable=vet',
  \ '--enable=goimports',
  \ '--enable=misspell',
  \ ]
