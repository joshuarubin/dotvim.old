" fuzzy finder
NeoBundle "junegunn/fzf"
NeoBundle "junegunn/fzf.vim"

" nnoremap <silent> <c-p> :FZF<cr>

if has("nvim")
  " close fzf with <esc>
  autocmd MyAutoCmd FileType fzf tnoremap <buffer> <esc> <esc>

  " ensure <c-j> and <c-k> work properly within fzf window
  autocmd MyAutoCmd FileType fzf tnoremap <buffer> <c-j> <c-j>
  autocmd MyAutoCmd FileType fzf tnoremap <buffer> <c-k> <c-k>
endif

if has("gui_macvim")
  let g:fzf_launcher = '~/.vim/inanewterm %s'
endif

let g:fzf_history_dir = GetCacheDir("fzf")
let g:fzf_buffers_jump = 1
let g:fzf_layout = { 'down': '10' }
let g:fzf_nvim_statusline = 0
let g:fzf_files_options = '--preview "(coderay {} || cat {}) 2> /dev/null | head -'.&lines.'"'

" maps are recursive where necessary

" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

" map space to the prefix for fzf
nnoremap [fzf] <nop>
nmap <space> [fzf]

command! -bang FilesProjectDir call fzf#vim#files(rubix#project_dir(), fzf#vim#layout(<bang>0))
command! -bang FilesBufferDir  call fzf#vim#files(rubix#buffer_dir(),  fzf#vim#layout(<bang>0))
command! -bang FilesCurrentDir call fzf#vim#files(rubix#current_dir(), fzf#vim#layout(<bang>0))
command! -bang FilesInputDir   call fzf#vim#files(rubix#input_dir(),   fzf#vim#layout(<bang>0))

command! -bang -nargs=* AgProjectDir call rubix#fzf#ag(<q-args>, rubix#project_dir(), fzf#vim#layout(<bang>0))
command! -bang -nargs=* AgBufferDir  call rubix#fzf#ag(<q-args>,  rubix#buffer_dir(), fzf#vim#layout(<bang>0))
command! -bang -nargs=* AgCurrentDir call rubix#fzf#ag(<q-args>, rubix#current_dir(), fzf#vim#layout(<bang>0))
command! -bang -nargs=* AgInputDir   call rubix#fzf#ag(<q-args>,   rubix#input_dir(), fzf#vim#layout(<bang>0))

command! -bang AgProjectDirCursor call rubix#fzf#ag(expand('<cword>'), rubix#project_dir(), fzf#vim#layout(<bang>0))
command! -bang AgBufferDirCursor  call rubix#fzf#ag(expand('<cword>'), rubix#buffer_dir(),  fzf#vim#layout(<bang>0))
command! -bang AgCurrentDirCursor call rubix#fzf#ag(expand('<cword>'), rubix#current_dir(), fzf#vim#layout(<bang>0))
command! -bang AgInputDirCursor   call rubix#fzf#ag(expand('<cword>'), rubix#input_dir(),   fzf#vim#layout(<bang>0))

command! -bang AgProjectDirPrompt call rubix#fzf#ag(rubix#input_word(), rubix#project_dir(), fzf#vim#layout(<bang>0))
command! -bang AgBufferDirPrompt  call rubix#fzf#ag(rubix#input_word(), rubix#buffer_dir(),  fzf#vim#layout(<bang>0))
command! -bang AgCurrentDirPrompt call rubix#fzf#ag(rubix#input_word(), rubix#current_dir(), fzf#vim#layout(<bang>0))
command! -bang AgInputDirPrompt   call rubix#fzf#ag(rubix#input_word(), rubix#input_dir(),   fzf#vim#layout(<bang>0))

" <c-p>, <space>p: Find files in project dir of file in current buffer
nnoremap <silent> <c-p>  :FilesProjectDir<cr>
nnoremap <silent> [fzf]p :FilesProjectDir<cr>

" <c-b>, <space>b: Find buffers
nnoremap <silent> <c-b>  :Buffers<cr>
nnoremap <silent> [fzf]b :Buffers<cr>

" <c-f>, <space>f: Search MRU files
nnoremap <silent> <c-f>  :History<cr>
nnoremap <silent> [fzf]f :History<cr>

" <space>:: Search command history
nnoremap <silent> [fzf]: :History:<cr>

" <space>/: Search search-history
nnoremap <silent> [fzf]/ :History/<cr>

" <c-s><c-d>: (S)earch word in project (d)irectory (prompt for word)
nnoremap <silent> <c-s><c-d> :AgProjectDirPrompt<cr>

" <c-s><c-s>: (S)earch word under cur(s)or in current directory
nnoremap <silent> <c-s><c-s> :AgProjectDirCursor<cr>

" <c-s><c-f>: Quickly (s)earch in (f)ile
nnoremap <silent> <c-s><c-f> :BLines<cr>

" <space>m: Search (normal mode) vim mappings
nnoremap <silent> [fzf]m :Maps<cr>

" <space>c: Search colorschemes
nnoremap <silent> [fzf]c :Colors<cr>

" Tags (tags in the project)
" BTags (tags in the current buffer)
" Lines (search all buffers)
" GFiles (git files)
" Commits (git commits)
" BCommits (git commits current buffer)
" Commands (all vim commands)
" Filetypes (change buffer filetype)
