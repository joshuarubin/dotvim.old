" absolute width of netrw window
let g:netrw_winsize = -30

" do not display info on the top of window
let g:netrw_banner = 0

" tree-view
let g:netrw_liststyle = 3

" show previews in vertical split
let g:netrw_preview = 1

" split below
let g:netrw_alto = 0

" use the previous window to open file
let g:netrw_browse_split = 4

function! s:toggle() abort
  if exists('s:is_open')
    " close it
    unlet s:is_open
    exec 'Lexplore'
    return
  endif

  let s:is_open = 1
  exec 'Lexplore ' . rubix#project_dir()
endfunction

noremap <silent> <c-n> :exec <sid>toggle()<cr>

let g:netrw_sort_sequence = '[\/]$,*,\%(' . join(map(split(&suffixes, ','), 'escape(v:val, ".*$~")'), '\|') . '\)[*@]\=$'

let s:dotfiles = '\(^\|\s\s\)\zs\.\S\+'
let s:escape = 'substitute(escape(v:val, ".$~"), "*", ".*", "g")'

let g:netrw_list_hide =
      \ s:dotfiles .
      \ ',' . join(map(split(&wildignore, ','), '"^".' . s:escape . '. "$"'), ',') .
      \ ',^\.\.\=/\=$' .
      \ ',' . netrw_gitignore#Hide()

let g:netrw_home=GetCacheDir("netrw")
