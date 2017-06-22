" Note: Skip initialization for vim-tiny or vim-small.
if 0 | endif

execute 'runtime' 'rc/init.vim'
execute 'runtime' 'rc/view.vim'
execute 'runtime' 'rc/plugins.vim'
execute 'runtime' 'rc/edit.vim'
execute 'runtime' 'rc/mappings.vim'
execute 'runtime' 'rc/gui.vim'
execute 'runtime' 'rc/secret.vim'

set exrc   " enable per-directory .vimrc files
set secure " disable unsafe commands in local .vimrc files
