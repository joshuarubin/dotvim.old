finish " disabled

" visually select increasingly larger regions of text using the same key combination
NeoBundle "terryma/vim-expand-region"

vnoremap + <plug>(expand_region_expand)
vnoremap - <plug>(expand_region_shrink)
