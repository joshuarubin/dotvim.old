if !has('nvim')
  finish
endif

" fuzzy finder
NeoBundle "junegunn/fzf"
NeoBundle "junegunn/fzf.vim"

" nnoremap <silent> <c-p> :FZF<cr>

" close fzf with <esc>
autocmd MyAutoCmd FileType fzf tnoremap <buffer> <esc> <esc>

" ensure <c-j> and <c-k> work properly within fzf window
autocmd MyAutoCmd FileType fzf tnoremap <buffer> <c-j> <c-j>
autocmd MyAutoCmd FileType fzf tnoremap <buffer> <c-k> <c-k>

let g:fzf_history_dir = GetCacheDir("fzf")
let g:fzf_buffers_jump = 1
let g:fzf_layout = { 'down': '10' }
let g:fzf_nvim_statusline = 0

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

command! -bang FilesProjectDir call rubix#fzf#files#project_dir(fzf#vim#layout(<bang>0))
command! -bang FilesBufferDir  call rubix#fzf#files#buffer_dir(fzf#vim#layout(<bang>0))
command! -bang FilesCurrentDir call rubix#fzf#files#current_dir(fzf#vim#layout(<bang>0))
command! -bang FilesInputDir   call rubix#fzf#files#input_dir(fzf#vim#layout(<bang>0))

command! -bang -nargs=* AgProjectDir call rubix#fzf#ag#project_dir(<q-args>, fzf#vim#layout(<bang>0))
command! -bang -nargs=* AgBufferDir  call rubix#fzf#ag#buffer_dir(<q-args>,  fzf#vim#layout(<bang>0))
command! -bang -nargs=* AgCurrentDir call rubix#fzf#ag#current_dir(<q-args>, fzf#vim#layout(<bang>0))
command! -bang -nargs=* AgInputDir   call rubix#fzf#ag#input_dir(<q-args>,   fzf#vim#layout(<bang>0))

command! -bang AgProjectDirCursor call rubix#fzf#ag#project_dir#cursor(fzf#vim#layout(<bang>0))
command! -bang AgBufferDirCursor  call rubix#fzf#ag#buffer_dir#cursor(fzf#vim#layout(<bang>0))
command! -bang AgCurrentDirCursor call rubix#fzf#ag#current_dir#cursor(fzf#vim#layout(<bang>0))
command! -bang AgInputDirCursor   call rubix#fzf#ag#input_dir#cursor(fzf#vim#layout(<bang>0))

command! -bang AgProjectDirPrompt call rubix#fzf#ag#project_dir#prompt(fzf#vim#layout(<bang>0))
command! -bang AgBufferDirPrompt  call rubix#fzf#ag#buffer_dir#prompt(fzf#vim#layout(<bang>0))
command! -bang AgCurrentDirPrompt call rubix#fzf#ag#current_dir#prompt(fzf#vim#layout(<bang>0))
command! -bang AgInputDirPrompt   call rubix#fzf#ag#input_dir#prompt(fzf#vim#layout(<bang>0))

" <c-p>, <space>p: Find files
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

" ctrl-sf: Quickly (s)earch in (f)ile
nnoremap <silent> <c-s><c-f> :BLines<cr>

" <space>m: Search (normal mode) vim mappings
nnoremap <silent> [fzf]m :Maps<cr>

" <space>c: Search colorschemes
nnoremap <silent> [fzf]c :Colors<cr>

" Lines (search all buffers)
" GFiles (git files)
" Commits (git commits)
" BCommits (git commits current buffer)
" Commands (all vim commands)
" Filetypes (change buffer filetype)
