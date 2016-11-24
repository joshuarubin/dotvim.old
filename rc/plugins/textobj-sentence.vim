" improving on vim's native sentence text object and motion, depends on kana/vim-textobject-user
Plug 'reedes/vim-textobj-sentence'

augroup textobj_sentence
  autocmd!
  autocmd FileType markdown call textobj#sentence#init()
  autocmd FileType textile  call textobj#sentence#init()
  autocmd FileType text     call textobj#sentence#init()
augroup end
