function! rubix#lightline#mode()
  if s:is_filetype_mode_filetype()
    return toupper(&filetype)
  endif

  let fname = expand('%:t')

  if fname == 'ControlP'
    return 'CTRLP'
  endif

  return lightline#mode()
endfunction

function! rubix#lightline#crypt()
  if exists("+key") && !empty(&key)
    return '🔒'
  endif

  return ""
endfunction

function! rubix#lightline#fugitive()
  try
    if expand('%:t') =~ 'Tagbar'
      return ""
    endif

    if s:is_readonly_filetype()
      return ""
    endif

    if exists('*fugitive#head')
      let mark = ''
      let branch = fugitive#head()

      if branch != ''
        return mark . ' ' . branch
      endif
    endif

  catch
  endtry

  return ""
endfunction

function! rubix#lightline#filename()
  return s:filename('%:.') . s:modified() . s:readonly()
endfunction

function! rubix#lightline#full_filename()
  return s:filename('%:p') . s:modified() . s:readonly()
endfunction

function! rubix#lightline#fileformat()
  if winwidth(0) < 70
    return ""
  endif

  if s:is_no_fileformat_filetype()
    return ""
  endif

  let fname = expand('%:f')

  if fname =~ '^term:\/\/'
    return ""
  endif

  let status_enc = &enc
  if &fenc !=# ''
    let status_enc = &fenc
  endif

  return status_enc . '[' . &fileformat . ']'
endfunction

function! rubix#lightline#filetype()
  if winwidth(0) < 70
    return ""
  endif

  if s:is_no_fileformat_filetype()
    return ""
  endif

  let fname = expand('%:f')

  if &filetype !=# ''
    return &filetype
  endif

  return ""
endfunction

function! rubix#lightline#spell()
  if &spell
    return &spelllang
  endif

  return ""
endfunction

function! rubix#lightline#paste()
  if &paste
    return "PASTE"
  endif

  return ""
endfunction

let s:lightline_tagbar_last_lookup_time = 0
let s:lightline_tagbar_last_lookup_val = ''
function! rubix#lightline#tagbar()
  if exists('g:lightline_tagbar_disabled') && g:lightline_tagbar_disabled
    return ""
  endif

  if &filetype =~ 'tagbar'
    return ""
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
    return ""
  endif

  if exists('b:term_title')
    return b:term_title
  endif

  return ""
endfunction

function! rubix#lightline#status_line_info()
  if winwidth(0) < 70
    return ""
  endif

  if s:is_no_lineinfo_filetype()
    return ""
  endif

  let fname = expand('%:f')

  if fname =~ '^term:\/\/'
    return ""
  endif

  " return '%3p%%  %l/%L☰ :%3v'
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
  if &filetype == 'go'
    return go#complete#GetInfo()
  endif

  return ""
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
    return ""
  endif

  if &readonly
    return " "
  endif

  return ""
endfunction

function! s:filename(fmt)
  if s:is_no_filename_filetype()
    return ""
  endif

  let fname = expand(a:fmt)

  if fname =~ '^term:\/\/'
    " return the "short filename" (e.g. shell name)
    return s:filename('%:t')
  endif

  if fname == 'ControlP' && has_key(g:lightline, 'ctrlp_item')
    return g:lightline.ctrlp_item
  endif

  if fname != ''
    return fname
  endif

  return '[No Name]'
endfunction

function! s:modified()
  if s:is_readonly_filetype()
    return ""
  endif

  if &modified
    return "[+]"
  endif

  if &modifiable
    return ""
  endif

  return "[-]"
endfunction
