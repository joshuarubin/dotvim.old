set smarttab
set expandtab
set shiftround
set modeline

" use clipboard register
if has('unnamedplus')
  set clipboard& clipboard+=unnamedplus
else
  set clipboard& clipboard+=unnamed
endif

set backspace=indent,eol,start  " allow backspace in insert mode
set noshowmatch                 " don't show matching brackets
set cpoptions-=m
set matchtime=2                 " tens of a second to show matching parentheses
set matchpairs+=<:>
set hidden               " hide buffers when they are abandoned
set autoread             " reload files changed outside vim
set infercase " ignore case on insert completion
" set foldenable
" set foldmethod=syntax
" set foldlevelstart=99

if executable("ag")
  set grepprg=ag\ --nogroup\ --column\ --smart-case\ --nocolor\ --follow
  set grepformat=%f:%l:%c:%m
else
  set grepprg=grep\ -inH
endif

set isfname-== " exclude = from isfilename.

" reload .vimrc automatically
autocmd MyAutoCmd BufWritePost .vimrc,vimrc,*.rc.vim,neobundle.toml
      \ NeoBundleClearCache | source $MYVIMRC | redraw

set timeout timeoutlen=3000 ttimeoutlen=100
set updatetime=100
set virtualedit=block

" check timestamp more for 'autoread'
autocmd MyAutoCmd WinEnter * checktime

" disable paste
autocmd MyAutoCmd InsertLeave *
      \ if &paste | set nopaste mouse=a | echo 'nopaste' | endif |
      \ if &l:diff | diffupdate | endif

" update diff
autocmd MyAutoCmd InsertLeave * if &l:diff | diffupdate | endif

set autoindent
set nrformats-=octal " always assume decimal numbers

set formatoptions=croqlt

if v:version > 703 || v:version == 703 && has("patch541")
  set formatoptions+=j " Delete comment character when joining commented lines
endif

set textwidth=80
set shiftwidth=2
set tabstop=2
set softtabstop=2
set nojoinspaces
set smartindent
set nocopyindent

" search
set ignorecase " case insensitive matching
set smartcase  " smart case matching
set incsearch  " incremental search
set hlsearch
set wrapscan
