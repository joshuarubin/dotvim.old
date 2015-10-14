syntax enable

set list

if has("gui_running")
  set listchars=tab:›\ ,trail:•,extends:❯,precedes:❮,nbsp:.
else
  set listchars=tab:\ \ ,trail:•,extends:❯,precedes:❮,nbsp:.
endif

set laststatus=2 " always show the statusline
set title
set linebreak " wrap lines at convenient points
let &showbreak="↪ "
set whichwrap+=<,>,[,]

if exists('+breakindent')
  set breakindent
  set wrap
else
  set nowrap
endif

set shortmess+=I
set t_vb=
set novisualbell " no sounds

set wildmenu " show list for autocomplete
set wildmode=list:longest,full


if v:version > 703 || v:version == 703 && has("patch072")
  set wildignorecase
endif

" stuff to ignore when tab completing
set wildignore+=
      \*.o,
      \*.obj,
      \*~,
      \*/log/*,
      \*/tmp/*,
      \*/vendor/*,
      \*/Godeps/*,
      \*/node_modules/*,
      \*/bower_components/*,
      \*.png,
      \*.jpg,
      \*.gif,
      \*.so,
      \*.swp,
      \*.zip,
      \*.pdf,
      \*/.Trash/**,
      \*/.hg/**,
      \*/.svn/**,
      \*/.idea/**,
      \*/.DS_Store

set history=1000 " store lots of :cmdline history
set showfulltag
set completeopt=longest,menuone " auto complete setting
set nospell
set splitright
set splitbelow
set winheight=50 " sensible heights for splits
set winminheight=0
set ttyfast " assume fast terminal connection

if has("conceal")
  set conceallevel=1
  set listchars+=conceal:Δ
endif

set noshowmode

set ruler
set showcmd                     " show incomplete cmds down the bottom
set number                      " line numbers are good
set scrolloff=8                 " start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1
set scrolljump=3
set numberwidth=1
