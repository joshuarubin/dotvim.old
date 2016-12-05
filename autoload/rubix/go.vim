function! rubix#go#word(args) abort
  if !len(a:args)
    let oldiskeyword = &iskeyword

    " would get all of fmt.Println
    setlocal iskeyword+=.
    let word = expand('<cword>')

    " would only get the part of fmt.Println the cursor is on, fmt or Println
    setlocal iskeyword-=.
    let pkg = expand('<cword>')

    let &iskeyword = oldiskeyword

    let word = substitute(word, '[^a-zA-Z0-9\\/._~-]', '', 'g')
    let pkg  = substitute(pkg,  '[^a-zA-Z0-9\\/._~-]', '', 'g')
    let words = split(word, '\.\ze[^./]\+$')

    if words[0] ==# pkg
      " cursor was on package name, just use that
      let words = words[:0]
    endif
  else
    let words = a:args
  endif

  if !len(words)
    return []
  endif

  let pkg = words[0]

  let packages = go#tool#Imports()

  if has_key(packages, pkg)
    let pkg = packages[pkg]
  endif

  if len(words) == 1
    return [pkg]
  endif

  return [pkg, words[1]]
endfunction

function! rubix#go#doc(...) abort
  let words = call('rubix#go#word', [a:000])
  return call('ge#doc#open', copy(words))
endfunction

" run :GoBuild or :GoTestCompile based on the go file
function! rubix#go#build()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#cmd#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction
