function! Preserve(command)
  " preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " do the business:
  execute a:command
  " clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction

function! MkdirAsNecessary(dir, force)
  if !isdirectory(a:dir) && &l:buftype == '' &&
        \ (a:force || input(printf('"%s" does not exist. Create? [y/N]',
        \              a:dir)) =~? '^y\%[es]$')
    call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
  endif
endfunction

function! AutoStripTrailingWhitespace()
  if exists('b:auto_strip_trailing_whitespace')
    call Preserve("%s/\\s\\+$//e")
  endif
endfunction

function! StripTrailingWhitespace()
  call Preserve("%s/\\s\\+$//e")
endfunction

function! TabRename()
  if exists('*gettabvar')
    let name = input('Tab name: ')
    let t:title = name
  endif
endfunction

let g:lasttab = 1

function! LastTab()
  :execute "tabnext ".g:lasttab
endfunction

command! -nargs=* Only call DeleteHiddenBuffers()
function! DeleteHiddenBuffers()
  " figure out which buffers are visible in any tab
  let visible = {}
  for t in range(1, tabpagenr('$'))
    for b in tabpagebuflist(t)
      let visible[b] = 1
    endfor
  endfor
  " close any buffer that are loaded and not visible
  let l:tally = 0
  for b in range(1, bufnr('$'))
    if bufloaded(b) && !has_key(visible, b) && !getbufvar(b, "&mod")
      let l:tally += 1
      exe 'bw ' . b
    endif
  endfor
  echon "Deleted " . l:tally . " buffers"
endfun

function! NeoSnippetCr()
  " NOTE: use double quotes to properly expand <cr> into escape strings

  if !pumvisible()
    if maparg('<plug>DiscretionaryEnd', 'i') != ''
      " if 'tpope/vim-endwise' is installed
      return "\<cr>\<plug>DiscretionaryEnd"
    endif

    return "\<cr>"
  endif

  if neosnippet#expandable()
    return "\<plug>(neosnippet_expand_or_jump)"
  endif

  return "\<c-y>"
endfunction

function! UltiSnipsTab()
  if pumvisible()
    return "\<c-n>"
  endif

  call UltiSnips#ExpandSnippetOrJump()
  if g:ulti_expand_or_jump_res != 0
    return ""
  endif

  return "\<tab>"
endfunction

function! UltiSnipsCr()
  " NOTE: use double quotes to properly expand <cr> into escape strings

  if !pumvisible()
    if maparg('<plug>DiscretionaryEnd', 'i') != ''
      " if 'tpope/vim-endwise' is installed
      return "\<cr>\<plug>DiscretionaryEnd"
    endif

    return "\<cr>"
  endif

  return "\<c-k>"
endfunction

function! YAPF()
  " preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")

  let l:cmd = 'yapf'

  " Call YAPF with the current buffer
  let l:formatted_text = system(l:cmd, join(getline(1, '$'), "\n") . "\n")

  if v:shell_error != 0 && v:shell_error != 2
    return
  endif

  " Update the buffer.
  execute '1,' . string(line('$')) . 'delete'
  call setline(1, split(l:formatted_text, "\n"))

  " clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction

function! ToggleNetrw() abort
  if exists('s:is_open')
    " close it
    unlet s:is_open
    exec 'Lexplore'
    return
  endif

  let s:is_open = 1
  exec 'Lexplore ' . rubix#project_dir()
endfunction

function! UpdateTitle()
  if &filetype == 'fzf'
    let &titlestring='fzf'
    return
  endif

  if exists('b:term_title')
    let &titlestring='term://'.b:term_title
    return
  endif

  set titlestring=
endfunction

function! Cond(cond, ...)
  let opts = get(a:000, 0, {})
  return a:cond ? opts : extend(opts, { 'on': [], 'for': [] })
endfunction

command! -nargs=* -complete=customlist,ge#complete#complete_package_id ZbDoc :execute rubix#go#doc(<f-args>)
