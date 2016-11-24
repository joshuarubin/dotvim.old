let g:rubix_rust_racer = 0
if executable('racer') && !empty($RUST_SRC_PATH)
  let g:rubix_rust_racer = 1
endif

Plug 'racer-rust/vim-racer', Cond(g:rubix_rust_racer, { 'for': 'rust' })
