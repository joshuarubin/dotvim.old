if executable("racer") && !empty($RUST_SRC_PATH)
  NeoBundleLazy "racer-rust/vim-racer", {"autoload": {"filetypes": ["rust"]}}
endif
