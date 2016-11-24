Plug 'xolox/vim-misc' | Plug 'xolox/vim-lua-ftplugin', { 'for': 'lua' }

let g:lua_check_syntax = 0 " done via syntastic
let g:lua_define_omnifunc = 0 " must be enabled also (g:lua_complete_omni=1, but crashes Vim!)
let g:lua_complete_omni = 0
let g:lua_complete_dynamic = 0 " interferes with YouCompleteMe
