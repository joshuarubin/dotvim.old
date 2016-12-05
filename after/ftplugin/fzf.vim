" fzf
if has("nvim")
  " close fzf with <esc>
  tnoremap <buffer> <esc> <esc>

  " ensure <c-j> and <c-k> work properly within fzf window
  tnoremap <buffer> <c-j> <c-j>
  tnoremap <buffer> <c-k> <c-k>
endif
