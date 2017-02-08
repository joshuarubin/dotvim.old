let s:SplitChar = has('unix') ? ':' : ':'

let g:ale_linters#go#zblint#args = get(g:, 'ale_linters#go#zblint#args', [
\   '--package',
\   '--log-level', 'INFO',
\   'lint',
\   '--fast',
\   '-n',
\ ])

function! s:Args() abort
  return join(map(copy(g:ale_linters#go#zblint#args), 'shellescape(v:val)'), ' ')
endfunction

function! ale_linters#go#zblint#GetCommand(buffer, install_output) abort
  let l:tempdir = a:install_output[0]
  let l:importpath = shellescape(ale_linters#go#gobuild#PackageImportPath(a:buffer))

  return ale_linters#go#gobuild#GoPathCmd(l:tempdir, 'zb ' . s:Args() . ' ' . l:importpath)
endfunction

call ale#linter#Define('go', {
\   'name': 'zblint',
\   'executable': 'zb',
\   'command_chain': [
\     {'callback': 'ale_linters#go#gobuild#GoEnv'},
\     {'callback': 'ale_linters#go#gobuild#CopyFiles'},
\     {'callback': 'ale_linters#go#gobuild#WriteBuffers'},
\     {'callback': 'ale_linters#go#gobuild#Install'},
\     {'callback': 'ale_linters#go#zblint#GetCommand'},
\   ],
\   'callback': 'ale_linters#go#gometalinter#Handler',
\})
