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

function! ale_linters#go#zblint#GetCommand(buffer, copy_output) abort
  let l:tempdir = a:copy_output[0]
  let l:importpath = ale_linters#go#gobuild#PackageImportPath(a:buffer)
  let l:gopaths = [ l:tempdir ]
  call extend(l:gopaths, split(g:ale_linters#go#gobuild#go_env.GOPATH, s:SplitChar))

  return 'GOPATH=' . shellescape(join(l:gopaths, s:SplitChar)) . ' zb ' . s:Args() . ' ' . shellescape(l:importpath)
endfunction

call ale#linter#Define('go', {
\   'name': 'zblint',
\   'executable': 'zb',
\   'command_chain': [
\     {'callback': 'ale_linters#go#gobuild#GoEnv', 'output_stream': 'stdout'},
\     {'callback': 'ale_linters#go#gobuild#GoList', 'output_stream': 'stdout'},
\     {'callback': 'ale_linters#go#gobuild#CopyFiles', 'output_stream': 'stdout'},
\     {'callback': 'ale_linters#go#gobuild#WriteBuffers', 'output_stream': 'stdout'},
\     {'callback': 'ale_linters#go#zblint#GetCommand', 'output_stream': 'stdout'},
\   ],
\   'callback': 'ale_linters#go#gometalinter#Handler',
\})
