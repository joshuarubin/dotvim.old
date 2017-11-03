let g:mapleader = ','

if has('shada')
  set shada=!,'1000,<50,s10,h
endif

if has('viminfo')
  set viminfo='1000,<50,s10,h
endif

set encoding=utf-8 " set encoding for text
set dictionary=/usr/share/dict/words
set regexpengine=1

" prefer locally installed python
if executable('/usr/local/bin/python')
  let g:python_host_prog = '/usr/local/bin/python'
endif

if executable('/usr/local/bin/python3')
  let g:python3_host_prog = '/usr/local/bin/python3'
endif

" persistent undo
if has('persistent_undo')
  set undofile
  let &undodir=rubix#cache#dir('undo')
endif

" backups
set backup
let &backupdir=rubix#cache#dir('backup')

" swap files
let &directory=rubix#cache#dir('swap')

if has('termguicolors')
  " belongs in 'gui' but has to be set before plugins are loaded
  if $TERM_PROGRAM !=# 'Apple_Terminal'
    set termguicolors
  endif

  if !has('nvim')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  endif
endif

augroup MyAutoCmd
  autocmd!
augroup END
