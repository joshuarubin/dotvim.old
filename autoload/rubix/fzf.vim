function! s:q1(str) abort
  return "'".substitute(a:str, "'", "'\\\\''", 'g')."'"
endfunction

let s:last = ['', '']

" query, path, [[rg options], options]
function! rubix#fzf#rg(query, path, ...) abort
  let s:last = [a:query, a:path]
  if type(a:query) != s:TYPE.string
    return s:warn('Invalid query argument')
  endif
  let l:query = empty(a:query) ? '^(?=.)' : a:query
  let l:path = fnamemodify(a:path, ':p:.')
  let l:args = copy(a:000)
  let l:rg_opts = len(l:args) > 1 && type(l:args[0]) == s:TYPE.string ? remove(l:args, 0) : ''
  let l:command = l:rg_opts . ' ' . s:q1(l:query) . (empty(l:path) ? '' : ' ' . s:q1(l:path))
  return call('rubix#fzf#rg_raw', insert(l:args, l:command, 0))
endfunction

" query, path, [[ag options], options]
function! rubix#fzf#ag(query, path, ...) abort
  let s:last = [a:query, a:path]
  if type(a:query) != s:TYPE.string
    return s:warn('Invalid query argument')
  endif
  let l:query = empty(a:query) ? '^(?=.)' : a:query
  let l:path = fnamemodify(a:path, ':p:.')
  let l:args = copy(a:000)
  let l:ag_opts = len(l:args) > 1 && type(l:args[0]) == s:TYPE.string ? remove(l:args, 0) : ''
  let l:command = l:ag_opts . ' ' . s:q1(l:query) . (empty(l:path) ? '' : ' ' . s:q1(l:path))
  return call('fzf#vim#ag_raw', insert(l:args, l:command, 0))
endfunction

" rg command suffix, [options]
function! rubix#fzf#rg_raw(command_suffix, ...) abort
  return call('fzf#vim#grep', extend(['rg --no-heading --vimgrep --smart-case --follow --color always '.a:command_suffix, 1], a:000))
endfunction

function! rubix#fzf#rg_repeat(...) abort
  return call('rubix#fzf#rg', extend(copy(s:last), copy(a:000)))
endfunction

function! rubix#fzf#ag_repeat(...) abort
  return call('rubix#fzf#ag', extend(copy(s:last), copy(a:000)))
endfunction

function! rubix#fzf#history(...) abort
  return s:fzf('history-files', {
  \ 'source':  reverse(s:all_files_filtered()),
  \ 'options': '-m --prompt "Hist> " --no-sort'
  \}, a:000)
endfunction

function! s:is_doc_file(file) abort
  if !exists('s:docdirs')
    let s:docdirs = map(split(&runtimepath, ','), 'resolve(v:val . ''/doc'')')
  endif

  return index(s:docdirs, fnamemodify(a:file, ':p:h')) >= 0
endfunction

" ---- filter out help docs, modified from fzf.vim/autoload/fzf/vim.vim ----
function! s:all_files_filtered() abort
  let s:files = s:all_files()

  " filter out doc files
  call filter(s:files, '!s:is_doc_file(v:val)')

  " shorten the displayed filenames
  return map(s:files, 'fnamemodify(v:val, '':~:.'')')
endfunction

function! s:all_files() abort
  let s:oldfiles = filter(reverse(copy(v:oldfiles)), 'filereadable(expand(v:val))')
  let s:listed = filter(map(s:buflisted(), 'resolve(fnamemodify(bufname(v:val), '':p''))'), '!empty(v:val)')

  " remove from oldfiles anything in listed
  call filter(s:oldfiles, 'index(s:listed, v:val) < 0')

  return extend(s:oldfiles, s:listed)
endfunction

function! s:buflisted() abort
  return filter(range(1, bufnr('$')), 'buflisted(v:val) && getbufvar(v:val, ''&filetype'') !=# ''qf''')
endfunction

" ---- the rest copied verbatim from fzf.vim/autoload/fzf/vim.vim ----

function! s:get_color(attr, ...) abort
  for l:group in a:000
    let l:code = synIDattr(synIDtrans(hlID(l:group)), a:attr, 'cterm')
    if l:code =~# '^[0-9]\+$'
      return l:code
    endif
  endfor
  return ''
endfunction

function! s:defaults() abort
  let l:rules = copy(get(g:, 'fzf_colors', {}))
  let l:colors = join(map(items(filter(map(l:rules, 'call(''s:get_color'', v:val)'), '!empty(v:val)')), 'join(v:val, '':'')'), ',')
  return empty(l:colors) ? '' : ('--color='.l:colors)
endfunction

let s:TYPE = {'dict': type({}), 'funcref': type(function('call')), 'string': type('')}

function! s:fzf(name, opts, extra) abort
  let [l:extra, l:bang] = [{}, 0]
  if len(a:extra) <= 1
    let l:first = get(a:extra, 0, 0)
    if type(l:first) == s:TYPE.dict
      let l:extra = l:first
    else
      let l:bang = l:first
    endif
  elseif len(a:extra) == 2
    let [l:extra, l:bang] = a:extra
  else
    throw 'invalid number of arguments'
  endif

  let l:eopts  = has_key(l:extra, 'options') ? remove(l:extra, 'options') : ''
  let l:merged = extend(copy(a:opts), l:extra)
  let l:merged.options = join(filter([s:defaults(), get(l:merged, 'options', ''), l:eopts], '!empty(v:val)'))
  return fzf#run(s:wrap(a:name, l:merged, l:bang))
endfunction

function! s:wrap(name, opts, bang) abort
  " fzf#wrap does not append --expect if sink or sink* is found
  let l:opts = copy(a:opts)
  if get(l:opts, 'options', '') !~# '--expect' && has_key(l:opts, 'sink*')
    let l:Sink = remove(l:opts, 'sink*')
    let l:wrapped = fzf#wrap(a:name, l:opts, a:bang)
    let l:wrapped['sink*'] = l:Sink
  else
    let l:wrapped = fzf#wrap(a:name, l:opts, a:bang)
  endif
  return l:wrapped
endfunction

function! s:warn(message) abort
  echohl WarningMsg
  echom a:message
  echohl None
  return 0
endfunction
