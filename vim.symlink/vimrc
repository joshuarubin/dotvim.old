" Note: Skip initialization for vim-tiny or vim-small.
if 0 | endif

if &compatible
  set nocompatible
endif

function! s:source_rc(path)
  execute 'source' fnameescape(expand("~/.vim/rc/" . a:path . ".vim"))
endfunction

call s:source_rc("init")
call s:source_rc("plugins")
call s:source_rc("functions")
call s:source_rc("edit")
call s:source_rc("view")
call s:source_rc("mappings")
call s:source_rc("gui")

set exrc   " enable per-directory .vimrc files
set secure " disable unsafe commands in local .vimrc files
