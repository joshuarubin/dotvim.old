function! rubix#cursor_word()
  return expand('<cword>')
endfunction

function! rubix#current_dir()
  return &filetype ==# 'vimfiler' ?
    \ b:vimfiler.current_dir :
    \ fnamemodify(getcwd(), ':p')
endfunction

function! rubix#buffer_dir()
  return s:get_buffer_directory(bufnr('%'))
endfunction

function! rubix#project_dir()
  let path = &filetype ==# 'vimfiler' ?
    \ b:vimfiler.current_dir :
    \ rubix#buffer_dir()
  return s:path2project_directory(path)
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
  let filetype = getbufvar(a:bufnr, '&filetype')
  if filetype ==# 'vimfiler'
    let dir = getbufvar(a:bufnr, 'vimfiler').current_dir
  elseif filetype ==# 'vimshell'
    let dir = getbufvar(a:bufnr, 'vimshell').current_dir
  elseif filetype ==# 'vinarise'
    let dir = getbufvar(a:bufnr, 'vinarise').current_dir
  else
    let path = bufname(a:bufnr)
    let dir = s:path2directory(path)
  endif

  return dir
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
    let path = &filetype ==# 'vimfiler' ?
          \ b:vimfiler.current_dir :
          \ getcwd()
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
