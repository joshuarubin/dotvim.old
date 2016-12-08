let g:buftabline_show=1
let g:buftabline_numbers=1
let g:buftabline_indicators=1
let g:buftabline_separators=1

let g:lightline_tagbar_disabled=1
let g:lightline_readonly_filetypes = ["help", "tagbar", "man", "qf"]
let g:lightline_filetype_mode_filetypes = ["help", "man", "fzf", "tagbar", "qf"]
let g:lightline_no_lineinfo_filetypes = ["fzf", "tagbar"]
let g:lightline_no_fileformat_filetypes = ["fzf", "man", "help", "tagbar", "qf"]
let g:lightline_no_filename_filetypes = ["fzf", "tagbar", "qf"]
let g:lightline_no_termtitle_filetypes = ["fzf"]

let g:lightline = {
      \ 'colorscheme': 'hybrid',
      \ 'active': {
      \   'left': [
      \     [ 'mode', 'crypt', 'paste', 'spell' ],
      \     [ 'fugitive' ],
      \     [ 'filename', 'termtitle' ],
      \   ],
      \   'right': [
      \     [ 'neomake', 'syntastic', 'lineinfo' ],
      \     [ 'fileformat' ],
      \     [ 'gojob', 'gotype', 'tagbar', 'filetype' ]
      \   ],
      \ },
      \ 'inactive': {
      \   'left': [
      \     [ ],
      \     [ ],
      \     [ 'fullfilename', 'termtitle' ]
      \   ],
      \   'right': [
      \     [ 'lineinfo' ],
      \     [ 'fileformat' ],
      \     [ 'gojob', 'filetype' ]
      \   ]
      \ },
      \ 'component_function': {
      \   'fugitive':     'rubix#lightline#fugitive',
      \   'filename':     'rubix#lightline#filename',
      \   'fullfilename': 'rubix#lightline#full_filename',
      \   'fileformat':   'rubix#lightline#fileformat',
      \   'filetype':     'rubix#lightline#filetype',
      \   'mode':         'rubix#lightline#mode',
      \   'crypt':        'rubix#lightline#crypt',
      \   'spell':        'rubix#lightline#spell',
      \   'paste':        'rubix#lightline#paste',
      \   'tagbar':       'rubix#lightline#tagbar',
      \   'gojob':        'go#jobcontrol#Statusline',
      \   'termtitle':    'rubix#lightline#term_title',
      \ },
      \ 'component_expand': {
      \   'syntastic': 'SyntasticStatuslineFlag',
      \   'neomake':   'neomake#statusline#LoclistStatus',
      \   'lineinfo':  'rubix#lightline#line_info',
      \   'gotype':    'rubix#lightline#go_type',
      \ },
      \ 'component_type': {
      \   'syntastic': 'error',
      \   'neomake':   'error',
      \ },
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '', 'right': '' },
      \ 'enable': { 'statusline': 1, 'tabline': 0 },
      \ }

let g:tagbar_status_func = 'rubix#lightline#tagbar_status'

function! SyntasticCheckHook(errors)
  call lightline#update()
endfunction

autocmd MyAutoCmd User NeomakeCountsChanged call lightline#update()
autocmd MyAutoCmd CursorHold *.go call lightline#update()
