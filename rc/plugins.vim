call plug#begin('~/.vim/plugged')

Plug 'Shougo/vimproc.vim', { 'do': 'make' }

function! Cond(cond, ...)
  let opts = get(a:000, 0, {})
  return a:cond ? opts : extend(opts, { 'on': [], 'for': [] })
endfunction

" load plugins with extra configuration
for f in split(glob('~/.vim/rc/plugins/*.vim'), '\n')
  execute 'source' fnameescape(f)
endfor

" enable repeating supported plugin maps with '.'
Plug 'tpope/vim-repeat'

" sugar for the unix shell commands
Plug 'tpope/vim-eunuch'

" simplifies the transition between multi-line and single-line code
Plug 'AndrewRadev/splitjoin.vim'

" automatically closes html tags once you finish typing them
Plug 'amirh/HTML-AutoCloseTag', { 'for': ['html', 'xml'] }

" matchparen for html tags
Plug 'gregsexton/MatchTag', { 'for': ['html', 'xml'] }

" format your css using cssfmt inside vim
Plug 'kewah/vim-cssfmt', { 'for': ['css', 'scss'] }

" haskell
Plug 'eagletmt/ghcmod-vim', { 'for': 'haskell' }
Plug 'bitc/vim-hdevtools', { 'for': 'haskell' }

" contains snippets files for various programming languages
Plug 'honza/vim-snippets'

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

" Add plugins to &runtimepath
call plug#end()

" required
filetype plugin indent on
syntax enable

autocmd MyAutoCmd VimEnter *
  \  if !empty(filter(copy(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall
  \| endif
