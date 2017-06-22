" settings before plugins are loaded

scriptencoding utf-8

let g:rubix_complete = ''
let g:rubix_snippet = ''
let g:rubix_shougo = 0

if (has('nvim') || v:version >= 800) && (has('python') || has('python3'))
  let g:rubix_complete = 'ncm'
  let g:rubix_snippet  = 'neosnippet'
  let g:rubix_shougo   = 1
endif

let g:rubix_syntax = ''
if has('nvim')
  let g:rubix_syntax = 'neomake'
elseif v:version >= 800 && (v:version > 800 || has('patch0027'))
  let g:rubix_syntax = 'neomake'
endif

let g:rubix_jedi = 0
if has('python')
  let g:rubix_jedi = 1
endif

let g:rubix_python_mode = 0
if has('python') || has('python3')
  let g:rubix_python_mode = 1
endif

let g:racer_experimental_completer = 1

if has('nvim')
  autocmd MyAutoCmd TermOpen term://* set winfixheight
endif

" plugin specific configuration that is too short to justify its own file

" endwise (called via snippets)
let g:endwise_no_mappings = 1

" colorizer
let g:colorizer_auto_filetype='css,html,javascript,javascript.jsx'

" echodoc
let g:echodoc_enable_at_startup = 0

" hybrid
let g:hybrid_reduced_contrast = 1

" neco-ghc
let g:haskellmode_completion_ghc = 0

" vim-polyglot
let g:jsx_ext_required = 0
let g:rustfmt_autosave = 1

" undotree
let g:undotree_SetFocusWhenToggle=1

" gitgutter
let g:gitgutter_enabled = 0

" vim-lua
let g:lua_check_syntax = 0 " done via neomake
let g:lua_define_omnifunc = 0 " must be enabled also (g:lua_complete_omni=1, but crashes Vim!)
let g:lua_complete_omni = 0
let g:lua_complete_dynamic = 0 " interferes with completion

" vimpager
let g:vimpager = {}
let g:vimpager.passthrough = 0
let g:no_cecutil_maps = 1

" startify
let g:startify_session_dir = rubix#cache#dir('sessions')
let g:startify_show_sessions = 1
let g:startify_session_persistence = 1
let g:startify_change_to_vcs_root = 1
let g:startify_update_oldfiles = 1
let g:startify_session_sort = 1

" quickrun
let g:quickrun_config = {}
let g:quickrun_config.markdown = {
  \ 'outputter': 'null',
  \ 'command':   'open',
  \ 'cmdopt':    '-a',
  \ 'args':      shellescape('Marked 2'),
  \ 'exec':      '%c %o %a %s',
  \ }

" python-mode
let g:pymode_folding  = 0
let g:pymode_lint     = 0
let g:pymode_options  = 0
let g:pymode_rope     = 0  " disable to fix conflict with jedi
let g:pymode_doc_bind = '' " disable, use jedi instead

" jedi

if g:rubix_complete ==# 'ncm'
  let g:jedi#popup_on_dot        = 0
  let g:jedi#completions_enabled = 0
endif

" python-support
if g:rubix_complete ==# 'ncm'
  " for python completions
  let g:python_support_python3_requirements = add(get(g:,'python_support_python3_requirements',[]),'jedi')

  " language specific completions on markdown file
  let g:python_support_python3_requirements = add(get(g:,'python_support_python3_requirements',[]),'mistune')

  " utils, optional
  let g:python_support_python3_requirements = add(get(g:,'python_support_python3_requirements',[]),'psutil')
  let g:python_support_python3_requirements = add(get(g:,'python_support_python3_requirements',[]),'setproctitle')
endif

let g:jedi#use_splits_not_buffers   = 'right'
let g:jedi#goto_command             = 'gd'        " change from <leader>d
let g:jedi#usages_command           = ''          " don't collide with <leader>n :nohlsearch
let g:jedi#rename_command           = '<leader>e' " change from <leader>r to not collide with :PymodeRun
let g:jedi#documentation_command    = ''          " use dash instead (for <leader>d and K)
let g:jedi#goto_assignments_command = '<leader>g' " default
let g:jedi#show_call_signatures     = '2'

" fugitive
" delete fugitive buffers when they are left
autocmd MyAutoCmd BufReadPost fugitive://* set bufhidden=delete
" map .. to go to the parent directory
autocmd MyAutoCmd User fugitive
  \ if fugitive#buffer().type() =~# '^\%(tree\|blob\)$' |
  \   nnoremap <silent> <buffer> .. :edit %:h<cr> |
  \ endif
let g:fugitive_git_executable = "env GIT_SSH_COMMAND='ssh -o ControlPersist=no' git"

" tagbar
" if using go please install the gotags program using the following
" go install github.com/jstemmer/gotags
" and make sure gotags is in your path
let g:tagbar_type_go = {
  \ 'ctagstype' : 'go',
  \ 'kinds'     : [  'p:package', 'i:imports', 'c:constants', 'v:variables',
    \ 't:types',  'n:interfaces', 'w:fields', 'e:embedded', 'm:methods',
    \ 'r:constructor', 'f:functions' ],
  \ 'sro' : '.',
  \ 'kind2scope' : { 't' : 'ctype', 'n' : 'ntype' },
  \ 'scope2kind' : { 'ctype' : 't', 'ntype' : 'n' },
  \ 'ctagsbin'  : 'gotags',
  \ 'ctagsargs' : '-sort -silent'
  \ }
let g:tagbar_autofocus = 1
let g:tagbar_autoclose = 1

" neosnippet
let g:neosnippet#data_directory = rubix#cache#dir('neosnippet')
let g:neosnippet#enable_snipmate_compatibility = 1
autocmd MyAutoCmd InsertLeave * NeoSnippetClearMarkers

" netrw
let g:netrw_winsize = -30 " absolute width of netrw window
let g:netrw_banner = 0 " do not display info on the top of window
let g:netrw_liststyle = 3 " tree-view
let g:netrw_preview = 1 " show previews in vertical split
let g:netrw_alto = 0 " split below
let g:netrw_browse_split = 4 " use the previous window to open file
let g:netrw_sort_sequence = '[\/]$,*,\%(' . join(map(split(&suffixes, ','), 'escape(v:val, ''.*$~'')'), '\|') . '\)[*@]\=$'
let s:dotfiles = '\(^\|\s\s\)\zs\.\S\+'
let s:escape = 'substitute(escape(v:val, ''.$~''), ''*'', ''.*'', ''g'')'
let g:netrw_list_hide =
      \ s:dotfiles .
      \ ',' . join(map(split(&wildignore, ','), '''^''.' . s:escape . '. ''$'''), ',') .
      \ ',^\.\.\=/\=$' .
      \ ',' . netrw_gitignore#Hide()
let g:netrw_home=rubix#cache#dir('netrw')

" indentLine
let g:indentLine_setColors = 0
let g:indentLine_char = '│'
let g:indentLine_first_char = '│'
let g:indentLine_setConceal = 0
let g:indentLine_showFirstIndentLevel = 1
let g:indentLine_fileTypeExclude = ['help', 'man']
let g:indentLine_bufNameExclude = ['^term:\/\/.*']

" load larger plugin specific configuration
execute 'runtime!' 'rc/plugins/*.vim'
