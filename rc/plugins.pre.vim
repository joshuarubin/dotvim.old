" settings before plugins are loaded

" neocomplete + neosnippet + neosnippet-snippets requires lua
" youcompleteme + ultisnips is the fallback without lua
" nvim defaults to deoplete

let g:rubix_complete = ''
let g:rubix_snippet = ''
let g:rubix_shougo = 0

if has('nvim') && has('python3')
  let g:rubix_complete = 'deoplete'
  let g:rubix_snippet  = 'neosnippet'
  let g:rubix_shougo   = 1
elseif has('lua') && (v:version > 703 || v:version == 703 && has('patch885'))
  let g:rubix_complete = 'neocomplete'
  let g:rubix_snippet  = 'neosnippet'
  let g:rubix_shougo   = 1
elseif (v:version > 703 || (v:version == 703 && has("patch598"))) && has("python")
  let g:rubix_complete = 'youcompleteme'
  let g:rubix_snippet  = 'ultisnips'
endif

let g:rubix_syntax = 'syntastic'
if has("nvim")
  let g:rubix_syntax = 'neomake'
elseif v:version >= 800 && (v:version > 800 || has("patch0027"))
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

let g:rubix_rust_racer = 0
if executable('racer') && !empty($RUST_SRC_PATH)
  let g:rubix_rust_racer = 1
endif

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
let g:lua_check_syntax = 0 " done via syntastic
let g:lua_define_omnifunc = 0 " must be enabled also (g:lua_complete_omni=1, but crashes Vim!)
let g:lua_complete_omni = 0
let g:lua_complete_dynamic = 0 " interferes with YouCompleteMe

" vimpager
let g:vimpager = {}
let g:vimpager.passthrough = 0
let g:no_cecutil_maps = 1

" startify
let g:startify_session_dir = rubix#cache#dir("sessions")
let g:startify_change_to_vcs_root = 1
let g:startify_show_sessions = 1
let g:startify_session_persistence = 1

" quickrun
let g:quickrun_config = {}
let g:quickrun_config.markdown = {
  \ "outputter": "null",
  \ "command":   "open",
  \ "cmdopt":    "-a",
  \ "args":      shellescape("Marked 2"),
  \ "exec":      "%c %o %a %s",
  \ }

" python-mode
let g:pymode_folding  = 0
let g:pymode_lint     = 0
let g:pymode_options  = 0
let g:pymode_rope     = 0  " disable to fix conflict with jedi
let g:pymode_doc_bind = "" " disable, use jedi instead

" jedi
let g:jedi#popup_on_dot           = 0
let g:jedi#use_splits_not_buffers = "bottom"
let g:jedi#completions_enabled    = 0
let g:jedi#goto_command             = "gd"        " change from <leader>d
let g:jedi#usages_command           = ""          " don't collide with <leader>n :nohlsearch
let g:jedi#rename_command           = "<leader>e" " change from <leader>r to not collide with :PymodeRun
let g:jedi#documentation_command    = ""          " use dash instead (for <leader>d and K)
let g:jedi#goto_assignments_command = "<leader>g" " default

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
  \ "ctagstype" : "go",
  \ "kinds"     : [  "p:package", "i:imports", "c:constants", "v:variables",
    \ "t:types",  "n:interfaces", "w:fields", "e:embedded", "m:methods",
    \ "r:constructor", "f:functions" ],
  \ "sro" : ".",
  \ "kind2scope" : { "t" : "ctype", "n" : "ntype" },
  \ "scope2kind" : { "ctype" : "t", "ntype" : "n" },
  \ "ctagsbin"  : "gotags",
  \ "ctagsargs" : "-sort -silent"
  \ }
let g:tagbar_autofocus = 1
let g:tagbar_autoclose = 1

" youcompleteme
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_key_list_select_completion = []
let g:ycm_key_list_previous_completion = []
let g:ycm_semantic_triggers =  {
  \   "c":          ["->", "."],
  \   "objc":       ["->", "."],
  \   "ocaml":      [".", "#"],
  \   "cpp,objcpp": ["->", ".", "::"],
  \   "perl":       ["->"],
  \   "php":        ["->", "::"],
  \   "cs,java,javascript,d,python,perl6,scala,vb,elixir,go": ["."],
  \   "vim":        ["re![_a-zA-Z]+[_\w]*\."],
  \   "ruby":       [".", "::"],
  \   "lua":        [".", ":"],
  \   "erlang":     [":"],
  \   "haskell":    ["."],
  \ }

" neocomplete
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#enable_auto_delimiter = 1
let g:neocomplete#data_directory=rubix#cache#dir("neocomplete")
let g:neocomplete#auto_completion_start_length = 1
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
let g:neocomplete#sources#omni#input_patterns.php  = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
let g:neocomplete#sources#omni#input_patterns.c    = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplete#sources#omni#input_patterns.cpp  = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
let g:neocomplete#sources#omni#input_patterns.ruby = '[^. *\t]\.\h\w*\|\h\w*::'

" deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1
let g:deoplete#auto_complete_start_length = 1
if !exists('g:deoplete#keyword_patterns')
    let g:deoplete#keyword_patterns = {}
endif
let g:deoplete#keyword_patterns['default'] = '\h\w*'
if !exists('g:deoplete#omni#input_patterns')
  let g:deoplete#omni#input_patterns = {}
endif
let g:deoplete#omni#input_patterns.php  = '[^. \t]->\h\w*\|\h\w*::'
let g:deoplete#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
let g:deoplete#omni#input_patterns.c    = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:deoplete#omni#input_patterns.cpp  = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
let g:deoplete#omni#input_patterns.ruby = '[^. *\t]\.\h\w*\|\h\w*::'
let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']
let g:deoplete#sources#go#align_class = 1

" neosnippet
let g:neosnippet#data_directory = rubix#cache#dir("neosnippet")
let g:neosnippet#enable_snipmate_compatibility = 1

" ultisnips
let g:UltiSnipsExpandTrigger = "<c-k>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"

" netrw
let g:netrw_winsize = -30 " absolute width of netrw window
let g:netrw_banner = 0 " do not display info on the top of window
let g:netrw_liststyle = 3 " tree-view
let g:netrw_preview = 1 " show previews in vertical split
let g:netrw_alto = 0 " split below
let g:netrw_browse_split = 4 " use the previous window to open file
let g:netrw_sort_sequence = '[\/]$,*,\%(' . join(map(split(&suffixes, ','), 'escape(v:val, ".*$~")'), '\|') . '\)[*@]\=$'
let s:dotfiles = '\(^\|\s\s\)\zs\.\S\+'
let s:escape = 'substitute(escape(v:val, ".$~"), "*", ".*", "g")'
let g:netrw_list_hide =
      \ s:dotfiles .
      \ ',' . join(map(split(&wildignore, ','), '"^".' . s:escape . '. "$"'), ',') .
      \ ',^\.\.\=/\=$' .
      \ ',' . netrw_gitignore#Hide()
let g:netrw_home=rubix#cache#dir("netrw")

" indentLine
let g:indentLine_setColors = 0
let g:indentLine_char = '│'
let g:indentLine_first_char = '│'
let g:indentLine_setConceal = 0
let g:indentLine_showFirstIndentLevel = 1
let g:indentLine_fileTypeExclude = ['help', 'man']

" load larger plugin specific configuration
for f in split(glob('~/.vim/rc/plugins/*.vim'), '\n')
  execute 'source' fnameescape(f)
endfor
