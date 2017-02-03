function! s:q1(str)
  return "'".substitute(a:str, "'", "'\\\\''", 'g')."'"
endfunction

let s:last = ["", ""]

" query, path, [[rg options], options]
function! rubix#fzf#rg(query, path, ...)
  let s:last = [a:query, a:path]
  if type(a:query) != s:TYPE.string
    return s:warn('Invalid query argument')
  endif
  let query = empty(a:query) ? '^(?=.)' : a:query
  let path = fnamemodify(a:path, ':p:.')
  let args = copy(a:000)
  let rg_opts = len(args) > 1 && type(args[0]) == s:TYPE.string ? remove(args, 0) : ''
  let command = rg_opts . ' ' . s:q1(query) . (empty(path) ? '' : ' ' . s:q1(path))
  return call('rubix#fzf#rg_raw', insert(args, command, 0))
endfunction

" query, path, [[ag options], options]
function! rubix#fzf#ag(query, path, ...)
  let s:last = [a:query, a:path]
  if type(a:query) != s:TYPE.string
    return s:warn('Invalid query argument')
  endif
  let query = empty(a:query) ? '^(?=.)' : a:query
  let path = fnamemodify(a:path, ':p:.')
  let args = copy(a:000)
  let ag_opts = len(args) > 1 && type(args[0]) == s:TYPE.string ? remove(args, 0) : ''
  let command = ag_opts . ' ' . s:q1(query) . (empty(path) ? '' : ' ' . s:q1(path))
  return call('fzf#vim#ag_raw', insert(args, command, 0))
endfunction

" rg command suffix, [options]
function! rubix#fzf#rg_raw(command_suffix, ...)
  return call('fzf#vim#grep', extend(['rg --no-heading --vimgrep --smart-case --follow --color always '.a:command_suffix, 1], a:000))
endfunction

function! rubix#fzf#rg_repeat(...)
  return call('rubix#fzf#rg', extend(copy(s:last), copy(a:000)))
endfunction

function! rubix#fzf#ag_repeat(...)
  return call('rubix#fzf#ag', extend(copy(s:last), copy(a:000)))
endfunction

function! rubix#fzf#history(...)
  return s:fzf('history-files', {
  \ 'source':  reverse(s:all_files_filtered()),
  \ 'options': '-m --prompt "Hist> "'
  \}, a:000)
endfunction

" ---- filter out help docs, modified from fzf.vim/autoload/fzf/vim.vim ----
function! s:all_files_filtered()
  return filter(map(s:all_files(), 'resolve(fnamemodify(v:val, ":p"))'),
  \ 'index(map(split(&rtp, ","), "resolve(v:val . \"/doc\")"), fnamemodify(v:val, ":p:h")) < 0')
endfunction

" ---- the rest copied verbatim from fzf.vim/autoload/fzf/vim.vim ----

function! s:all_files()
  return extend(
  \ filter(reverse(copy(v:oldfiles)), "filereadable(expand(v:val))"),
  \ filter(map(s:buflisted(), 'bufname(v:val)'), '!empty(v:val)'))
endfunction

function! s:buflisted()
  return filter(range(1, bufnr('$')), 'buflisted(v:val) && getbufvar(v:val, "&filetype") != "qf"')
endfunction

function! s:get_color(attr, ...)
  for group in a:000
    let code = synIDattr(synIDtrans(hlID(group)), a:attr, 'cterm')
    if code =~ '^[0-9]\+$'
      return code
    endif
  endfor
  return ''
endfunction

function! s:defaults()
  let rules = copy(get(g:, 'fzf_colors', {}))
  let colors = join(map(items(filter(map(rules, 'call("s:get_color", v:val)'), '!empty(v:val)')), 'join(v:val, ":")'), ',')
  return empty(colors) ? '' : ('--color='.colors)
endfunction

let s:TYPE = {'dict': type({}), 'funcref': type(function('call')), 'string': type('')}

function! s:fzf(name, opts, extra)
  let [extra, bang] = [{}, 0]
  if len(a:extra) <= 1
    let first = get(a:extra, 0, 0)
    if type(first) == s:TYPE.dict
      let extra = first
    else
      let bang = first
    endif
  elseif len(a:extra) == 2
    let [extra, bang] = a:extra
  else
    throw 'invalid number of arguments'
  endif

  let eopts  = has_key(extra, 'options') ? remove(extra, 'options') : ''
  let merged = extend(copy(a:opts), extra)
  let merged.options = join(filter([s:defaults(), get(merged, 'options', ''), eopts], '!empty(v:val)'))
  return fzf#run(s:wrap(a:name, merged, bang))
endfunction

function! s:wrap(name, opts, bang)
  " fzf#wrap does not append --expect if sink or sink* is found
  let opts = copy(a:opts)
  if get(opts, 'options', '') !~ '--expect' && has_key(opts, 'sink*')
    let Sink = remove(opts, 'sink*')
    let wrapped = fzf#wrap(a:name, opts, a:bang)
    let wrapped['sink*'] = Sink
  else
    let wrapped = fzf#wrap(a:name, opts, a:bang)
  endif
  return wrapped
endfunction
