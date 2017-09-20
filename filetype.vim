if exists('did_load_filetypes')
  finish
endif

augroup filetypedetect
  " TypeScript
  autocmd BufNewFile,BufRead *.ts  set filetype=typescript

  " JavaScript
  autocmd BufNewFile,BufRead *.es6 set filetype=javascript

  " .envrc
  autocmd BufNewFile,BufRead .envrc set filetype=sh
augroup END
