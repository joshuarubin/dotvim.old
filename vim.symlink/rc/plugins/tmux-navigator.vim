" seamless navigation between tmux panes and vim splits
if exists("$TMUX")
  NeoBundle "christoomey/vim-tmux-navigator"

  autocmd MyAutoCmd FileType vimfiler nmap <buffer> <c-l> :TmuxNavigateRight<cr>
  autocmd MyAutoCmd FileType vimfiler nmap <buffer> <c-j> :TmuxNavigateDown<cr>
else
  nmap <c-h> <c-w>h
  nmap <c-j> <c-w>j
  nmap <c-k> <c-w>k
  nmap <c-l> <c-w>l

  autocmd MyAutoCmd FileType vimfiler nmap <buffer> <c-l> :wincmd l<cr>
  autocmd MyAutoCmd FileType vimfiler nmap <buffer> <c-j> :wincmd j<cr>
endif
