function! Preserve(command)
  " preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " do the business:
  execute a:command
  " clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction

" make directory automatically
autocmd MyAutoCmd BufWritePre *
      \ call s:mkdir_as_necessary(expand('<afile>:p:h'), v:cmdbang)

function! s:mkdir_as_necessary(dir, force)
  if !isdirectory(a:dir) && &l:buftype == '' &&
        \ (a:force || input(printf('"%s" does not exist. Create? [y/N]',
        \              a:dir)) =~? '^y\%[es]$')
    call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
  endif
endfunction

" go back to previous position of cursor if any
autocmd MyAutoCmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \  execute 'normal! g`"zvzz' |
  \ endif

set tags=./tags;/,~/.vimtags

" make tags placed in .git/tags file available in all levels of a repository
let gitroot = substitute(system("git rev-parse --show-toplevel"), '[\n\r]', "", "g")
if gitroot != ""
  let &tags = &tags . "," . gitroot . "/.git/tags"
endif

function! AutoStripTrailingWhitespace()
  if exists('b:auto_strip_trailing_whitespace')
    call Preserve("%s/\\s\\+$//e")
  endif
endfunction

function! StripTrailingWhitespace()
  call Preserve("%s/\\s\\+$//e")
endfunction

" automatically strip whitespace trailing on save for these files (add "let
" b:auto_strip_trailing_whitespace = 1" in ftplugin files to enable)
autocmd MyAutoCmd BufWritePre * call AutoStripTrailingWhitespace()

function! TabRename()
  if exists('*gettabvar')
    let name = input('Tab name: ')
    let t:title = name
  endif
endfunction

let g:lasttab = 1

function! LastTab()
  :execute "tabnext ".g:lasttab
endfunction

command! -nargs=* Only call DeleteHiddenBuffers()
function! DeleteHiddenBuffers()
  " figure out which buffers are visible in any tab
  let visible = {}
  for t in range(1, tabpagenr('$'))
    for b in tabpagebuflist(t)
      let visible[b] = 1
    endfor
  endfor
  " close any buffer that are loaded and not visible
  let l:tally = 0
  for b in range(1, bufnr('$'))
    if bufloaded(b) && !has_key(visible, b) && !getbufvar(b, "&mod")
      let l:tally += 1
      exe 'bw ' . b
    endif
  endfor
  echon "Deleted " . l:tally . " buffers"
endfun

autocmd MyAutoCmd InsertEnter * :setlocal nohlsearch
autocmd MyAutoCmd InsertLeave * :setlocal hlsearch
autocmd MyAutoCmd FileType help,man wincmd L
