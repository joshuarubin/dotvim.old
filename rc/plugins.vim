execute 'source' fnameescape('~/.vim/rc/plugins.pre.vim')

call plug#begin('~/.vim/plugged')

Plug 'Shougo/vimproc.vim', { 'do': 'make' }

" enables surfing through buffers based on viewing history per window
Plug 'ton/vim-bufsurf'

" color hex codes and color names
Plug 'chrisbra/Colorizer'

" search for terms using [Dash.app](http://kapeli.com/), making API lookups simple
Plug 'rizzatti/funcoo.vim' | Plug 'rizzatti/dash.vim'
" completion
Plug 'Shougo/deoplete.nvim', rubix#plug#cond(g:rubix_complete == 'deoplete', { 'do': ':UpdateRemotePlugins' })
Plug 'zchee/deoplete-go', rubix#plug#cond(g:rubix_complete == 'deoplete', { 'do': 'make' })
Plug 'zchee/deoplete-jedi', rubix#plug#cond(g:rubix_complete == 'deoplete')
Plug 'Shougo/neocomplete.vim', rubix#plug#cond(g:rubix_complete == 'neocomplete')
Plug 'Valloric/YouCompleteMe', rubix#plug#cond(g:rubix_complete == 'youcompleteme', { 'do': './install.py --gocode-completer --clang-completer' })

" snippets
Plug 'Shougo/neosnippet', rubix#plug#cond(g:rubix_snippet == 'neosnippet')
Plug 'Shougo/neosnippet-snippets', rubix#plug#cond(g:rubix_snippet == 'neosnippet')
Plug 'SirVer/ultisnips', rubix#plug#cond(g:rubix_snippet == 'ultisnips')
Plug 'honza/vim-snippets'

" displays function signatures from completions in the command line
Plug 'Shougo/echodoc', rubix#plug#cond(g:rubix_shougo)
Plug 'Shougo/context_filetype.vim', rubix#plug#cond(g:rubix_shougo)

" asynchronous build and test dispatcher
Plug 'tpope/vim-dispatch'

" a git wrapper so awesome, it should be illegal
Plug 'tpope/vim-fugitive'
Plug 'gregsexton/gitv', { 'on': 'Gitv' }

" fuzzy finder
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

" dark color scheme
" colorscheme is in ~/.vim/colors with changes from w0ng/vim-hybrid
Plug 'cocopon/lightline-hybrid.vim'

" awesome python autocompletion
Plug 'davidhalter/jedi-vim', rubix#plug#cond(g:rubix_jedi, { 'for': 'python' })

" a light and configurable statusline/tabline
Plug 'itchyny/lightline.vim'
Plug 'ap/vim-buftabline'

" helps you to create python code very quickly
Plug 'klen/python-mode', rubix#plug#cond(g:rubix_python_mode, { 'for': 'python' })

" run a command and show its result quickly
Plug 'thinca/vim-quickrun'

Plug 'racer-rust/vim-racer', rubix#plug#cond(g:rubix_rust_racer, { 'for': 'rust' })

" shows recently used files, bookmarks and sessions
Plug 'mhinz/vim-startify'

" quoting/parenthesizing made simple
Plug 'tpope/vim-surround'

" syntax checking
Plug 'scrooloose/syntastic', rubix#plug#cond(g:rubix_syntax == 'syntastic')
Plug 'neomake/neomake', rubix#plug#cond(g:rubix_syntax == 'neomake')

" text filtering and alignment
Plug 'godlygeek/tabular', { 'on': 'Tabularize' }

" displays tags in a window, ordered by scope http://majutsushi.github.com/tagbar/
Plug 'majutsushi/tagbar'

" use ‘curly’ quote characters, depends on kana/vim-textobject-user
Plug 'reedes/vim-textobj-quote'

" improving on vim's native sentence text object and motion, depends on kana/vim-textobject-user
Plug 'reedes/vim-textobj-sentence'

Plug 'christoomey/vim-tmux-navigator', rubix#plug#cond(exists('$TMUX'))
Plug 'tmux-plugins/vim-tmux-focus-events', rubix#plug#cond(exists('$TMUX'))

" display your undo history in a graph
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }

" pairs of handy bracket mappings
Plug 'tpope/vim-unimpaired'

" shows a git diff in the gutter
Plug 'airblade/vim-gitgutter'

" full featured go development environment support for vim
Plug 'fatih/vim-go'
Plug 'garyburd/go-explorer'
Plug 'godoctor/godoctor.vim'

" lua
Plug 'xolox/vim-misc' | Plug 'xolox/vim-lua-ftplugin', { 'for': 'lua' }

" a collection of language packs for vim, forked from sheerun/vim-polyglot
Plug 'joshuarubin/vim-polyglot'

" use vim as $PAGER
Plug 'rkitover/vimpager', { 'do': 'make; ln -s man man1' }

" enable repeating supported plugin maps with '.'
Plug 'tpope/vim-repeat'

" sugar for the unix shell commands
Plug 'tpope/vim-eunuch'

" simplifies the transition between multi-line and single-line code
Plug 'AndrewRadev/splitjoin.vim'

" matchparen for html tags
Plug 'gregsexton/MatchTag', { 'for': ['html', 'xml'] }

" format your css using cssfmt inside vim
Plug 'kewah/vim-cssfmt', { 'for': ['css', 'scss'] }

" haskell
Plug 'eagletmt/neco-ghc', { 'for': 'haskell' }
Plug 'eagletmt/ghcmod-vim', { 'for': 'haskell' }
Plug 'bitc/vim-hdevtools', { 'for': 'haskell' }

" search for selection with '*' in visual mode
Plug 'thinca/vim-visualstar'

" easy to use, file-type sensible comments
Plug 'tomtom/tcomment_vim'

" painlessly create your own text objects
Plug 'kana/vim-textobj-user'

" text objects for indented blocks of lines, depends on kana/vim-textobj-user
Plug 'kana/vim-textobj-indent'

" text objects for entire buffer
Plug 'kana/vim-textobj-entire'

" underscore text-object
Plug 'lucapette/vim-textobj-underscore'

" easily search for, substitute, and abbreviate multiple variants of a word
Plug 'tpope/vim-abolish'

" :substitute preview
Plug 'osyo-manga/vim-over'

" automatically add 'end', 'endfunction', 'endif', etc.
Plug 'tpope/vim-endwise'

" show indent guides with spaces (listchars already handles tabs)
Plug 'Yggdroot/indentLine'

" Add plugins to &runtimepath, and:
" filetype plugin indent on
" syntax enable
call plug#end()

execute 'source' fnameescape('~/.vim/rc/plugins.post.vim')
