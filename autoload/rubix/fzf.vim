function! s:q1(str)
  return "'".substitute(a:str, "'", "'\\\\''", 'g')."'"
endfunction

" query, path, [[rg options], options]
function! rubix#fzf#rg(query, path, ...)
  let query = empty(a:query) ? '^(?=.)' : a:query
  let path = empty(a:path) ? rubix#current_dir() : a:path
  let args = copy(a:000)
  let rg_opts = len(args) > 1 ? remove(args, 0) : ''
  let command = rg_opts . ' ' . s:q1(query) . ' ' . s:q1(path)
  return call('rubix#fzf#rg_raw', insert(args, command))
endfunction

" query, path, [[ag options], options]
function! rubix#fzf#ag(query, path, ...)
  let query = empty(a:query) ? '^(?=.)' : a:query
  let path = empty(a:path) ? rubix#current_dir() : a:path
  let args = copy(a:000)
  let ag_opts = len(args) > 1 ? remove(args, 0) : ''
  let command = ag_opts . ' ' . s:q1(query) . ' ' . s:q1(path)
  return call('rubix#fzf#ag_raw', insert(args, command))
endfunction

" rg command suffix, [options]
function! rubix#fzf#rg_raw(command_suffix, ...)
  return s:fzf('rg', fzf#vim#wrap({
  \ 'source':  'rg --no-heading --vimgrep --smart-case --follow '.a:command_suffix,
  \ 'sink*':    s:function('s:rg_handler'),
  \ 'options': '--ansi --delimiter : --nth 4..,.. --prompt "rg> " '.
  \            '--multi --bind alt-a:select-all,alt-d:deselect-all '.
  \            '--color hl:68,hl+:110'}), a:000)
endfunction

" ag command suffix, [options]
function! rubix#fzf#ag_raw(command_suffix, ...)
  return s:fzf('ag', fzf#vim#wrap({
  \ 'source':  'ag --nogroup --column --color '.a:command_suffix,
  \ 'sink*':    s:function('s:ag_handler'),
  \ 'options': '--ansi --delimiter : --nth 4..,.. --prompt "Ag> " '.
  \            '--multi --bind alt-a:select-all,alt-d:deselect-all '.
  \            '--color hl:68,hl+:110'}), a:000)
endfunction

function! s:fzf(name, opts, extra)
  let extra  = empty(a:extra) ? fzf#vim#layout() : a:extra[0]
  let eopts  = has_key(extra, 'options') ? remove(extra, 'options') : ''
  let merged = extend(copy(a:opts), extra)
  let merged.options = join(filter([s:defaults(), get(merged, 'options', ''), eopts], '!empty(v:val)'))
  if len(get(g:, 'fzf_history_dir', ''))
    let dir = expand(g:fzf_history_dir)
    if !isdirectory(dir)
      call mkdir(dir, 'p')
    endif
    let merged.options = join(['--history', s:escape(dir.'/'.a:name), merged.options])
  endif
  return fzf#run(merged)
endfunction

if v:version >= 704
  function! s:function(name)
    return function(a:name)
  endfunction
else
  function! s:function(name)
    " By Ingo Karkat
    return function(substitute(a:name, '^s:', matchstr(expand('<sfile>'), '<SNR>\d\+_\zefunction$'), ''))
  endfunction
endif

let s:default_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

function! s:rg_to_qf(line)
  let parts = split(a:line, ':')
  return {'filename': &acd ? fnamemodify(parts[0], ':p') : parts[0], 'lnum': parts[1], 'col': parts[2],
        \ 'text': join(parts[3:], ':')}
endfunction

function! s:ag_to_qf(line)
  let parts = split(a:line, ':')
  return {'filename': &acd ? fnamemodify(parts[0], ':p') : parts[0], 'lnum': parts[1], 'col': parts[2],
        \ 'text': join(parts[3:], ':')}
endfunction

function! s:escape(path)
  return escape(a:path, ' $%#''"\')
endfunction

function! s:open(cmd, target)
  if stridx('edit', a:cmd) == 0 && fnamemodify(a:target, ':p') ==# expand('%:p')
    return
  endif
  execute a:cmd s:escape(a:target)
endfunction

function! s:rg_handler(lines)
  if len(a:lines) < 2
    return
  endif

  let cmd = get(get(g:, 'fzf_action', s:default_action), a:lines[0], 'e')
  let list = map(a:lines[1:], 's:rg_to_qf(v:val)')

  let first = list[0]
  try
    call s:open(cmd, first.filename)
    execute first.lnum
    execute 'normal!' first.col.'|zz'
  catch
  endtry

  if len(list) > 1
    call setqflist(list)
    copen
    wincmd p
  endif
endfunction

function! s:ag_handler(lines)
  if len(a:lines) < 2
    return
  endif

  let cmd = get(get(g:, 'fzf_action', s:default_action), a:lines[0], 'e')
  let list = map(a:lines[1:], 's:ag_to_qf(v:val)')

  let first = list[0]
  try
    call s:open(cmd, first.filename)
    execute first.lnum
    execute 'normal!' first.col.'|zz'
  catch
  endtry

  if len(list) > 1
    call setqflist(list)
    copen
    wincmd p
  endif
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
