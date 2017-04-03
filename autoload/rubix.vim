function! rubix#current_dir() abort
  return fnamemodify(getcwd(), ':p')
endfunction

function! rubix#buffer_dir() abort
  return s:get_buffer_directory(bufnr('%'))
endfunction

function! rubix#project_dir() abort
  return s:path2project_directory(rubix#buffer_dir())
endfunction

function! rubix#input_dir() abort
    return s:parse_source_path(input('Input directory: ', '', 'dir'))
endfunction

function! rubix#input_word() abort
  return input('Input text: ', '')
endfunction

""" helpers taken from unite.vim

function! s:escape_file_searching(buffer_name) abort
  return escape(a:buffer_name, '*[]?{}, ')
endfunction

function! s:path2directory(path) abort
  return isdirectory(a:path) ? a:path : fnamemodify(a:path, ':p:h')
endfunction

function! s:_path2project_directory_git(path) abort
  let l:parent = a:path

  while 1
    let l:path = l:parent . '/.git'
    if isdirectory(l:path) || filereadable(l:path)
      return l:parent
    endif
    let l:next = fnamemodify(l:parent, ':h')
    if l:next == l:parent
      return ''
    endif
    let l:parent = l:next
  endwhile
endfunction

function! s:_path2project_directory_svn(path) abort
  let l:search_directory = a:path
  let l:directory = ''

  let l:find_directory = s:escape_file_searching(l:search_directory)
  let l:d = finddir('.svn', l:find_directory . ';')
  if l:d ==# ''
    return ''
  endif

  let l:directory = fnamemodify(l:d, ':p:h:h')

  " Search parent directories.
  let l:parent_directory = s:path2directory(
        \ fnamemodify(l:directory, ':h'))

  if l:parent_directory !=# ''
    let l:d = finddir('.svn', l:parent_directory . ';')
    if l:d !=# ''
      let l:directory = s:_path2project_directory_svn(l:parent_directory)
    endif
  endif
  return l:directory
endfunction

function! s:_path2project_directory_others(vcs, path) abort
  let l:vcs = a:vcs
  let l:search_directory = a:path

  let l:find_directory = s:escape_file_searching(l:search_directory)
  let l:d = finddir(l:vcs, l:find_directory . ';')
  if l:d ==# ''
    return ''
  endif
  return fnamemodify(l:d, ':p:h:h')
endfunction

function! s:path2project_directory(path, ...) abort
  let l:is_allow_empty = get(a:000, 0, 0)
  let l:search_directory = s:path2directory(a:path)
  let l:directory = ''

  " Search VCS directory.
  for l:vcs in ['.git', '.bzr', '.hg', '.svn']
    if l:vcs ==# '.git'
      let l:directory = s:_path2project_directory_git(l:search_directory)
    elseif l:vcs ==# '.svn'
      let l:directory = s:_path2project_directory_svn(l:search_directory)
    else
      let l:directory = s:_path2project_directory_others(l:vcs, l:search_directory)
    endif
    if l:directory !=# ''
      break
    endif
  endfor

  " Search project file.
  if l:directory ==# ''
    for l:d in ['build.xml', 'prj.el', '.project', 'pom.xml', 'package.json',
          \ 'Makefile', 'configure', 'Rakefile', 'NAnt.build',
          \ 'P4CONFIG', 'tags', 'gtags']
      let l:d = findfile(l:d, s:escape_file_searching(l:search_directory) . ';')
      if l:d !=# ''
        let l:directory = fnamemodify(l:d, ':p:h')
        break
      endif
    endfor
  endif

  if l:directory ==# ''
    " Search /src/ directory.
    let l:base = l:search_directory
    if l:base =~# '/src/'
      let l:directory = l:base[: strridx(l:base, '/src/') + 3]
    endif
  endif

  if l:directory ==# '' && !l:is_allow_empty
    " Use original path.
    let l:directory = l:search_directory
  endif

  return l:directory
endfunction

function! s:get_buffer_directory(bufnr) abort
  return s:path2directory(bufname(a:bufnr))
endfunction

function! s:expand(path) abort
  return (a:path =~# '^\~') ? fnamemodify(a:path, ':p') :
       \ (a:path =~# '^\$\h\w*') ? substitute(a:path,
       \            '^\$\h\w*', '\=eval(submatch(0))', '') :
       \ a:path
endfunction

function! s:parse_source_path(path) abort
  " Expand ?!/buffer_project_subdir, !/project_subdir and ?/buffer_subdir
  if a:path =~# '^?!'
    " Use project directory from buffer directory
    let l:path = rubix#project_dir() . a:path[2:]
  elseif a:path =~# '^!'
    " Use project directory from cwd
    let l:path = getcwd()
    let l:path = s:path2project_directory(l:path) . a:path[1:]
  elseif a:path =~# '^?'
    " Use buffer directory
    let l:path = rubix#buffer_dir() . a:path[1:]
  else
    let l:path = a:path
  endif

  " Don't assume empty path means current directory.
  " Let the sources customize default rules.
  if l:path !=# ''
    let l:pathlist = l:path =~# "\n" ? split(l:path, "\n") : [l:path]
    for l:pathitem in l:pathlist
      " resolve .. in the paths
      let l:pathitem = resolve(fnamemodify(s:expand(l:pathitem), ':p'))
    endfor
    let l:path = join(l:pathlist, "\n")
  endif

  return l:path
endfunction

function! rubix#preserve(command) abort
  " preparation: save last search, and cursor position.
  let l:_s=@/
  let l:l = line('.')
  let l:c = col('.')
  " do the business:
  execute a:command
  " clean up: restore previous search history, and cursor position
  let @/=l:_s
  call cursor(l:l, l:c)
endfunction

function! rubix#mkdir(dir, force) abort
  if !isdirectory(a:dir) && &l:buftype ==# '' &&
        \ (a:force || input(printf('"%s" does not exist. Create? [y/N]',
        \              a:dir)) =~? '^y\%[es]$')
    call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
  endif
endfunction

function! rubix#auto_trim() abort
  if exists('b:auto_strip_trailing_whitespace')
    call rubix#trim()
  endif
endfunction

function! rubix#trim() abort
  call rubix#preserve("%s/\\s\\+$//e")
endfunction

function! rubix#maximize_toggle() abort
  let l:curpos = getcurpos()
  if tabpagenr() == 1
    tabedit %
  else
    tabclose
  endif
  call setpos('.', l:curpos)
endfunction

function! rubix#only() abort
  " figure out which buffers are visible in any tab
  let l:visible = {}
  for l:t in range(1, tabpagenr('$'))
    for l:b in tabpagebuflist(l:t)
      let l:visible[l:b] = 1
    endfor
  endfor

  " close any buffer that are loaded and not visible
  let l:tally = 0
  for l:b in range(1, bufnr('$'))
    if bufexists(l:b) && !has_key(l:visible, l:b) && !getbufvar(l:b, '&mod')
      let l:tally += 1
      exe 'bw ' . l:b
    endif
  endfor
  echon 'Deleted ' . l:tally . ' buffers'
endfun

function! rubix#neosnippet_cr() abort
  " NOTE: use double quotes to properly expand <cr> into escape strings

  if !pumvisible()
    if maparg('<plug>DiscretionaryEnd', 'i') !=# ''
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

function! rubix#ultisnips_tab() abort
  if pumvisible()
    return "\<c-n>"
  endif

  call UltiSnips#ExpandSnippetOrJump()
  if g:ulti_expand_or_jump_res != 0
    return ''
  endif

  return "\<tab>"
endfunction

function! rubix#ultisnips_cr() abort
  " NOTE: use double quotes to properly expand <cr> into escape strings

  if !pumvisible()
    if maparg('<plug>DiscretionaryEnd', 'i') !=# ''
      " if 'tpope/vim-endwise' is installed
      return "\<cr>\<plug>DiscretionaryEnd"
    endif

    return "\<cr>"
  endif

  return "\<c-k>"
endfunction

function! rubix#yapf() abort
  " preparation: save last search, and cursor position.
  let l:_s=@/
  let l:l = line('.')
  let l:c = col('.')

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
  let @/=l:_s
  call cursor(l:l, l:c)
endfunction

function! rubix#prettier() abort
  " preparation: save last search, and cursor position.
  let l:_s=@/
  let l:l = line('.')
  let l:c = col('.')

  " write the buffer to a temp file
  let l:tmp = fnameescape(tempname())
  silent execute 'noautocmd write ' . l:tmp

  " Call prettier with temp file
  let l:out = system('prettier --write ' . l:tmp)
  if v:shell_error != 0
    echoerr l:out
    call delete(l:tmp)
    return
  endif

  " Call standard to fix the issues it can
  let l:out = system('standard --plugin react --plugin flowtype --parser babel-eslint --fix ' . l:tmp)
  " ignore errors, just using this for --fix

  " Clear the old buffer
  execute '1,' . string(line('$')) . 'delete'

  " Read in the new file
  execute '0read' . l:tmp

  " Delete the trailing newline
  execute string(line('$')) . 'delete'

  " Delete the temp file
  call delete(l:tmp)

  " clean up: restore previous search history, and cursor position
  let @/=l:_s
  call cursor(l:l, l:c)
endfunction

function! rubix#toggle_netrw() abort
  if exists('s:is_open')
    " close it
    unlet s:is_open
    exec 'Lexplore'
    return
  endif

  let s:is_open = 1
  exec 'Lexplore ' . rubix#project_dir()
endfunction

function! rubix#update_title() abort
  if &filetype ==# 'fzf'
    let &titlestring='fzf'
    return
  endif

  if exists('b:term_title')
    let &titlestring='term://'.b:term_title
    return
  endif

  set titlestring=
endfunction

"http://vim.wikia.com/wiki/Deleting_a_buffer_without_closing_the_window
"
"here is a more exotic version of my original Kwbd script
"delete the buffer; keep windows; create a scratch buffer if no buffers left
function! rubix#kwbd(kwbdStage) abort
  if(a:kwbdStage == 1)
    if(!buflisted(winbufnr(0)))
      execute ':confirm :bdelete'
      return
    endif

    let s:kwbdBufNum = bufnr('%')
    let s:kwbdWinNum = winnr()
    windo call rubix#kwbd(2)
    execute s:kwbdWinNum . 'wincmd w'
    let s:buflistedLeft = 0
    let s:bufFinalJump = 0
    let l:nBufs = bufnr('$')
    let l:i = 1

    while(l:i <= l:nBufs)
      if(l:i != s:kwbdBufNum)
        if(buflisted(l:i))
          let s:buflistedLeft = s:buflistedLeft + 1
        else
          if(bufexists(l:i) && !strlen(bufname(l:i)) && !s:bufFinalJump)
            let s:bufFinalJump = l:i
          endif
        endif
      endif
      let l:i = l:i + 1
    endwhile

    if(!s:buflistedLeft)
      if(s:bufFinalJump)
        windo if(buflisted(winbufnr(0))) | execute "b! " . s:bufFinalJump | endif
      else
        enew
        let l:newBuf = bufnr('%')
        windo if(buflisted(winbufnr(0))) | execute "b! " . l:newBuf | endif
      endif
      execute s:kwbdWinNum . 'wincmd w'
    endif

    if(buflisted(s:kwbdBufNum) || s:kwbdBufNum == bufnr('%'))
      execute ':confirm :bdelete ' . s:kwbdBufNum
    endif

    if(!s:buflistedLeft)
      set buflisted
      set bufhidden=delete
      set buftype=
      setlocal noswapfile
    endif
  else
    if(bufnr('%') == s:kwbdBufNum)
      let l:prevbufvar = bufnr('#')
      if(l:prevbufvar > 0 && buflisted(l:prevbufvar) && l:prevbufvar != s:kwbdBufNum)
        b #
      else
        bn
      endif
    endif
  endif
endfunction

function! rubix#UpdateRemotePlugins(info) abort
  if has('nvim')
    execute 'UpdateRemotePlugins'
  endif
endfunction
