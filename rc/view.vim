scriptencoding utf-8

set synmaxcol=256
syntax sync minlines=256

set list

set listchars=tab:\│\ ,trail:•,extends:❯,precedes:❮,nbsp:.
set fillchars=vert:│,fold:-

set laststatus=2 " always show the statusline
set title
set linebreak " wrap lines at convenient points
let &showbreak='=>'
set whichwrap+=<,>,[,]

if exists('+breakindent')
  set breakindent
  set wrap
else
  set nowrap
endif

set shortmess+=Ic
set t_vb=
set novisualbell " no sounds

set wildmenu " show list for autocomplete
set wildmode=list:longest,full

if v:version > 703 || v:version == 703 && has('patch072')
  set wildignorecase
endif

" stuff to ignore when tab completing
set wildignore+=
      \*.o,
      \*.obj,
      \*~,
      \*.so,
      \*.swp,
      \*.DS_Store

set history=1000 " store lots of :cmdline history
set showfulltag
set completeopt=noinsert,menuone,noselect
set nospell
set splitright
set splitbelow
set winheight=10
set winminheight=1
set ttyfast " assume fast terminal connection
set lazyredraw

if has('conceal')
  set conceallevel=2
  set concealcursor=nv
  set listchars+=conceal:Δ
endif

set noshowmode

set ruler
set noshowcmd                   " prevent flicker, lightline shows info anyway
set number                      " line numbers are good
set scrolloff=8                 " start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1
set scrolljump=3
set numberwidth=1

autocmd MyAutoCmd BufEnter * call rubix#update_title()
autocmd MyAutoCmd InsertEnter * setlocal nohlsearch
autocmd MyAutoCmd InsertLeave * setlocal hlsearch

if has('nvim')
  autocmd MyAutoCmd TermOpen * setlocal nolist nonumber norelativenumber sidescrolloff=0 winfixheight
elseif has('terminal')
  autocmd MyAutoCmd TerminalOpen * setlocal nolist nonumber norelativenumber sidescrolloff=0 winfixheight
endif
