let g:fzf_history_dir = rubix#cache#dir('fzf')
let g:fzf_buffers_jump = 1
let g:fzf_layout = { 'down': '10' }
let g:fzf_nvim_statusline = 0

command! -bang FilesProjectDir call fzf#vim#files(rubix#project_dir(), <bang>0)
command! -bang FilesBufferDir  call fzf#vim#files(rubix#buffer_dir(),  <bang>0)
command! -bang FilesCurrentDir call fzf#vim#files(rubix#current_dir(), <bang>0)
command! -bang FilesInputDir   call fzf#vim#files(rubix#input_dir(),   <bang>0)

command! -bang -nargs=* RgProjectDir call rubix#fzf#rg(<q-args>, rubix#project_dir(), <bang>0)
command! -bang -nargs=* RgBufferDir  call rubix#fzf#rg(<q-args>,  rubix#buffer_dir(), <bang>0)
command! -bang -nargs=* RgCurrentDir call rubix#fzf#rg(<q-args>, rubix#current_dir(), <bang>0)
command! -bang -nargs=* RgInputDir   call rubix#fzf#rg(<q-args>,   rubix#input_dir(), <bang>0)

command! -bang -nargs=* AgProjectDir call rubix#fzf#ag(<q-args>, rubix#project_dir(), <bang>0)
command! -bang -nargs=* AgBufferDir  call rubix#fzf#ag(<q-args>,  rubix#buffer_dir(), <bang>0)
command! -bang -nargs=* AgCurrentDir call rubix#fzf#ag(<q-args>, rubix#current_dir(), <bang>0)
command! -bang -nargs=* AgInputDir   call rubix#fzf#ag(<q-args>,   rubix#input_dir(), <bang>0)

command! -bang RgProjectDirCursor call rubix#fzf#rg(expand('<cword>'), rubix#project_dir(), <bang>0)
command! -bang RgBufferDirCursor  call rubix#fzf#rg(expand('<cword>'), rubix#buffer_dir(),  <bang>0)
command! -bang RgCurrentDirCursor call rubix#fzf#rg(expand('<cword>'), rubix#current_dir(), <bang>0)
command! -bang RgInputDirCursor   call rubix#fzf#rg(expand('<cword>'), rubix#input_dir(),   <bang>0)

command! -bang AgProjectDirCursor call rubix#fzf#ag(expand('<cword>'), rubix#project_dir(), <bang>0)
command! -bang AgBufferDirCursor  call rubix#fzf#ag(expand('<cword>'), rubix#buffer_dir(),  <bang>0)
command! -bang AgCurrentDirCursor call rubix#fzf#ag(expand('<cword>'), rubix#current_dir(), <bang>0)
command! -bang AgInputDirCursor   call rubix#fzf#ag(expand('<cword>'), rubix#input_dir(),   <bang>0)

command! -bang RgProjectDirPrompt call rubix#fzf#rg(rubix#input_word(), rubix#project_dir(), <bang>0)
command! -bang RgBufferDirPrompt  call rubix#fzf#rg(rubix#input_word(), rubix#buffer_dir(),  <bang>0)
command! -bang RgCurrentDirPrompt call rubix#fzf#rg(rubix#input_word(), rubix#current_dir(), <bang>0)
command! -bang RgInputDirPrompt   call rubix#fzf#rg(rubix#input_word(), rubix#input_dir(),   <bang>0)

command! -bang AgProjectDirPrompt call rubix#fzf#ag(rubix#input_word(), rubix#project_dir(), <bang>0)
command! -bang AgBufferDirPrompt  call rubix#fzf#ag(rubix#input_word(), rubix#buffer_dir(),  <bang>0)
command! -bang AgCurrentDirPrompt call rubix#fzf#ag(rubix#input_word(), rubix#current_dir(), <bang>0)
command! -bang AgInputDirPrompt   call rubix#fzf#ag(rubix#input_word(), rubix#input_dir(),   <bang>0)

command! -bang RgRepeat call rubix#fzf#rg_repeat(<bang>0)
command! -bang AgRepeat call rubix#fzf#ag_repeat(<bang>0)
command! -bang RubixHistory call rubix#fzf#history(<bang>0)
