" unite.vim MRU sources, depends on Shougo/unite.vim
NeoBundleLazy "Shougo/neomru.vim", {"autoload":{"unite_sources":["file_mru","directory_mru"]}}

let g:neomru#file_mru_limit = 1000
