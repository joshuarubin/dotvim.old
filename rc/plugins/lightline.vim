" a light and configurable statusline/tabline
NeoBundle "itchyny/lightline.vim"
NeoBundle "ap/vim-buftabline"

let g:buftabline_show=1
let g:buftabline_numbers=1
let g:buftabline_indicators=1
let g:buftabline_separators=1
let g:lightline_tagbar_disabled=1
let g:lightline_readonly_filetypes = ["help", "vimfiler", "tagbar", "man"]
let g:lightline_filetype_mode_filetypes = ["help", "man", "fzf", "unite", "vimfiler", "tagbar"]
let g:lightline_no_lineinfo_filetypes = ["vimfiler", "fzf", "tagbar"]
let g:lightline_no_fileformat_filetypes = ["fzf", "man", "help", "tagbar", "vimfiler"]
let g:lightline_no_filefilename_filetypes = ["fzf", "vimfiler", "tagbar"]

let g:lightline = {
      \ 'colorscheme': 'apprentice',
      \ 'active': {
      \   'left': [
      \     [ 'mode', 'crypt', 'paste', 'spell' ],
      \     [ 'fugitive' ],
      \     [ 'filename', 'ctrlpmark' ],
      \   ],
      \   'right': [
      \     [ 'syntastic', 'lineinfo' ],
      \     [ 'fileformat' ],
      \     [ 'tagbar', 'filetype' ]
      \   ],
      \ },
      \ 'inactive': {
      \   'left': [
      \     [ ],
      \     [ ],
      \     [ 'fullfilename' ]
      \   ],
      \   'right': [
      \     [ 'lineinfo' ],
      \     [ 'fileformat' ],
      \     [ 'filetype' ]
      \   ]
      \ },
      \ 'component_function': {
      \   'fugitive':     'LightLineFugitive',
      \   'filename':     'LightLineFilename',
      \   'fullfilename': 'LightLineFullFilename',
      \   'fileformat':   'LightLineFileformat',
      \   'filetype':     'LightLineFiletype',
      \   'mode':         'LightLineMode',
      \   'crypt':        'LightLineCrypt',
      \   'spell':        'LightLineSpell',
      \   'paste':        'LightLinePaste',
      \   'tagbar':       'LightLineTagbar',
      \ },
      \ 'component_expand': {
      \   'syntastic': 'SyntasticStatuslineFlag',
      \   'lineinfo':  'LightLineLineInfo',
      \ },
      \ 'component_type': {
      \   'syntastic': 'error',
      \ },
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '', 'right': '' },
      \ 'enable': { 'statusline': 1, 'tabline': 0 },
      \ }

function s:is_filetype_mode_filetype()
  return index(g:lightline_filetype_mode_filetypes, &filetype) >= 0
endfunction

function s:is_no_lineinfo_filetype()
  return index(g:lightline_no_lineinfo_filetypes, &filetype) >= 0
endfunction

function s:is_no_fileformat_filetype()
  return index(g:lightline_no_fileformat_filetypes, &filetype) >= 0
endfunction

function s:is_no_filename_filetype()
  return index(g:lightline_no_filefilename_filetypes, &filetype) >= 0
endfunction

function s:is_readonly_filetype()
  return index(g:lightline_readonly_filetypes, &filetype) >= 0
endfunction

let s:lightline_tagbar_last_lookup_time = 0
let s:lightline_tagbar_last_lookup_val = ''
function! LightLineTagbar()
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

function! StatusLineLineInfo()
  if winwidth(0) < 70
    return ""
  endif

  if s:is_no_lineinfo_filetype()
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

function! LightLineLineInfo()
  return '%{StatusLineLineInfo()}'
endfunction

function! LightLinePaste()
  if &paste
    return "PASTE"
  endif

  return ""
endfunction

function! LightLineSpell()
  if &spell
    return &spelllang
  endif

  return ""
endfunction

function! LightLineCrypt()
  if exists("+key") && !empty(&key)
    return '🔒'
  endif

  return ""
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

  " if &filetype == 'vimfiler'
  "   return vimfiler#get_status_string()
  " endif

  if &filetype == 'unite'
    return get(unite#get_context(), "buffer_name", "")
    " return get(unite#get_context(), "buffer_name", "") . ' | ' . unite#get_status_string()
  endif

  let fname = expand(a:fmt)

  if fname =~ '^term:\/\/'
    return 'term://'
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

function! LightLineFilename()
  return s:filename('%:t') . s:modified() . s:readonly()
endfunction

function! LightLineFullFilename()
  return s:filename('%:f') . s:modified() . s:readonly()
endfunction

function! LightLineFugitive()
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

function! LightLineFiletype()
  if winwidth(0) < 70
    return ""
  endif

  if s:is_no_fileformat_filetype()
    return ""
  endif

  if &filetype !=# ''
    return &filetype
  endif

  return ""
endfunction

function! LightLineFileformat()
  if winwidth(0) < 70
    return ""
  endif

  if s:is_no_fileformat_filetype()
    return ""
  endif

  let status_enc = &enc
  if &fenc !=# ''
    let status_enc = &fenc
  endif

  return status_enc . '[' . &fileformat . ']'
endfunction

function! LightLineMode()
  if s:is_filetype_mode_filetype()
    return toupper(&filetype)
  endif

  let fname = expand('%:t')

  if fname == 'ControlP'
    return 'CTRLP'
  endif

  return lightline#mode()
endfunction

function! CtrlPMark()
  if expand('%:t') =~ 'ControlP' && has_key(g:lightline, 'ctrlp_item')
    call lightline#link('iR'[g:lightline.ctrlp_regex])
    return lightline#concatenate([g:lightline.ctrlp_prev, g:lightline.ctrlp_item
          \ , g:lightline.ctrlp_next], 0)
  endif

  return ''
endfunction

let g:ctrlp_status_func = {
  \ 'main': 'CtrlPStatusFunc_1',
  \ 'prog': 'CtrlPStatusFunc_2',
  \ }

function! CtrlPStatusFunc_1(focus, byfname, regex, prev, item, next, marked)
  let g:lightline.ctrlp_regex = a:regex
  let g:lightline.ctrlp_prev = a:prev
  let g:lightline.ctrlp_item = a:item
  let g:lightline.ctrlp_next = a:next
  return lightline#statusline(0)
endfunction

function! CtrlPStatusFunc_2(str)
  return lightline#statusline(0)
endfunction

let g:tagbar_status_func = 'TagbarStatusFunc'

function! TagbarStatusFunc(current, sort, fname, ...) abort
  return lightline#statusline(0)
endfunction

function! SyntasticCheckHook(errors)
  call lightline#update()
endfunction

let g:unite_force_overwrite_statusline = 0
let g:vimfiler_force_overwrite_statusline = 0
