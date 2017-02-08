scriptencoding utf-8

function! rubix#lightline#mode()
  if s:is_filetype_mode_filetype()
    return toupper(&filetype)
  endif

  let l:fname = expand('%:t')

  if l:fname ==# 'ControlP'
    return 'CTRLP'
  endif

  return lightline#mode()
endfunction

function! rubix#lightline#crypt()
  if exists('+key') && !empty(&key)
    return '🔒'
  endif

  return ''
endfunction

function! rubix#lightline#fugitive()
  try
    if expand('%:t') =~# 'Tagbar'
      return ''
    endif

    if s:is_readonly_filetype()
      return ''
    endif

    if exists('*fugitive#head')
      let l:mark = ''
      let l:branch = fugitive#head()

      if l:branch !=# ''
        return l:mark . ' ' . l:branch
      endif
    endif

  catch
  endtry

  return ''
endfunction

function! rubix#lightline#filename()
  return s:filename('%:.') . s:modified() . s:readonly()
endfunction

function! rubix#lightline#full_filename()
  return s:filename('%:p') . s:modified() . s:readonly()
endfunction

function! rubix#lightline#fileformat()
  if winwidth(0) < 70
    return ''
  endif

  if s:is_no_fileformat_filetype()
    return ''
  endif

  let l:fname = expand('%:f')

  if l:fname =~# '^term:\/\/'
    return ''
  endif

  let l:status_enc = &encoding
  if &fileencoding !=# ''
    let l:status_enc = &fileencoding
  endif

  return l:status_enc . '[' . &fileformat . ']'
endfunction

function! rubix#lightline#filetype()
  if winwidth(0) < 70
    return ''
  endif

  if s:is_no_fileformat_filetype()
    return ''
  endif

  if &filetype !=# ''
    return &filetype
  endif

  return ''
endfunction

function! rubix#lightline#spell()
  if &spell
    return &spelllang
  endif

  return ''
endfunction

function! rubix#lightline#paste()
  if &paste
    return 'PASTE'
  endif

  return ''
endfunction

let s:lightline_tagbar_last_lookup_time = 0
let s:lightline_tagbar_last_lookup_val = ''
function! rubix#lightline#tagbar()
  if exists('g:lightline_tagbar_disabled') && g:lightline_tagbar_disabled
    return ''
  endif

  if &filetype =~# 'tagbar'
    return ''
  endif

  if s:lightline_tagbar_last_lookup_time != localtime()
    let s:lightline_tagbar_last_lookup_val = tagbar#currenttag('%s', '')
    let s:lightline_tagbar_last_lookup_time = localtime()
  endif

  return s:lightline_tagbar_last_lookup_val
endfunction

function! rubix#lightline#term_title()
  call rubix#update_title()

  if s:is_no_termtitle_filetype()
    return ''
  endif

  if exists('b:term_title')
    return b:term_title
  endif

  return ''
endfunction

function! rubix#lightline#status_line_info()
  if winwidth(0) < 70
    return ''
  endif

  if s:is_no_lineinfo_filetype()
    return ''
  endif

  let l:fname = expand('%:f')

  if l:fname =~# '^term:\/\/'
    return ''
  endif

  return printf('%3.0f%%  %d/%d☰ :%3d',
    \   round((line('.') * 1.0) / line('$') * 100),
    \   line('.'),
    \   line('$'),
    \   col('.')
    \ )
endfunction

function! rubix#lightline#line_info()
  return '%{rubix#lightline#status_line_info()}'
endfunction

function! rubix#lightline#go_type()
  if &filetype ==# 'go'
    return go#complete#GetInfo()
  endif

  return ''
endfunction

function! rubix#lightline#tagbar_status(current, sort, fname, ...) abort
  return lightline#statusline(0)
endfunction

function! s:is_filetype_mode_filetype()
  return index(g:lightline_filetype_mode_filetypes, &filetype) >= 0
endfunction

