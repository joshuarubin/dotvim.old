function! rubix#current_dir()
  return fnamemodify(getcwd(), ':p')
endfunction

function! rubix#buffer_dir()
  return s:get_buffer_directory(bufnr('%'))
endfunction

function! rubix#project_dir()
  return s:path2project_directory(rubix#buffer_dir())
endfunction

function! rubix#input_dir()
    return s:parse_source_path(input('Input directory: ', '', 'dir'))
endfunction

function! rubix#input_word()
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
  let parent = a:path

  while 1
    let path = parent . '/.git'
    if isdirectory(path) || filereadable(path)
      return parent
    endif
    let next = fnamemodify(parent, ':h')
    if next == parent
      return ''
    endif
    let parent = next
  endwhile
endfunction

function! s:_path2project_directory_svn(path) abort
  let search_directory = a:path
  let directory = ''

  let find_directory = s:escape_file_searching(search_directory)
  let d = finddir('.svn', find_directory . ';')
  if d ==# ''
    return ''
  endif

  let directory = fnamemodify(d, ':p:h:h')

  " Search parent directories.
  let parent_directory = s:path2directory(
        \ fnamemodify(directory, ':h'))

  if parent_directory !=# ''
    let d = finddir('.svn', parent_directory . ';')
    if d !=# ''
      let directory = s:_path2project_directory_svn(parent_directory)
    endif
  endif
  return directory
endfunction

function! s:_path2project_directory_others(vcs, path) abort
  let vcs = a:vcs
  let search_directory = a:path

  let find_directory = s:escape_file_searching(search_directory)
  let d = finddir(vcs, find_directory . ';')
  if d ==# ''
    return ''
  endif
  return fnamemodify(d, ':p:h:h')
endfunction

function! s:path2project_directory(path, ...) abort
  let is_allow_empty = get(a:000, 0, 0)
  let search_directory = s:path2directory(a:path)
  let directory = ''

  " Search VCS directory.
  for vcs in ['.git', '.bzr', '.hg', '.svn']
    if vcs ==# '.git'
      let directory = s:_path2project_directory_git(search_directory)
    elseif vcs ==# '.svn'
      let directory = s:_path2project_directory_svn(search_directory)
    else
      let directory = s:_path2project_directory_others(vcs, search_directory)
    endif
    if directory !=# ''
      break
    endif
  endfor

  " Search project file.
  if directory ==# ''
    for d in ['build.xml', 'prj.el', '.project', 'pom.xml', 'package.json',
          \ 'Makefile', 'configure', 'Rakefile', 'NAnt.build',
          \ 'P4CONFIG', 'tags', 'gtags']
      let d = findfile(d, s:escape_file_searching(search_directory) . ';')
      if d !=# ''
        let directory = fnamemodify(d, ':p:h')
        break
      endif
    endfor
  endif

  if directory ==# ''
    " Search /src/ directory.
    let base = search_directory
    if base =~# '/src/'
      let directory = base[: strridx(base, '/src/') + 3]
    endif
  endif

  if directory ==# '' && !is_allow_empty
    " Use original path.
    let directory = search_directory
  endif

  return directory
endfunction

function! s:get_buffer_directory(bufnr) abort
  return s:path2directory(bufname(a:bufnr))
endfunction

function! s:expand(path) abort
  return (a:path =~ '^\~') ? fnamemodify(a:path, ':p') :
       \ (a:path =~ '^\$\h\w*') ? substitute(a:path,
       \            '^\$\h\w*', '\=eval(submatch(0))', '') :
       \ a:path
endfunction

function! s:parse_source_path(path) abort
  " Expand ?!/buffer_project_subdir, !/project_subdir and ?/buffer_subdir
  if a:path =~ '^?!'
    " Use project directory from buffer directory
    let path = rubix#project_dir() . a:path[2:]
  elseif a:path =~ '^!'
    " Use project directory from cwd
    let path = getcwd()
    let path = s:path2project_directory(path) . a:path[1:]
  elseif a:path =~ '^?'
    " Use buffer directory
    let path = rubix#buffer_dir() . a:path[1:]
  else
    let path = a:path
  endif

  " Don't assume empty path means current directory.
  " Let the sources customize default rules.
  if path != ''
    let pathlist = path =~ "\n" ? split(path, "\n") : [path]
    for pathitem in pathlist
      " resolve .. in the paths
      let pathitem = resolve(fnamemodify(s:expand(pathitem), ':p'))
    endfor
    let path = join(pathlist, "\n")
  endif

  return path
endfunction

function! rubix#preserve(command)
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

function! rubix#mkdir(dir, force)
  if !isdirectory(a:dir) && &l:buftype == '' &&
        \ (a:force || input(printf('"%s" does not exist. Create? [y/N]',
        \              a:dir)) =~? '^y\%[es]$')
    call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
  endif
endfunction

function! rubix#auto_trim()
  if exists('b:auto_strip_trailing_whitespace')
    call rubix#trim()
  endif
endfunction

function! rubix#trim()
  call rubix#preserve("%s/\\s\\+$//e")
endfunction

function! rubix#maximize_toggle()
  let curpos = getcurpos()
  if exists('s:maximized')
    tabclose
    unlet s:maximized
  else
    tabedit %
    let s:maximized = 1
  endif
  call setpos(".", curpos)
endfunction

function! rubix#only()
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

function! rubix#neosnippet_cr()
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

function! rubix#ultisnips_tab()
  if pumvisible()
    return "\<c-n>"
  endif

  call UltiSnips#ExpandSnippetOrJump()
  if g:ulti_expand_or_jump_res != 0
    return ""
  endif

  return "\<tab>"
endfunction

function! rubix#ultisnips_cr()
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

function! rubix#yapf()
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

function! rubix#prettier()
  " preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")

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
  let @/=_s
  call cursor(l, c)
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

function! rubix#update_title()
  if &filetype == 'fzf'
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
function! rubix#kwbd(kwbdStage)
  if(a:kwbdStage == 1)
    if(!buflisted(winbufnr(0)))
      execute ':confirm :bdelete'
      return
    endif

    let s:kwbdBufNum = bufnr("%")
    let s:kwbdWinNum = winnr()
    windo call rubix#kwbd(2)
    execute s:kwbdWinNum . 'wincmd w'
    let s:buflistedLeft = 0
    let s:bufFinalJump = 0
    let l:nBufs = bufnr("$")
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
        let l:newBuf = bufnr("%")
        windo if(buflisted(winbufnr(0))) | execute "b! " . l:newBuf | endif
      endif
      execute s:kwbdWinNum . 'wincmd w'
    endif

    if(buflisted(s:kwbdBufNum) || s:kwbdBufNum == bufnr("%"))
      execute ':confirm :bdelete ' . s:kwbdBufNum
    endif

    if(!s:buflistedLeft)
      set buflisted
      set bufhidden=delete
      set buftype=
      setlocal noswapfile
    endif
  else
    if(bufnr("%") == s:kwbdBufNum)
      let prevbufvar = bufnr("#")
      if(prevbufvar > 0 && buflisted(prevbufvar) && prevbufvar != s:kwbdBufNum)
        b #
      else
        bn
      endif
    endif
  endif
endfunction
