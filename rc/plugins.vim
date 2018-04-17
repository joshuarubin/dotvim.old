scriptencoding utf-8

execute 'runtime' 'rc/plugins.pre.vim'

call plug#begin('~/.vim/plugged')

Plug 'Shougo/vimproc.vim', { 'do': 'make' }

" enables surfing through buffers based on viewing history per window
Plug 'ton/vim-bufsurf'

" color hex codes and color names
Plug 'chrisbra/Colorizer'

" completion
Plug 'Shougo/deoplete.nvim',          {'do': function('rubix#UpdateRemotePlugins')}
Plug 'roxma/nvim-yarp',               rubix#plug#cond(!has('nvim'))
Plug 'roxma/vim-hug-neovim-rpc',      rubix#plug#cond(!has('nvim'))
Plug 'zchee/deoplete-go',             { 'do': 'make', 'for': 'go'}
Plug 'Shougo/neco-vim',               { 'for': 'vim' }
Plug 'Shougo/neco-syntax'
Plug 'zchee/deoplete-zsh',            { 'for': 'zsh' }
Plug 'carlitux/deoplete-ternjs',      { 'for': ['javascript', 'jsx', 'javascript.jsx', 'vue'] }
Plug 'mhartington/nvim-typescript',   rubix#plug#cond(has('nvim') && !exists('g:gui_oni'), { 'do': function('rubix#UpdateRemotePlugins'), 'for': 'typescript' })
Plug 'fszymanski/deoplete-emoji'
Plug 'eagletmt/neco-ghc',             { 'for': 'haskell' }
Plug 'zchee/deoplete-jedi',           { 'for': 'python' }
Plug 'Shougo/neoinclude.vim'
Plug 'zchee/deoplete-clang',          { 'for': ['c', 'cpp'] }
Plug 'sebastianmarkow/deoplete-rust', { 'for': 'rust' }

" snippets
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'
Plug 'honza/vim-snippets'

Plug 'Shougo/context_filetype.vim'

" fuzzy finder
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'mileszs/ack.vim'

" dark color scheme
" colorscheme is in ~/.vim/colors with changes from w0ng/vim-hybrid
Plug 'joshuarubin/lightline-hybrid.vim'

" a light and configurable statusline/tabline
Plug 'itchyny/lightline.vim'
Plug 'ap/vim-buftabline'

" helps you to create python code very quickly
Plug 'klen/python-mode', { 'for': 'python' }

" shows recently used files, bookmarks and sessions
Plug 'mhinz/vim-startify'

" syntax checking
Plug 'neomake/neomake' " for Go
Plug 'w0rp/ale'        " for everything else
Plug 'uber/prototool', { 'rtp': 'vim/prototool' }

" text filtering and alignment
Plug 'godlygeek/tabular', { 'on': 'Tabularize' }

" displays tags in a window, ordered by scope http://majutsushi.github.com/tagbar/
Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' }

" textobj
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-indent'
Plug 'kana/vim-textobj-entire'
Plug 'lucapette/vim-textobj-underscore'
Plug 'reedes/vim-textobj-quote'
Plug 'reedes/vim-textobj-sentence'
Plug 'wellle/targets.vim'

Plug 'christoomey/vim-tmux-navigator',     rubix#plug#cond(exists('$TMUX'))
Plug 'tmux-plugins/vim-tmux-focus-events', rubix#plug#cond(exists('$TMUX'))

" display your undo history in a graph
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }

" tpope
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-endwise'

Plug 'gregsexton/gitv', { 'on': 'Gitv' }

" full featured go development environment support for vim
Plug 'fatih/vim-go', { 'for': 'go' }

" a collection of language packs for vim, forked from sheerun/vim-polyglot
Plug 'sheerun/vim-polyglot'

" other language packs
Plug 'hail2u/vim-css3-syntax'
Plug 'chrisbra/csv.vim'
Plug 'zchee/vim-flatbuffers'
Plug 'jparise/vim-graphql'
Plug 'Glench/Vim-Jinja2-Syntax'
Plug 'othree/javascript-libraries-syntax.vim'

" use vim as $PAGER
Plug 'rkitover/vimpager', { 'do': 'make; ln -sf man man1' }

" personal wiki for vim
Plug 'vimwiki/vimwiki'

" distraction-free writing in vim
Plug 'junegunn/goyo.vim'

" matchparen for html tags
Plug 'gregsexton/MatchTag', { 'for': ['html', 'xml'] }

" haskell
Plug 'eagletmt/ghcmod-vim', { 'for': 'haskell' }
Plug 'bitc/vim-hdevtools', { 'for': 'haskell' }

" search for selection with '*' in visual mode
Plug 'thinca/vim-visualstar'

" easy to use, file-type sensible comments
Plug 'tomtom/tcomment_vim'

" show indent guides with spaces (listchars already handles tabs)
Plug 'Yggdroot/indentLine', rubix#plug#cond(!exists('g:gui_oni'))

" Add plugins to &runtimepath, and:
" filetype plugin indent on
" syntax enable
call plug#end()

execute 'runtime' 'rc/plugins.post.vim'