function! s:is_no_lineinfo_filetype()
  return index(g:lightline_no_lineinfo_filetypes, &filetype) >= 0
endfunction

function! s:is_no_fileformat_filetype()
  return index(g:lightline_no_fileformat_filetypes, &filetype) >= 0
endfunction

function! s:is_no_termtitle_filetype()
  return index(g:lightline_no_termtitle_filetypes, &filetype) >= 0
endfunction

function! s:is_no_filename_filetype()
  return index(g:lightline_no_filename_filetypes, &filetype) >= 0
endfunction

function! s:is_readonly_filetype()
  return index(g:lightline_readonly_filetypes, &filetype) >= 0
endfunction

function! s:readonly()
  if s:is_readonly_filetype()
    return ''
  endif

  if &readonly
    return ' '
  endif

  return ''
endfunction

function! s:filename(fmt)
  if s:is_no_filename_filetype()
    return ''
  endif

  if &filetype ==# 'help'
    return expand('%:t')
  endif

  let l:fname = expand(a:fmt)

  if l:fname =~# '^term:\/\/'
    " return the 'short filename' (e.g. shell name)
    return s:filename('%:t')
  endif

  if l:fname ==# 'ControlP' && has_key(g:lightline, 'ctrlp_item')
    return g:lightline.ctrlp_item
  endif

  if l:fname !=# ''
    return l:fname
  endif

  return '[No Name]'
endfunction

function! s:modified()
  if s:is_readonly_filetype()
    return ''
  endif

  if &modified
    return '[+]'
  endif

  if &modifiable
    return ''
  endif

  return '[-]'
endfunction

function! rubix#lightline#neomakeerror()
  let l:res = neomake#statusline#LoclistStatus()

  let l:e_w = split(l:res)
  if len(l:e_w) == 2 || match(l:e_w, 'E') > -1
    if exists('$ALACRITTY_PROGRAM')
      return 'E' . matchstr(l:e_w[0], '\d\+')
    else
      return '⨉ ' . matchstr(l:e_w[0], '\d\+')
    endif
  endif

  return ''
endfunction

function! rubix#lightline#neomakewarn()
  let l:res = neomake#statusline#LoclistStatus()

  let l:e_w = split(l:res)
  if len(l:e_w) == 2
    if exists('$ALACRITTY_PROGRAM')
      return 'W' . matchstr(l:e_w[1], '\d\+')
    else
      return '⚠ ' . matchstr(l:e_w[1], '\d\+')
    endif
  endif

  if match(l:e_w, 'W') > -1
    if exists('$ALACRITTY_PROGRAM')
      return 'W' . matchstr(l:e_w[0], '\d\+')
    else
      return '⚠ ' . matchstr(l:e_w[0], '\d\+')
    endif
  endif

  return ''
endfunction

function! rubix#lightline#aleerror()
  let l:res = ale#statusline#Status()
  if l:res ==# 'OK'
    return ''
  endif

  let l:e_w = split(l:res)
  if len(l:e_w) == 2 || match(l:e_w, 'E') > -1
    if exists('$ALACRITTY_PROGRAM')
      return 'E' . matchstr(l:e_w[0], '\d\+')
    else
      return '⨉ ' . matchstr(l:e_w[0], '\d\+')
    endif
  endif

  return ''
endfunction

function! rubix#lightline#alewarn()
  let l:res = ale#statusline#Status()
  if l:res ==# 'OK'
    return ''
  endif

  let l:e_w = split(l:res)
  if len(l:e_w) == 2
    if exists('$ALACRITTY_PROGRAM')
      return 'W' . matchstr(l:e_w[1], '\d\+')
    else
      return '⚠ ' . matchstr(l:e_w[1], '\d\+')
    endif
  endif

  if match(l:e_w, 'W') > -1
    if exists('$ALACRITTY_PROGRAM')
      return 'W' . matchstr(l:e_w[0], '\d\+')
    else
      return '⚠ ' . matchstr(l:e_w[0], '\d\+')
    endif
  endif

  return ''
endfunction
