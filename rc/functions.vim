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

function! NeoSnippetCr()
  " NOTE: use double quotes to properly expand <cr> into escape strings

  if !pumvisible()
    if maparg('<plug>DiscretionaryEnd', 'i') != ''
      " if 'tpope/vim-endwise' is installed
      return "\<cr>\<plug>DiscretionaryEnd"
    endif

    return "\<cr>"
  endif

  if neosnippet#expandable()
    return "\<plug>(neosnippet_expand_or_jump)"
  endif

  return "\<c-y>"
endfunction

function! UltiSnipsTab()
  if pumvisible()
    return "\<c-n>"
  endif

  call UltiSnips#ExpandSnippetOrJump()
  if g:ulti_expand_or_jump_res != 0
    return ""
  endif

  return "\<tab>"
endfunction

function! UltiSnipsCr()
  " NOTE: use double quotes to properly expand <cr> into escape strings

  if !pumvisible()
    if maparg('<plug>DiscretionaryEnd', 'i') != ''
      " if 'tpope/vim-endwise' is installed
      return "\<cr>\<plug>DiscretionaryEnd"
    endif

    return "\<cr>"
  endif

  return "\<c-k>"
endfunction

function! YAPF()
  " preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")

  let l:cmd = 'yapf'

  " Call YAPF with the current buffer
  let l:formatted_text = system(l:cmd, join(getline(1, '$'), "\n") . "\n")

  if v:shell_error != 0 && v:shell_error != 2
    return
  endif

  " Update the buffer.
  execute '1,' . string(line('$')) . 'delete'
  call setline(1, split(l:formatted_text, "\n"))

  " clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction

function! ToggleNetrw() abort
  if exists('s:is_open')
    " close it
    unlet s:is_open
    exec 'Lexplore'
    return
  endif

  let s:is_open = 1
  exec 'Lexplore ' . rubix#project_dir()
endfunction
