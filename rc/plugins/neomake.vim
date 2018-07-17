scriptencoding utf-8

let g:neomake_error_sign   = {'text': '🔥', 'texthl': 'ErrorMsg'}
let g:neomake_warning_sign = {'text': '🚧', 'texthl': 'Type'}
let g:neomake_message_sign = {'text': '📌', 'texthl': 'NeomakeMessageSign'}
let g:neomake_info_sign    = {'text': '💬', 'texthl': 'NeomakeInfoSign'}

autocmd MyAutoCmd BufWritePost *.go call rubix#neomake('BufWritePost')
autocmd MyAutoCmd BufWinEnter  *.go call rubix#neomake('BufWinEnter')

" go
let g:neomake_go_enabled_makers = [ 'go', 'golangcilint' ]

" if neomake gofmt  isn't enabled add    '-E gofmt'
" if neomake golint isn't enabled remove '-D golint'
" if neomake go vet isn't enabled remove '-D vet'

" errcheck and megacheck are _really_ useful, but also very slow
" gotype is disabled because the go maker is enabled
" gofmt is not enabled because vim-go handles it
" goimports is not enabled because vim-go handles it

let g:neomake_go_gometalinter_args = [
  \ '--concurrency=4',
  \ '--tests',
  \ '--deadline=5s',
  \ '--disable=errcheck',
  \ '--disable=goconst',
  \ '--disable=gocyclo',
  \ '--disable=gotype',
  \ '--disable=gotypex',
  \ '--disable=interfacer',
  \ '--disable=maligned',
  \ '--disable=megacheck',
  \ '--disable=structcheck',
  \ '--disable=unconvert',
  \ '--disable=varcheck',
  \ '--enable=misspell',
  \ '--disable=gas',
  \ '--linter=gasn:gas -fmt=csv:^(?P<path>.*?\.go),(?P<line>\d+),(?P<message>[^,]+,[^,]+,[^,]+)',
  \ '--enable=gasn',
  \ ]

let g:neomake_go_golangcilint_maker = {
  \   'exe': 'golangci-lint',
  \   'append_file': 0,
  \   'cwd': '%:h',
  \   'errorformat':
  \     '%f:%l:%c: %m,' .
  \     '%f:%l:: %m',
  \   'args': [
  \     'run',
  \     '--concurrency=4',
  \     '--exclude-use-default',
  \     '--out-format=line-number',
  \     '--tests',
  \     '--silent',
  \     '--print-issued-lines=false',
  \     '--disable-all',
  \     '--enable=gas',
  \     '--enable=deadcode',
  \     '--enable=golint',
  \     '--enable=govet',
  \     '--enable=ineffassign',
  \     '--enable=misspell',
  \     '--enable=prealloc',
  \     '--enable=errcheck',
  \     '--enable=megacheck',
  \     '--enable=varcheck',
  \   ],
  \ }
