function! rubix#go#word(args) abort
  if !len(a:args)
    let l:oldiskeyword = &iskeyword

    " would get all of fmt.Println
    setlocal iskeyword+=.
    let l:word = expand('<cword>')

    " would only get the part of fmt.Println the cursor is on, fmt or Println
    setlocal iskeyword-=.
    let l:pkg = expand('<cword>')

    let &iskeyword = l:oldiskeyword

    let l:word = substitute(l:word, '[^a-zA-Z0-9\\/._~-]', '', 'g')
    let l:pkg  = substitute(l:pkg,  '[^a-zA-Z0-9\\/._~-]', '', 'g')
    let l:words = split(l:word, '\.\ze[^./]\+$')

    if l:words[0] ==# l:pkg
      " cursor was on package name, just use that
      let l:words = l:words[:0]
    endif
  else
    let l:words = a:args
  endif

  if !len(l:words)
    return []
  endif

  let l:pkg = l:words[0]

  let l:packages = go#tool#Imports()

  if has_key(l:packages, l:pkg)
    let l:pkg = l:packages[l:pkg]
  endif

  if len(l:words) == 1
    return [l:pkg]
  endif

  return [l:pkg, l:words[1]]
endfunction

" run :GoBuild or :GoTestCompile based on the go file
function! rubix#go#build() abort
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#cmd#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction
