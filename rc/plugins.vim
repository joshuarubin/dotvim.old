scriptencoding utf-8

execute 'runtime' 'rc/plugins.pre.vim'

call plug#begin('~/.vim/plugged')

Plug 'Shougo/vimproc.vim', { 'do': 'make', 'tag': '*' }

" enables surfing through buffers based on viewing history per window
Plug 'ton/vim-bufsurf', { 'tag': '*' }

" color hex codes and color names
Plug 'chrisbra/Colorizer'

Plug 'roxma/vim-hug-neovim-rpc', rubix#plug#cond(!has('nvim'))
Plug 'roxma/nvim-yarp'

Plug 'Shougo/neoinclude.vim'
Plug 'Shougo/neco-syntax'
Plug 'Shougo/neco-vim', { 'for': 'vim' }
Plug 'Shougo/echodoc.vim'

" language server client
Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh', 'tag': '*' }

" ncm2
Plug 'ncm2/ncm2'
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-path'
Plug 'ncm2/ncm2-syntax'
Plug 'ncm2/ncm2-neoinclude'
Plug 'ncm2/ncm2-ultisnips'
Plug 'ncm2/ncm2-github'
Plug 'ncm2/ncm2-tmux'
Plug 'ncm2/ncm2-tagprefix'
Plug 'ncm2/ncm2-cssomni'
Plug 'ncm2/ncm2-tern', { 'do': 'npm install' }
Plug 'ncm2/ncm2-jedi'
Plug 'ncm2/ncm2-racer'
Plug 'ncm2/ncm2-pyclang'
Plug 'ncm2/ncm2-vim'
Plug 'ncm2/ncm2-html-subscope'
Plug 'ncm2/ncm2-markdown-subscope'
Plug 'ncm2/ncm2-rst-subscope'
Plug 'filipekiss/ncm2-look.vim'
Plug 'mhartington/nvim-typescript', { 'do': './install.sh', 'for': 'typescript' }

" snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets', { 'tag': '*' }

Plug 'Shougo/context_filetype.vim'

" fuzzy finder
Plug 'junegunn/fzf', { 'tag': '*' }
Plug 'junegunn/fzf.vim'
Plug 'mileszs/ack.vim', { 'tag': '*' }

" dark color scheme
" colorscheme is in ~/.vim/colors with changes from w0ng/vim-hybrid
Plug 'joshuarubin/lightline-hybrid.vim'

" a light and configurable statusline/tabline
Plug 'itchyny/lightline.vim'
Plug 'ap/vim-buftabline'

" helps you to create python code very quickly
Plug 'klen/python-mode', { 'for': 'python', 'tag': '*' }

" shows recently used files, bookmarks and sessions
Plug 'mhinz/vim-startify', { 'tag': '*' }

" syntax checking
Plug 'w0rp/ale', { 'tag': '*' }        " for everything else
Plug 'uber/prototool', { 'rtp': 'vim/prototool', 'tag': '*' }

" text filtering and alignment
Plug 'godlygeek/tabular', { 'on': 'Tabularize', 'tag': '*' }

" displays tags in a window, ordered by scope http://majutsushi.github.com/tagbar/
Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle', 'tag': '*' }

" textobj
Plug 'kana/vim-textobj-user', { 'tag': '*' }
Plug 'kana/vim-textobj-indent', { 'tag': '*' }
Plug 'kana/vim-textobj-entire', { 'tag': '*' }
Plug 'lucapette/vim-textobj-underscore'
Plug 'reedes/vim-textobj-quote', { 'tag': '*' }
Plug 'reedes/vim-textobj-sentence', { 'tag': '*' }
Plug 'wellle/targets.vim', { 'tag': '*' }

Plug 'christoomey/vim-tmux-navigator',     rubix#plug#cond(exists('$TMUX'), { 'tag': '*' })
Plug 'tmux-plugins/vim-tmux-focus-events', rubix#plug#cond(exists('$TMUX'), { 'tag': '*' })

" display your undo history in a graph
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle', 'tag': '*' }

" tpope
Plug 'tpope/vim-fugitive', { 'tag': '*' }
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-unimpaired', { 'tag': '*' }
Plug 'tpope/vim-surround', { 'tag': '*' }
Plug 'tpope/vim-repeat', { 'tag': '*' }
Plug 'tpope/vim-eunuch', { 'tag': '*' }
Plug 'tpope/vim-endwise'

Plug 'gregsexton/gitv', { 'on': 'Gitv', 'tag': '*' }

" full featured go development environment support for vim
Plug 'fatih/vim-go', { 'for': ['go', 'gomod'], 'tag': '*' }

" a collection of language packs for vim, forked from sheerun/vim-polyglot
Plug 'sheerun/vim-polyglot', { 'tag': '*' }

" other language packs
Plug 'hail2u/vim-css3-syntax', { 'tag': '*' }
Plug 'chrisbra/csv.vim'
Plug 'zchee/vim-flatbuffers'
Plug 'jparise/vim-graphql', { 'tag': '*' }
Plug 'Glench/Vim-Jinja2-Syntax'
Plug 'othree/javascript-libraries-syntax.vim', { 'tag': '*' }

" use vim as $PAGER
Plug 'rkitover/vimpager', { 'do': 'make; ln -sf man man1', 'tag': '*' }

" personal wiki for vim
Plug 'vimwiki/vimwiki', { 'tag': '*' }

" distraction-free writing in vim
Plug 'junegunn/goyo.vim', { 'tag': '*' }

" matchparen for html tags
Plug 'gregsexton/MatchTag', { 'for': ['html', 'xml'] }

" haskell
Plug 'eagletmt/ghcmod-vim', { 'for': 'haskell', 'tag': '*' }
Plug 'bitc/vim-hdevtools', { 'for': 'haskell' }

" search for selection with '*' in visual mode
Plug 'thinca/vim-visualstar', { 'tag': '*' }

" easy to use, file-type sensible comments
Plug 'tomtom/tcomment_vim', { 'tag': '*' }

" Add plugins to &runtimepath, and:
" filetype plugin indent on
" syntax enable
call plug#end()

execute 'runtime' 'rc/plugins.post.vim'
