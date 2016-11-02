finish " disabled

" always have a nice view for split windows
NeoBundle "zhaocai/GoldenView.Vim"

" must be recursive
" nmap <f5> <plug>ToggleGoldenViewAutoResize
let g:goldenview__enable_default_mapping = 0
let g:goldenview__enable_at_startup = 1

nmap <silent> <c-\>     <plug>GoldenViewSplit
nmap <silent> <c-n>     <plug>GoldenViewNext
nmap <silent> <c-m>     <plug>GoldenViewPrevious
nmap <silent> <leader>o <plug>GoldenViewSwitchMain
nmap <silent> <leader>p <plug>GoldenViewSwitchToggle

let g:goldenview__ignore_urule = {
    \   'filetype' : [
    \     ''        ,
    \     'qf'      , 'vimpager', 'undotree', 'tagbar',
    \     'nerdtree', 'vimshell', 'vimfiler', 'voom'  ,
    \     'tabman'  , 'unite'   , 'quickrun', 'Decho' ,
    \     'ControlP', 'diff'    , 'extradite'
    \   ],
    \   'buftype' : [
    \     'nofile'  , 'terminal',
    \   ],
    \   'bufname' : [
    \     'GoToFile'                  , 'diffpanel_\d\+'      ,
    \     '__Gundo_Preview__'         , '__Gundo__'           ,
    \     '\[LustyExplorer-Buffers\]' , '\-MiniBufExplorer\-' ,
    \     '_VOOM\d\+$'                , '__Urannotate_\d\+__' ,
    \     '__MRU_Files__' , 'FencView_\d\+$'
    \   ],
    \ }
