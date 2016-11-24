" display your undo history in a graph
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }

" if undotree is opened, it is likely one wants to interact with it
let g:undotree_SetFocusWhenToggle=1
nnoremap <leader>u :UndotreeToggle<cr>
